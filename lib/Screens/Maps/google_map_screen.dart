import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Maps/model/place_model.dart';
import 'package:newfolder/Screens/Maps/repoapi.dart';

Color color = const Color(0xfffe8903);

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen>
    with WidgetsBindingObserver {
  BitmapDescriptor? currentLocation;
  TextEditingController placeController = TextEditingController();

  TextEditingController SearchEditTextController = TextEditingController();

  late final GoogleMapController _controller;
  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  bool openedSettings = false;

  String name = '';
  String street = '';
  String thoroughfare = '';
  String subThoroughfare = '';
  String city = ''; // Locality
  String subLocality = '';
  String state = '';
  String subAdminArea = '';
  String postalCode = '';
  String country = '';
  String isoCountryCode = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // getLocation();
    _checkPermissionAndGetLocation();
    // showBottomSheetforAddressDisplay();
    // Timer(Duration(seconds: 5), () {
    //   showBottomSheetforAddressDisplay();
    // });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && openedSettings) {
      openedSettings = false;
      // getLocation(); // Retry getting location when user returns
      _checkPermissionAndGetLocation();
    }
  }

  Future<void> _checkPermissionAndGetLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied');
        Navigator.of(context).pop();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool openSettings = await _showOpenSettingsDialog();
      if (openSettings) {
        openedSettings = true;
        await Geolocator.openAppSettings();
      } else {
        Navigator.of(context).pop();
      }
      return;
    }

    // Permission granted: get location
    await getLocation();
  }

  Future<bool> _showOpenSettingsDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Permission Needed'),
            content: const Text(
                'Location permission is permanently denied. Please open settings to grant permission.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Open Settings'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> getLocation() async {
    // print("getLocation >>>>");
    // LocationPermission permission = await Geolocator.checkPermission();
    // print("after permission ");
    //
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     print('Location permission denied');
    //     return;
    //   }
    // }
    //
    // if (permission == LocationPermission.deniedForever) {
    //   print('Location permissions are permanently denied.');
    //   openedSettings = true;
    //   await Geolocator.openAppSettings();
    //   return;
    // }

    // Permissions are granted at this point
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("_currentPosition : $_currentPosition");

      _currentLatLng =
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        print('Name: ${place.name}');
        print('Street: ${place.street}');
        print('Locality (City): ${place.locality}');
        print('SubLocality: ${place.subLocality}');
        print('Administrative Area (State): ${place.administrativeArea}');
        print('Country: ${place.country}');
        print('Postal Code: ${place.postalCode}');

        name = place.name ?? '';
        street = place.street ?? '';
        thoroughfare = place.thoroughfare ?? '';
        subThoroughfare = place.subThoroughfare ?? '';
        city = place.locality ?? ''; // Locality
        subLocality = place.subLocality ?? '';
        state = place.administrativeArea ?? '';
        subAdminArea = place.subAdministrativeArea ?? '';
        postalCode = place.postalCode ?? '';
        country = place.country ?? '';
        isoCountryCode = place.isoCountryCode ?? '';
      }

      setState(() {});
      print('Location updated: $_currentLatLng');

      showBottomSheetforAddressDisplay();
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Widget autoComplete() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.025,
        left: MediaQuery.of(context).size.height * 0.0,
        right: MediaQuery.of(context).size.height * 0.0,
        bottom: MediaQuery.of(context).size.height * 0.00,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.04,
                  width: MediaQuery.of(context).size.height * 0.04,
                  decoration: BoxDecoration(
                    // color: Colors
                    //     .grey[100]!
                    //     .withOpacity(
                    //     0.9),
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: Color(0xFF000000),
                    size: MediaQuery.of(context).size.height * 0.02,
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.height * 0.01),
              // Add spacing between widgets
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.005,
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: TypeAheadFormField<Description?>(
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              // placeController.text =suggestion?.structured_formatting?.main_text ?? "";
                            });
                          },
                          getImmediateSuggestions: true,
                          keepSuggestionsOnLoading: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: placeController,
                            style: TextStyle(
                              color: Color(0xFF1F1F1F),
                              fontWeight: FontWeight.w700,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.017,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left:
                                    MediaQuery.of(context).size.height * 0.025,
                                top: MediaQuery.of(context).size.height * 0.02,
                              ),
                              filled: true,
                              fillColor: Color(0x4DFFFFFF),
                              hintText:
                                  "Search for area, street name, locality...",
                              hintStyle: TextStyle(
                                color: Color(0xFF1F1F1F),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.014,
                                fontWeight: FontWeight.w400,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide:
                                    BorderSide(color: Color(0x4DFFFFFF)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide:
                                    BorderSide(color: Color(0x4DFFFFFF)),
                              ),
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    placeController.clear();
                                    // showBottomSheetforAddressDisplay();
                                  });
                                },
                                child: Icon(
                                  Icons.search,
                                  color: Color(0xFF000000),
                                  size:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                              ),
                            ),
                          ),
                          itemBuilder: (context, Description? itemData) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: Row(
                                children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 18, color: Colors.grey),
                                  SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${itemData?.structured_formatting?.main_text}",
                                          style: const TextStyle(
                                              color: Colors.green),
                                        ),
                                        Text(
                                            "${itemData?.structured_formatting?.secondary_text}"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          noItemsFoundBuilder: (context) {
                            return SizedBox.shrink(); // or show a message
                          },
                          suggestionsCallback: (String pattern) async {
                            var predictionModel = await Repo.placeAutoComplete(
                                placeInput: pattern);

                            if (predictionModel != null) {
                              return predictionModel.predictions!.where(
                                  (element) => element.description!
                                      .toLowerCase()
                                      .contains(pattern.toLowerCase()));
                            } else {
                              return [];
                            }
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget locationsWidget() {
    return Container(
      margin: EdgeInsets.zero,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 1,
              offset: Offset(0, 4))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(
                  width: 8,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: const [
                    Text(
                      "Current Location",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Samakhusi, Rehdon College",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Divider(
                height: 8,
                color: color.withOpacity(0.6),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      border: Border.all(color: color, width: 4),
                      shape: BoxShape.circle),
                ),
                const SizedBox(
                  width: 8,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    const Text(
                      "Destination",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        placeController.text.isEmpty
                            ? "Select Destination"
                            : placeController.text,
                        overflow: TextOverflow.visible,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: _currentPosition == null
            ? const Center(child: CircularProgressIndicator()
                //CircularProgressIndicator(),
                )
            : Stack(
                children: [
                  GoogleMap(
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomControlsEnabled: false,
                    initialCameraPosition:
                        CameraPosition(zoom: 16, target: _currentLatLng),
                    onMapCreated: (controller) async {
                      setState(() {
                        _controller = controller;
                      });
                      // String val = "assets/json/google_map_dark_light.json";
                      String val = "assets/json/google_map_light_theme.json";
                      var c = await rootBundle.loadString(val);
                      _controller.setMapStyle(c);
                    },
                    markers: {
                      Marker(
                          markerId: const MarkerId("1"),
                          // icon: currentLocation!,
                          position: _currentLatLng)
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          autoComplete(),
                          const SizedBox(
                            height: 12,
                          ),
                          /*  locationsWidget(),
                    const Spacer(),
                    confirmButton(),*/
                        ],
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }

  Widget confirmButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size(double.infinity, 40)),
        onPressed: () {
          // _controller.animateCamera(CameraUpdate.newCameraPosition(
          //     const CameraPosition(target: LatLng(0, 0))));
        },
        child: Text(
          "CONFIRM",
          style: GoogleFonts.lato(
            fontSize: 18,
            color: Colors.white,
          ),
        ));
  }

  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  double _currentChildSize = 0.3;
  bool _isDismissed = false;
  double _lastExtent = 0.2;

  void showBottomSheetforAddressDisplay() => showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      // barrierColor: Colors.grey.withOpacity(0.9),
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize:
                _currentChildSize, // Start at 50% of screen height
            minChildSize: 0.3, // Minimum height (30% of screen)
            maxChildSize: 0.9, // Max height (90% of screen)
            expand: false,
            builder: (context, scrollController) {
              return Material(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                child: NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    final currentExtent = notification.extent;

                    // ✅ Hide keyboard when dragging down
                    if (currentExtent < _lastExtent - 0.01) {
                      print("Dragging down - Hiding keyboard");
                      FocusScope.of(context).unfocus();
                    }

                    // ✅ Dismiss the sheet if dragged below threshold
                    if (!_isDismissed &&
                        currentExtent < _currentChildSize - 0.05) {
                      _isDismissed = true;
                      Navigator.of(context).pop(); // Dismiss sheet
                    }

                    _lastExtent = currentExtent;
                    return true;
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      if (_sheetController.isAttached) {
                        final newSize = _sheetController.size -
                            details.primaryDelta! /
                                MediaQuery.of(context).size.height;
                        _sheetController.jumpTo(newSize.clamp(0.4, 0.95));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .viewInsets
                            .bottom, // Adjust for keyboard
                        left: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            controller: scrollController,
                            child: Container(
                              child: Column(
                                children: [
                                  // Divider
                                  GestureDetector(
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.18,
                                        ),

                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        // Same thickness as Divider
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.006,
                                        // Same thickness as Divider
                                        decoration: BoxDecoration(
                                          color: Color(
                                              0xFFD9D9D9), // Divider color
                                          borderRadius: BorderRadius.circular(
                                              10), // Rounded edges
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Select Location
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.0,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                      top: MediaQuery.of(context).size.height *
                                          0.022,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // Center horizontally
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(0),
                                          // No need for individual padding here
                                          child: Text(
                                            "Select Location",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.0,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                      top: MediaQuery.of(context).size.height *
                                          0.022,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      // Center horizontally
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                decoration: BoxDecoration(
                                                  // color: Colors
                                                  //     .grey[100]!
                                                  //     .withOpacity(
                                                  //     0.9),
                                                  color: Colors.transparent,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.location_on_rounded,
                                                  color: Color(0xFF1E6588),
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            Container(
                                              padding: EdgeInsets.all(0),
                                              // No need for individual padding here
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.w700,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.0165,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                            showBottomSheetforAddressChange();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(0),
                                            // No need for individual padding here
                                            child: Text(
                                              "Change",
                                              style: TextStyle(
                                                color: Color(0xFF1E6588),
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0135,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          0.0,
                                      right:
                                          MediaQuery.of(context).size.height *
                                              0.0,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.005,
                                      top: MediaQuery.of(context).size.height *
                                          0.022,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      // Center horizontally
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(0),
                                          // No need for individual padding here
                                          child: Text(
                                            // "Al Luqta, Doha, Qatar",
                                            "${subLocality}, ",
                                            style: TextStyle(
                                              color: Color(0xFF454545),
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(0),
                                          // No need for individual padding here
                                          child: Text(
                                            // "Al Luqta, Doha, Qatar",
                                            "$city, ",
                                            style: TextStyle(
                                              color: Color(0xFF454545),
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(0),
                                          // No need for individual padding here
                                          child: Text(
                                            // "Al Luqta, Doha, Qatar",
                                            "$country, ",
                                            style: TextStyle(
                                              color: Color(0xFF454545),
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.017,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.05,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.012),
                                                      gradient: LinearGradient(
                                                          begin: Alignment
                                                              .centerRight,
                                                          end: Alignment.center,
                                                          stops: [
                                                            0.5,
                                                            0.9
                                                          ],
                                                          colors: [
                                                            Color(0xFF126086),
                                                            Color(0xFF126086),
                                                          ])),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.only(
                                                      left: 0.0),
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                        "Confirm Location",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.015)),
                                                  ),
                                                ),
                                              ),
                                            ])),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      });

  final DraggableScrollableController _sheetController2 =
      DraggableScrollableController();
  double _currentChildSize2 = 0.6;
  bool _isDismissed2 = false;
  double _lastExtent2 = 0.5;

  TextEditingController LandmarkEditTextController = TextEditingController();
  TextEditingController AddressEditTextController = TextEditingController();
  TextEditingController FullnameEditTextController = TextEditingController();
  TextEditingController AddressTitleEditTextController =
      TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  void showBottomSheetforAddressChange() => showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      // barrierColor: Colors.grey.withOpacity(0.9),
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
            controller: _sheetController2,
            initialChildSize:
                _currentChildSize2, // Start at 50% of screen height
            minChildSize: 0.3, // Minimum height (30% of screen)
            maxChildSize: 0.9, // Max height (90% of screen)
            expand: false,
            builder: (context, scrollController) {
              return Material(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                child: NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    final currentExtent2 = notification.extent;

                    // ✅ Hide keyboard when dragging down
                    if (currentExtent2 < _lastExtent2 - 0.01) {
                      print("Dragging down - Hiding keyboard");
                      FocusScope.of(context).unfocus();
                    }

                    // ✅ Dismiss the sheet if dragged below threshold
                    if (!_isDismissed2 &&
                        currentExtent2 < _currentChildSize2 - 0.05) {
                      _isDismissed2 = true;
                      Navigator.of(context).pop(); // Dismiss sheet
                    }

                    _lastExtent = currentExtent2;
                    return true;
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      if (_sheetController2.isAttached) {
                        final newSize = _sheetController2.size -
                            details.primaryDelta! /
                                MediaQuery.of(context).size.height;
                        _sheetController2.jumpTo(newSize.clamp(0.4, 0.95));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .viewInsets
                            .bottom, // Adjust for keyboard
                        left: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Container(
                                child: Column(
                                  children: [
                                    // Divider
                                    GestureDetector(
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                          ),

                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          // Same thickness as Divider
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.006,
                                          // Same thickness as Divider
                                          decoration: BoxDecoration(
                                            color: Color(
                                                0xFFD9D9D9), // Divider color
                                            borderRadius: BorderRadius.circular(
                                                10), // Rounded edges
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Select Location
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.0,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.0,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.005,
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.022,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        // Center horizontally
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(0),
                                            // No need for individual padding here
                                            child: Text(
                                              "Enter the Location Details",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.017,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0x1A126086),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.022,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              // Center horizontally
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.04,
                                                        decoration:
                                                            BoxDecoration(
                                                          // color: Colors
                                                          //     .grey[100]!
                                                          //     .withOpacity(
                                                          //     0.9),
                                                          color: Colors
                                                              .transparent,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons
                                                              .location_on_rounded,
                                                          color:
                                                              Color(0xFF1E6588),
                                                          size: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      // No need for individual padding here
                                                      child: Text(
                                                        name,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF000000),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.0165,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(0),
                                                  // No need for individual padding here
                                                  child: Text(
                                                    "Change",
                                                    style: TextStyle(
                                                      color: Color(0xFF1E6588),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0135,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.022,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              // Center horizontally
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(0),
                                                  // No need for individual padding here
                                                  child: Text(
                                                    "${subLocality}, ",
                                                    style: TextStyle(
                                                      color: Color(0xFF454545),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(0),
                                                  // No need for individual padding here
                                                  child: Text(
                                                    "$city, ",
                                                    style: TextStyle(
                                                      color: Color(0xFF454545),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.all(0),
                                                  // No need for individual padding here
                                                  child: Text(
                                                    "${country}, ",
                                                    style: TextStyle(
                                                      color: Color(0xFF454545),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.017,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: Padding(
                                        padding: new EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.008),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Landmark",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.014,
                                              // color: Colors.black54,
                                              color: Color(0xFF0000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_sheetController2.isAttached) {
                                          await _sheetController2.animateTo(
                                            0.9,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                          // Wait for animation to complete before showing keyboard
                                          Future.delayed(
                                              Duration(milliseconds: 50), () {
                                            _focusNode1.requestFocus();
                                          });
                                        }
                                      },
                                      child: AbsorbPointer(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Focus(
                                                onFocusChange: (hasFocus) {
                                                  if (hasFocus) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                  }
                                                },
                                                child: TextFormField(
                                                  focusNode: _focusNode1,
                                                  controller:
                                                      LandmarkEditTextController,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        100),
                                                  ],
                                                  style: TextStyle(
                                                    color: Color(0xFF171717),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onChanged: (value) {},
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFFFFFFF),
                                                    hintText:
                                                        "House Number / Flat / Block No.",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFF727272),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            0xFFF1F1F1), // Initially grey, turns red or green
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            0xFFF1F1F1), // Initially grey, turns red or green
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      child: Padding(
                                        padding: new EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.008),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Address",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.014,
                                              // color: Colors.black54,
                                              color: Color(0xFF0000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_sheetController2.isAttached) {
                                          await _sheetController2.animateTo(
                                            0.9,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                          // Wait for animation to complete before showing keyboard
                                          Future.delayed(
                                              Duration(milliseconds: 50), () {
                                            _focusNode2.requestFocus();
                                          });
                                        }
                                      },
                                      child: AbsorbPointer(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Focus(
                                                onFocusChange: (hasFocus) {
                                                  if (hasFocus) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                  }
                                                },
                                                child: TextFormField(
                                                  focusNode: _focusNode2,
                                                  controller:
                                                      AddressEditTextController,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        100),
                                                  ],
                                                  style: TextStyle(
                                                    color: Color(0xFF171717),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onChanged: (value) {},
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFFFFFFF),
                                                    hintText:
                                                        "e.g. Near ABC School",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFF727272),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            0xFFF1F1F1), // Initially grey, turns red or green
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            0xFFF1F1F1), // Initially grey, turns red or green
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                child: Padding(
                                                  padding: new EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.008),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Fullname",
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        // color: Colors.black54,
                                                        color:
                                                            Color(0xFF0000000),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Inter",
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (_sheetController2
                                                      .isAttached) {
                                                    await _sheetController2
                                                        .animateTo(
                                                      0.9,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeOut,
                                                    );
                                                    // Wait for animation to complete before showing keyboard
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 50),
                                                        () {
                                                      _focusNode3
                                                          .requestFocus();
                                                    });
                                                  }
                                                },
                                                child: AbsorbPointer(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Focus(
                                                          onFocusChange:
                                                              (hasFocus) {
                                                            if (hasFocus) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                            }
                                                          },
                                                          child: TextFormField(
                                                            focusNode:
                                                                _focusNode3,
                                                            controller:
                                                                FullnameEditTextController,
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(
                                                                  100),
                                                            ],
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF171717),
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.014,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            onChanged:
                                                                (value) {},
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFFFFFFF),
                                                              hintText: "",
                                                              hintStyle: TextStyle(
                                                                  color: Color(
                                                                      0xFF727272),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.014,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFF1F1F1), // Initially grey, turns red or green
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFF1F1F1), // Initially grey, turns red or green
                                                                ),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Colors
                                                                            .red),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Colors
                                                                            .red),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.01),
                                                child: Padding(
                                                  padding: new EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.0,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.008),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Address Title",
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        // color: Colors.black54,
                                                        color:
                                                            Color(0xFF0000000),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: "Inter",
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (_sheetController2
                                                      .isAttached) {
                                                    await _sheetController2
                                                        .animateTo(
                                                      0.9,
                                                      duration: Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeOut,
                                                    );
                                                    // Wait for animation to complete before showing keyboard
                                                    Future.delayed(
                                                        Duration(
                                                            milliseconds: 50),
                                                        () {
                                                      _focusNode4
                                                          .requestFocus();
                                                    });
                                                  }
                                                },
                                                child: AbsorbPointer(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      right:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.005,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Focus(
                                                          onFocusChange:
                                                              (hasFocus) {
                                                            if (hasFocus) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                            }
                                                          },
                                                          child: TextFormField(
                                                            focusNode:
                                                                _focusNode4,
                                                            controller:
                                                                AddressTitleEditTextController,
                                                            inputFormatters: [
                                                              LengthLimitingTextInputFormatter(
                                                                  100),
                                                            ],
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF171717),
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.014,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .emailAddress,
                                                            onChanged:
                                                                (value) {},
                                                            decoration:
                                                                InputDecoration(
                                                              isDense: true,
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.012,
                                                              ),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFFFFFFF),
                                                              hintText:
                                                                  "e.g. Home",
                                                              hintStyle: TextStyle(
                                                                  color: Color(
                                                                      0xFF727272),
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.014,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFF1F1F1), // Initially grey, turns red or green
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFFF1F1F1), // Initially grey, turns red or green
                                                                ),
                                                              ),
                                                              errorBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Colors
                                                                            .red),
                                                              ),
                                                              focusedErrorBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                        color: Colors
                                                                            .red),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //  reset

                                              //  login
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius: BorderRadius.circular(MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.012),
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .centerRight,
                                                                        end: Alignment
                                                                            .center,
                                                                        stops: [
                                                                          0.5,
                                                                          0.9
                                                                        ],
                                                                        colors: [
                                                                          Color(
                                                                              0xFF126086),
                                                                          Color(
                                                                              0xFF126086),
                                                                        ])),
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0.0),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                showBottomSheetforShowNoContent();
                                                              },
                                                              child: Text(
                                                                  "Save Address",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFFFFFFFF),
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015)),
                                                            ),
                                                          ),
                                                        ),
                                                      ])),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      });

  final DraggableScrollableController _sheetController3 =
      DraggableScrollableController();
  double _currentChildSize3 = 0.5;
  bool _isDismissed3 = false;
  double _lastExtent3 = 0.4;
  TextEditingController CityAreasEditTextController = TextEditingController();
  final FocusNode _focusNode5 = FocusNode();
  void showBottomSheetforShowNoContent() => showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Colors.white,
      // barrierColor: Colors.grey.withOpacity(0.9),
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
            controller: _sheetController3,
            initialChildSize:
                _currentChildSize3, // Start at 50% of screen height
            minChildSize: 0.3, // Minimum height (30% of screen)
            maxChildSize: 0.9, // Max height (90% of screen)
            expand: false,
            builder: (context, scrollController) {
              return Material(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15),
                child: NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    final currentExtent3 = notification.extent;

                    // ✅ Hide keyboard when dragging down
                    if (currentExtent3 < _lastExtent3 - 0.01) {
                      print("Dragging down - Hiding keyboard");
                      FocusScope.of(context).unfocus();
                    }

                    // ✅ Dismiss the sheet if dragged below threshold
                    if (!_isDismissed3 &&
                        currentExtent3 < _currentChildSize3 - 0.05) {
                      _isDismissed3 = true;
                      Navigator.of(context).pop(); // Dismiss sheet
                    }

                    _lastExtent3 = currentExtent3;
                    return true;
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onVerticalDragUpdate: (details) {
                      if (_sheetController3.isAttached) {
                        final newSize = _sheetController3.size -
                            details.primaryDelta! /
                                MediaQuery.of(context).size.height;
                        _sheetController3.jumpTo(newSize.clamp(0.4, 0.95));
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .viewInsets
                            .bottom, // Adjust for keyboard
                        left: MediaQuery.of(context).size.height * 0.02,
                        top: MediaQuery.of(context).size.height * 0.01,
                        right: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Container(
                                child: Column(
                                  children: [
                                    // Divider
                                    GestureDetector(
                                      child: Center(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                          ),

                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.23,
                                          // Same thickness as Divider
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.006,
                                          // Same thickness as Divider
                                          decoration: BoxDecoration(
                                            color: Color(
                                                0xFFD9D9D9), // Divider color
                                            borderRadius: BorderRadius.circular(
                                                10), // Rounded edges
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.015,
                                          right:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.00,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                      child: Stack(
                                        children: [
                                          // Center image
                                          Center(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.00,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        130.0),
                                                child: Image.asset(
                                                  'assets/insurancealert.png',
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1, // Adjust height
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.1, // Adjust width
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      child: Column(children: [
                                        Text(
                                          "Sorry! We aren’t there yet.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.017,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                          child: Text(
                                            "We’re increasing our operational areas everyday. We will notify you when we start operations in your area.",
                                            style: TextStyle(
                                              height: 1.8,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.012,
                                              color: Color(0xFF6A6E83),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ]),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02),
                                      child: Padding(
                                        padding: new EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.008),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "City and Area",
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.014,
                                              // color: Colors.black54,
                                              color: Color(0xFF0000000),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_sheetController3.isAttached) {
                                          await _sheetController3.animateTo(
                                            0.9,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                          // Wait for animation to complete before showing keyboard
                                          Future.delayed(
                                              Duration(milliseconds: 50), () {
                                            _focusNode5.requestFocus();
                                          });
                                        }
                                      },
                                      child: AbsorbPointer(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Focus(
                                                onFocusChange: (hasFocus) {
                                                  if (hasFocus) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                  }
                                                },
                                                child: TextFormField(
                                                  focusNode: _focusNode5,
                                                  controller:
                                                      CityAreasEditTextController,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        100),
                                                  ],
                                                  style: TextStyle(
                                                    color: Color(0xFF171717),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onChanged: (value) {},
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.02,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.012,
                                                    ),
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFFFFFFF),
                                                    hintText:
                                                        "Enter city & areas",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFF727272),
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.014,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            0xFFF1F1F1), // Initially grey, turns red or green
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                        color: Color(
                                                            0xFFF1F1F1), // Initially grey, turns red or green
                                                      ),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.00,
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              //  reset

                                              //  login
                                              Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .black,
                                                                    borderRadius: BorderRadius.circular(MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.012),
                                                                    gradient: LinearGradient(
                                                                        begin: Alignment
                                                                            .centerRight,
                                                                        end: Alignment
                                                                            .center,
                                                                        stops: [
                                                                          0.5,
                                                                          0.9
                                                                        ],
                                                                        colors: [
                                                                          Color(
                                                                              0xFF126086),
                                                                          Color(
                                                                              0xFF126086),
                                                                        ])),
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0.0),
                                                            child: TextButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .push(
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return HomePageMain();
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                  "Back to Home",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFFFFFFFF),
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.015)),
                                                            ),
                                                          ),
                                                        ),
                                                      ])),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      });
}
