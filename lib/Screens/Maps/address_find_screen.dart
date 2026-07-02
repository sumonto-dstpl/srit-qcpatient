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
import 'package:newfolder/Screens/Utils/customNotification.dart';

Color color = const Color(0xfffe8903);

class AddressFindScreen extends StatefulWidget {
  const AddressFindScreen({super.key});

  @override
  State<AddressFindScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<AddressFindScreen> with WidgetsBindingObserver {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BitmapDescriptor? currentLocation;
  TextEditingController placeController = TextEditingController();

  TextEditingController SearchEditTextController = TextEditingController();

  late final GoogleMapController _controller;
  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  final DraggableScrollableController _sheetController =
  DraggableScrollableController();
  double _currentChildSize = 0.3;
  bool _isDismissed = false;
  double _lastExtent = 0.2;

  final DraggableScrollableController _sheetController2 = DraggableScrollableController();
  double _currentChildSize2 = 0.6;
  bool _isDismissed2 = false;
  double _lastExtent2 = 0.5;

  TextEditingController LandmarkEditTextController = TextEditingController();
  TextEditingController AddressEditTextController = TextEditingController();
  TextEditingController FullnameEditTextController = TextEditingController();
  TextEditingController AddressTitleEditTextController = TextEditingController();


  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  final DraggableScrollableController _sheetController3 = DraggableScrollableController();

  double _currentChildSize3 = 0.5;
  bool _isDismissed3 = false;
  double _lastExtent3 = 0.4;

  TextEditingController CityAreasEditTextController = TextEditingController();
  final FocusNode _focusNode5 = FocusNode();

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

    _checkPermissionAndGetLocation();

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

      showBottomSheetforShowNoContent();
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
                      // child: TypeAheadFormField<Description?>(
                      //   onSuggestionSelected: (suggestion) {
                      //     setState(() {
                      //       // placeController.text =suggestion?.structured_formatting?.main_text ?? "";
                      //     });
                      //   },
                      //   getImmediateSuggestions: true,
                      //   keepSuggestionsOnLoading: true,
                      //   textFieldConfiguration: TextFieldConfiguration(
                      //     controller: placeController,
                      //     style: TextStyle(
                      //       color: Color(0xFF1F1F1F),
                      //       fontWeight: FontWeight.w700,
                      //       fontSize:
                      //           MediaQuery.of(context).size.height * 0.017,
                      //     ),
                      //     decoration: InputDecoration(
                      //       isDense: true,
                      //       contentPadding: EdgeInsets.only(
                      //         left:
                      //             MediaQuery.of(context).size.height * 0.025,
                      //         top: MediaQuery.of(context).size.height * 0.02,
                      //       ),
                      //       filled: true,
                      //       fillColor: Color(0x4DFFFFFF),
                      //       hintText:
                      //           "Search for area, street name, locality...",
                      //       hintStyle: TextStyle(
                      //         color: Color(0xFF1F1F1F),
                      //         fontSize:
                      //             MediaQuery.of(context).size.height * 0.014,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(12.0),
                      //         borderSide:
                      //             BorderSide(color: Color(0x4DFFFFFF)),
                      //       ),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(12.0),
                      //         borderSide:
                      //             BorderSide(color: Color(0x4DFFFFFF)),
                      //       ),
                      //       suffixIcon: InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             placeController.clear();
                      //             // showBottomSheetforAddressDisplay();
                      //           });
                      //         },
                      //         child: Icon(
                      //           Icons.search,
                      //           color: Color(0xFF000000),
                      //           size:
                      //               MediaQuery.of(context).size.height * 0.03,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   itemBuilder: (context, Description? itemData) {
                      //     return Container(
                      //       margin: const EdgeInsets.symmetric(
                      //           horizontal: 8, vertical: 6),
                      //       child: Row(
                      //         children: [
                      //           const Icon(Icons.location_on_outlined,
                      //               size: 18, color: Colors.grey),
                      //           SizedBox(width: 6),
                      //           Expanded(
                      //             child: Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   "${itemData?.structured_formatting?.main_text}",
                      //                   style: const TextStyle(
                      //                       color: Colors.green),
                      //                 ),
                      //                 Text(
                      //                     "${itemData?.structured_formatting?.secondary_text}"),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      //   noItemsFoundBuilder: (context) {
                      //     return SizedBox.shrink(); // or show a message
                      //   },
                      //   suggestionsCallback: (String pattern) async {
                      //     var predictionModel = await Repo.placeAutoComplete(
                      //         placeInput: pattern);
                      //
                      //     if (predictionModel != null) {
                      //       return predictionModel.predictions!.where(
                      //           (element) => element.description!
                      //               .toLowerCase()
                      //               .contains(pattern.toLowerCase()));
                      //     } else {
                      //       return [];
                      //     }
                      //   },
                      // )
                    ),
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
      key: _scaffoldKey,
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
              initialCameraPosition:CameraPosition(zoom: 16, target: _currentLatLng),

              onMapCreated: (controller) async {
                setState(() {
                  _controller = controller;
                });
                String val = "assets/json/google_map_light_theme.json";
                var c = await rootBundle.loadString(val);
                _controller.setMapStyle(c);
              },
// Yahan onTap add karein
              onTap: (LatLng tappedLatLng) async {
                try {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    tappedLatLng.latitude,
                    tappedLatLng.longitude,
                  );

                  if (placemarks.isNotEmpty) {
                    Placemark place = placemarks.first;

                    setState(() {
                      // Update the marker position
                      _currentLatLng = tappedLatLng;

                      // Update location variables
                      name = place.name ?? '';
                      street = place.street ?? '';
                      thoroughfare = place.thoroughfare ?? '';
                      subThoroughfare = place.subThoroughfare ?? '';
                      city = place.locality ?? '';
                      subLocality = place.subLocality ?? '';
                      state = place.administrativeArea ?? '';
                      subAdminArea = place.subAdministrativeArea ?? '';
                      postalCode = place.postalCode ?? '';
                      country = place.country ?? '';
                      isoCountryCode = place.isoCountryCode ?? '';

                      // Controllers me auto-fill values daalein
                      LandmarkEditTextController.text = name.isNotEmpty ? name : street;

                      // Address ko format karke daalein (excluding empty fields)
                      AddressEditTextController.text = [subLocality, city, state, postalCode]
                          .where((element) => element.isNotEmpty)
                          .join(', ');
                    });
                  }
                } catch (e) {
                  print('Error on map tap: $e');
                }
              },
              markers: {
                Marker(
                  markerId: const MarkerId("1"),
                  position: _currentLatLng, // Marker current map tap position par aayega
                )
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

  void showBottomSheetforShowNoContent() {
    showModalBottomSheet(
      enableDrag: false, // Ye manually drag ko disable kar dega
      isScrollControlled: true, // Keyboard aane par sheet ko stretch hone allow karta hai
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) {
            if (didPop) {
              return;
            }
            Navigator.pop(context); // 1. Ye BottomSheet ko close karega
            Navigator.pop(context); // 2. Ye piche wali screen ko close karega
          },
          child: Padding(
            // SABSE ZARURI LINE: Ye keyboard aane par automatic padding add karke sheet ko top par dhakel dega
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.02,
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.04,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Content ke hisaab se height lega
                  children: [
                    // Handle line (Top Divider)
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          bottom: MediaQuery.of(context).size.height * 0.02,
                        ),
                        width: MediaQuery.of(context).size.width * 0.23,
                        height: MediaQuery.of(context).size.height * 0.006,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // Center Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(130.0),
                      child: Image.asset(
                        'assets/insurancealert.png',
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.height * 0.1,
                        fit: BoxFit.fill,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    // Title Text
                    Text(
                      "Sorry! We aren’t there yet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.017,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      ),
                    ),

                    // Description Text
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.height * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Text(
                        "We’re increasing our operational areas everyday. We will notify you when we start operations in your area.",
                        style: TextStyle(
                          height: 1.8,
                          fontSize: MediaQuery.of(context).size.height * 0.012,
                          color: const Color(0xFF6A6E83),
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                    // Input Label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "City and Area",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),

                    // TextField
                    TextFormField(
                      focusNode: _focusNode5,
                      controller: CityAreasEditTextController,
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      style: TextStyle(
                        color: const Color(0xFF171717),
                        fontSize: MediaQuery.of(context).size.height * 0.014,
                        fontWeight: FontWeight.w400,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.015,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFFFFFFF),
                        hintText: "Enter city & areas",
                        hintStyle: TextStyle(
                          color: const Color(0xFF727272),
                          fontSize: MediaQuery.of(context).size.height * 0.014,
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
                        ),
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                    // Back to Home Button
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.height * 0.012,
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.center,
                          colors: [Color(0xFF126086), Color(0xFF126086)],
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>  HomePageMain(), // Make sure HomePageMain is imported properly
                            ),
                          );
                        },
                        child: Text(
                          "Back to Home",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: MediaQuery.of(context).size.height * 0.015,
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
      },
    );
  }


}