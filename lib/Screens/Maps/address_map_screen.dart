import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newfolder/Screens/Home/homemainscreen.dart';
import 'package:newfolder/Screens/Maps/address_find_screen.dart';
import 'package:newfolder/Screens/Maps/model/place_model.dart';
import 'package:newfolder/Screens/Maps/repoapi.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';



Color color = const Color(0xfffe8903);

class AddressMapScreen extends StatefulWidget {
  const AddressMapScreen({super.key});

  @override
  State<AddressMapScreen> createState() => _GoogleMapScreenState();
}
//
// class _GoogleMapScreenState extends State<AddressMapScreen> with WidgetsBindingObserver {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   BitmapDescriptor? currentLocation;
//   TextEditingController placeController = TextEditingController();
//
//   TextEditingController SearchEditTextController = TextEditingController();
//
//   late final GoogleMapController _controller;
//   Position? _currentPosition;
//   LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);
//
//   final DraggableScrollableController _sheetController2 = DraggableScrollableController();
//   double _currentChildSize2 = 0.6;
//   bool _isDismissed2 = false;
//   double _lastExtent2 = 0.5;
//
//   TextEditingController LandmarkEditTextController = TextEditingController();
//   TextEditingController AddressEditTextController = TextEditingController();
//   TextEditingController FullnameEditTextController = TextEditingController();
//   TextEditingController AddressTitleEditTextController = TextEditingController();
//
//   final FocusNode _focusNode1 = FocusNode();
//   final FocusNode _focusNode2 = FocusNode();
//   final FocusNode _focusNode3 = FocusNode();
//   final FocusNode _focusNode4 = FocusNode();
//
//   bool openedSettings = false;
//
//   String name = '';
//   String street = '';
//   String thoroughfare = '';
//   String subThoroughfare = '';
//   String city = '';
//   String subLocality = '';
//   String state = '';
//   String subAdminArea = '';
//   String postalCode = '';
//   String country = '';
//   String isoCountryCode = '';
//
//   // NAYE VARIABLES ADD KIYE HAIN YAHAN
//   bool _isTextFieldsEditable = false;
//   PersistentBottomSheetController? _bottomSheetController;
//   StateSetter? _bottomSheetSetState;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _checkPermissionAndGetLocation();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed && openedSettings) {
//       openedSettings = false;
//       _checkPermissionAndGetLocation();
//     }
//   }
//
//   Future<void> _checkPermissionAndGetLocation() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         print('Location permission denied');
//         Navigator.of(context).pop();
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       bool openSettings = await _showOpenSettingsDialog();
//       if (openSettings) {
//         openedSettings = true;
//         await Geolocator.openAppSettings();
//       } else {
//         Navigator.of(context).pop();
//       }
//       return;
//     }
//
//     await getLocation();
//   }
//
//   Future<bool> _showOpenSettingsDialog() async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Permission Needed'),
//         content: const Text('Location permission is permanently denied. Please open settings to grant permission.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true),
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     ) ?? false;
//   }
//
//   Future<void> getLocation() async {
//     try {
//       _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       _currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
//
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         _currentPosition!.latitude,
//         _currentPosition!.longitude,
//       );
//
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks.first;
//         name = place.name ?? '';
//         street = place.street ?? '';
//         thoroughfare = place.thoroughfare ?? '';
//         subThoroughfare = place.subThoroughfare ?? '';
//         city = place.locality ?? '';
//         subLocality = place.subLocality ?? '';
//         state = place.administrativeArea ?? '';
//         subAdminArea = place.subAdministrativeArea ?? '';
//         postalCode = place.postalCode ?? '';
//         country = place.country ?? '';
//         isoCountryCode = place.isoCountryCode ?? '';
//       }
//
//       setState(() {});
//       showBottomSheetforAddressChange();
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }
//
//   Widget autoComplete() {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).size.height * 0.025,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.04,
//               width: MediaQuery.of(context).size.height * 0.04,
//               decoration: const BoxDecoration(
//                 color: Colors.transparent,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.arrow_back_ios_sharp,
//                 color: const Color(0xFF000000),
//                 size: MediaQuery.of(context).size.height * 0.02,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       extendBodyBehindAppBar: true,
//       extendBody: true,
//       resizeToAvoidBottomInset: false,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.dark,
//         child: _currentPosition == null
//             ? const Center(child: CircularProgressIndicator())
//             : Stack(
//           children: [
//             GoogleMap(
//               myLocationButtonEnabled: false,
//               myLocationEnabled: true,
//               zoomControlsEnabled: false,
//               initialCameraPosition: CameraPosition(zoom: 16, target: _currentLatLng),
//               onMapCreated: (controller) async {
//                 setState(() {
//                   _controller = controller;
//                 });
//                 String val = "assets/json/google_map_light_theme.json";
//                 var c = await rootBundle.loadString(val);
//                 _controller.setMapStyle(c);
//               },
//               // YAHAN MAP TAP LOGIC UPDATE KIYA GAYA H
//               onTap: (LatLng tappedLatLng) async {
//                 try {
//                   List<Placemark> placemarks = await placemarkFromCoordinates(
//                     tappedLatLng.latitude,
//                     tappedLatLng.longitude,
//                   );
//
//                   if (placemarks.isNotEmpty) {
//                     Placemark place = placemarks.first;
//
//                     setState(() {
//                       _currentLatLng = tappedLatLng;
//                       name = place.name ?? '';
//                       street = place.street ?? '';
//                       thoroughfare = place.thoroughfare ?? '';
//                       subThoroughfare = place.subThoroughfare ?? '';
//                       city = place.locality ?? '';
//                       subLocality = place.subLocality ?? '';
//                       state = place.administrativeArea ?? '';
//                       subAdminArea = place.subAdministrativeArea ?? '';
//                       postalCode = place.postalCode ?? '';
//                       country = place.country ?? '';
//                       isoCountryCode = place.isoCountryCode ?? '';
//                     });
//
//                     // Update controllers directly
//                     LandmarkEditTextController.text = name.isNotEmpty ? name : street;
//                     AddressEditTextController.text = [subLocality, city, state, postalCode]
//                         .where((element) => element.isNotEmpty)
//                         .join(', ');
//
//                     // ISSUE 3: AGAR SHEET DISMISS HO GAYI THI TO DOBARA LAO
//                     if (_bottomSheetController == null) {
//                       _isDismissed2 = false;
//                       showBottomSheetforAddressChange();
//                     } else {
//                       // Agar pehle se khuli h, to naye values apply kar do (ReadOnly wapas kardo)
//                       _bottomSheetSetState?.call(() {
//                         _isTextFieldsEditable = false;
//                       });
//                     }
//                   }
//                 } catch (e) {
//                   print('Error on map tap: $e');
//                 }
//               },
//               markers: {
//                 Marker(
//                   markerId: const MarkerId("1"),
//                   position: _currentLatLng,
//                 )
//               },
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
//               child: Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     autoComplete(),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   void showBottomSheetforAddressChange() {
//     LandmarkEditTextController.text = name.isNotEmpty ? name : street;
//     AddressEditTextController.text = [subLocality, city, state, postalCode]
//         .where((element) => element.isNotEmpty)
//         .join(', ');
//
//     // Inititaly ReadOnly state set karenge
//     _isTextFieldsEditable = false;
//
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     _bottomSheetController = _scaffoldKey.currentState?.showBottomSheet(
//         enableDrag: false,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//             (context) {
//           return StatefulBuilder( // StatefulBuilder add kiya bottom sheet state handle karne ke liye
//               builder: (BuildContext context, StateSetter setModalState) {
//                 _bottomSheetSetState = setModalState;
//
//                 return DraggableScrollableSheet(
//                   controller: _sheetController2,
//                   initialChildSize: _currentChildSize2,
//                   minChildSize: 0.3,
//                   maxChildSize: 0.9,
//                   expand: false,
//                   builder: (context, scrollController) {
//                     return PopScope(
//                       canPop: false,
//                       onPopInvokedWithResult: (bool didPop, Object? result) {
//                         if (didPop) return;
//                         Navigator.pop(context);
//                         Navigator.pop(context);
//                       },
//                       child: Material(
//                         color: const Color(0xFFFFFFFF),
//                         borderRadius: BorderRadius.circular(15),
//                         child: NotificationListener<DraggableScrollableNotification>(
//                           onNotification: (notification) {
//                             final currentExtent2 = notification.extent;
//                             if (currentExtent2 < _lastExtent2 - 0.01) {
//                               FocusScope.of(context).unfocus();
//                             }
//                             if (!_isDismissed2 && currentExtent2 < _currentChildSize2 - 0.05) {
//                               _isDismissed2 = true;
//                               Navigator.of(context).pop();
//                             }
//                             _lastExtent2 = currentExtent2;
//                             return true;
//                           },
//                           child: GestureDetector(
//                             behavior: HitTestBehavior.translucent,
//                             onVerticalDragUpdate: (details) {
//                               if (_sheetController2.isAttached) {
//                                 final newSize = _sheetController2.size - details.primaryDelta! / height;
//                                 _sheetController2.jumpTo(newSize.clamp(0.4, 0.95));
//                               }
//                             },
//                             child: Padding(
//                               padding: EdgeInsets.only(
//                                 bottom: MediaQuery.of(context).viewInsets.bottom,
//                                 left: height * 0.02,
//                                 top: height * 0.01,
//                                 right: height * 0.02,
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Expanded(
//                                     child: SingleChildScrollView(
//                                       controller: scrollController,
//                                       child: Column(
//                                         children: [
//                                           Center(
//                                             child: Container(
//                                               margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.03),
//                                               width: width * 0.23,
//                                               height: height * 0.006,
//                                               decoration: BoxDecoration(
//                                                 color: const Color(0xFFD9D9D9),
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                             ),
//                                           ),
//                                           Padding(
//                                             padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.022),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               children: <Widget>[
//                                                 Text(
//                                                   "Enter the Location Details",
//                                                   style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontWeight: FontWeight.w600,
//                                                     fontSize: height * 0.017,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             decoration: const BoxDecoration(
//                                               color: Color(0x1A126086),
//                                               borderRadius: BorderRadius.all(Radius.circular(8)),
//                                             ),
//                                             padding: EdgeInsets.symmetric(horizontal: height * 0.01),
//                                             child: Column(
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.022),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                     children: <Widget>[
//                                                       Row(
//                                                         children: [
//                                                           Icon(Icons.location_on_rounded, color: const Color(0xFF1E6588), size: height * 0.02),
//                                                           SizedBox(width: height * 0.01),
//                                                           // VALUELISTENABLE BUILDER SE REAL-TIME REFLECT KAREGA (ISSUE 1 & 2)
//                                                           ValueListenableBuilder<TextEditingValue>(
//                                                             valueListenable: LandmarkEditTextController,
//                                                             builder: (context, value, _) {
//                                                               return SizedBox(
//                                                                 width: width * 0.55,
//                                                                 child: Text(
//                                                                   value.text.isEmpty ? "No Landmark" : value.text,
//                                                                   style: TextStyle(
//                                                                     color: const Color(0xFF000000),
//                                                                     fontWeight: FontWeight.w700,
//                                                                     overflow: TextOverflow.ellipsis,
//                                                                     fontSize: height * 0.0165,
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       GestureDetector(
//                                                         onTap: () {
//                                                           // "CHANGE" PE CLICK KRNE SE READONLY FALSE HO JAYEGA (ISSUE 2)
//                                                           setModalState(() {
//                                                             _isTextFieldsEditable = true;
//                                                           });
//                                                         },
//                                                         child: Text(
//                                                           "Change",
//                                                           style: TextStyle(
//                                                             color: const Color(0xFF1E6588),
//                                                             fontWeight: FontWeight.w600,
//                                                             fontSize: height * 0.0135,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.022),
//                                                   child: Row(
//                                                     mainAxisAlignment: MainAxisAlignment.start,
//                                                     children: <Widget>[
//                                                       Flexible(
//                                                         // ADDRESS BHI REAL-TIME TYPE HONGE TO UPDATE HONGE
//                                                         child: ValueListenableBuilder<TextEditingValue>(
//                                                             valueListenable: AddressEditTextController,
//                                                             builder: (context, value, _) {
//                                                               return Text(
//                                                                 value.text,
//                                                                 style: TextStyle(
//                                                                   color: const Color(0xFF454545),
//                                                                   fontWeight: FontWeight.w400,
//                                                                   overflow: TextOverflow.ellipsis,
//                                                                   fontSize: height * 0.017,
//                                                                 ),
//                                                                 softWrap: true,
//                                                                 maxLines: 1,
//                                                               );
//                                                             }
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           const SizedBox(height: 12),
//
//                                           _buildLabelWithAsterisk(context, 'Landmark', required: true),
//                                           _buildTextField(_focusNode1, LandmarkEditTextController, "House Number / Flat / Block No."),
//
//                                           _buildLabelWithAsterisk(context, 'Address', required: true),
//                                           _buildTextField(_focusNode2, AddressEditTextController, "e.g. Near ABC School"),
//
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 flex: 1,
//                                                 child: Column(
//                                                   children: [
//                                                     _buildLabelWithAsterisk(context, 'Full Name', required: true),
//                                                     _buildTextField(_focusNode3, FullnameEditTextController, ""),
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 flex: 1,
//                                                 child: Column(
//                                                   children: [
//                                                     _buildLabelWithAsterisk(context, 'Address Title', required: true),
//                                                     _buildTextField(_focusNode4, AddressTitleEditTextController, "e.g. Home"),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//
//                                           Padding(
//                                             padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.05),
//                                             child: Align(
//                                               alignment: Alignment.center,
//                                               child: Container(
//                                                 height: height * 0.05,
//                                                 width: height * 0.4,
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.black,
//                                                     borderRadius: BorderRadius.circular(height * 0.012),
//                                                     gradient: const LinearGradient(
//                                                         begin: Alignment.centerRight,
//                                                         end: Alignment.center,
//                                                         colors: [Color(0xFF126086), Color(0xFF126086)])),
//                                                 child: TextButton(
//                                                   onPressed: () {
//                                                     String landmark = LandmarkEditTextController.text.trim();
//                                                     String address = AddressEditTextController.text.trim();
//                                                     String fullname = FullnameEditTextController.text.trim();
//                                                     String addressTitle = AddressTitleEditTextController.text.trim();
//
//                                                     if (landmark.isEmpty) {
//                                                       showTopNotification(context, title: 'Location Details', message: 'Please enter the Landmark Field', type: NotificationType.error);
//                                                     } else if (address.isEmpty) {
//                                                       showTopNotification(context, title: 'Location Details', message: 'Please enter the Address Field', type: NotificationType.error);
//                                                     } else if (fullname.isEmpty) {
//                                                       showTopNotification(context, title: 'Location Details', message: 'Please enter the Full Name Field', type: NotificationType.error);
//                                                     } else if (addressTitle.isEmpty) {
//                                                       showTopNotification(context, title: 'Location Details', message: 'Please enter the Address Title Field', type: NotificationType.error);
//                                                     } else {
//                                                       Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                                                         return const AddressFindScreen();
//                                                       }));
//                                                     }
//                                                   },
//                                                   child: Text(
//                                                     "Save Address",
//                                                     style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: height * 0.015),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }
//           );
//         });
//
//     // Jab sheet physically dismiss hogi tab controller variable free hoga
//     _bottomSheetController?.closed.then((_) {
//       _bottomSheetController = null;
//       _bottomSheetSetState = null;
//       _isDismissed2 = true;
//     });
//   }
//
//   // Refactored TextField widget to reduce repetitive code and manage readOnly properly
//   Widget _buildTextField(FocusNode node, TextEditingController controller, String hint) {
//     return GestureDetector(
//       onTap: () async {
//         if (!_isTextFieldsEditable) return; // Agar editable nahi hai to focus mat do
//         if (_sheetController2.isAttached) {
//           await _sheetController2.animateTo(0.9, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
//           Future.delayed(const Duration(milliseconds: 50), () {
//             node.requestFocus();
//           });
//         }
//       },
//       child: AbsorbPointer(
//         // Absorb pointer ko ab state k according active/inactive kr sakte hn, par directly input field readOnly karega kaam.
//         absorbing: !_isTextFieldsEditable,
//         child: Padding(
//           padding: EdgeInsets.only(
//             left: MediaQuery.of(context).size.height * 0.005,
//             right: MediaQuery.of(context).size.height * 0.005,
//             bottom: MediaQuery.of(context).size.height * 0.005,
//           ),
//           child: Focus(
//             onFocusChange: (hasFocus) {
//               if (hasFocus) ScaffoldMessenger.of(context).hideCurrentSnackBar();
//             },
//             child: TextFormField(
//               focusNode: node,
//               controller: controller,
//               readOnly: !_isTextFieldsEditable, // FIELD DISABLED DIKHEGA PAR STYLING NAYI JAISE RHEGI (ISSUE 2)
//               inputFormatters: [LengthLimitingTextInputFormatter(100)],
//               style: TextStyle(
//                 color: const Color(0xFF171717),
//                 fontSize: MediaQuery.of(context).size.height * 0.014,
//                 fontWeight: FontWeight.w400,
//               ),
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
//                 filled: true,
//                 fillColor: const Color(0xFFFFFFFF),
//                 hintText: hint,
//                 hintStyle: TextStyle(
//                   color: const Color(0xFF727272),
//                   fontSize: MediaQuery.of(context).size.height * 0.014,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide: const BorderSide(color: Color(0xFFF1F1F1)),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide: const BorderSide(color: Colors.red),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(5.0),
//                   borderSide: const BorderSide(color: Colors.red),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static Widget _buildLabelWithAsterisk(BuildContext context, String label, {bool required = false}) {
//     return Padding(
//       padding: EdgeInsets.only(
//         top: MediaQuery.of(context).size.height * 0.015,
//         left: MediaQuery.of(context).size.height * 0.005,
//         bottom: MediaQuery.of(context).size.height * 0.006,
//       ),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: RichText(
//           text: TextSpan(
//             text: label,
//             style: TextStyle(
//               fontSize: MediaQuery.of(context).size.height * 0.014,
//               color: const Color(0xFF333333),
//               fontWeight: FontWeight.w500,
//             ),
//             children: required
//                 ? const [TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]
//                 : [],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _GoogleMapScreenState extends State<AddressMapScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BitmapDescriptor? currentLocation;
  TextEditingController placeController = TextEditingController();

  TextEditingController SearchEditTextController = TextEditingController();

  late final GoogleMapController _controller;
  Position? _currentPosition;
  LatLng _currentLatLng = const LatLng(27.671332124757402, 85.3125417636781);

  TextEditingController LandmarkEditTextController = TextEditingController();
  TextEditingController AddressEditTextController = TextEditingController();
  TextEditingController FullnameEditTextController = TextEditingController();
  TextEditingController AddressTitleEditTextController = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  bool openedSettings = false;

  String name = '';
  String street = '';
  String thoroughfare = '';
  String subThoroughfare = '';
  String city = '';
  String subLocality = '';
  String state = '';
  String subAdminArea = '';
  String postalCode = '';
  String country = '';
  String isoCountryCode = '';

  bool _isTextFieldsEditable = false;
  PersistentBottomSheetController? _bottomSheetController;
  StateSetter? _bottomSheetSetState;

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

    await getLocation();
  }

  Future<bool> _showOpenSettingsDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Needed'),
        content: const Text('Location permission is permanently denied. Please open settings to grant permission.'),
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
    ) ?? false;
  }

  Future<void> getLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _currentLatLng = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
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
      }

      setState(() {});
      showBottomSheetforAddressChange();
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Widget autoComplete() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.025,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.height * 0.04,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_sharp,
                color: const Color(0xFF000000),
                size: MediaQuery.of(context).size.height * 0.02,
              ),
            ),
          ),
        ],
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
            ? const Center(child: CircularProgressIndicator())
            : Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(zoom: 16, target: _currentLatLng),
              onMapCreated: (controller) async {
                setState(() {
                  _controller = controller;
                });
                String val = "assets/json/google_map_light_theme.json";
                var c = await rootBundle.loadString(val);
                _controller.setMapStyle(c);
              },
              onTap: (LatLng tappedLatLng) async {
                try {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    tappedLatLng.latitude,
                    tappedLatLng.longitude,
                  );

                  if (placemarks.isNotEmpty) {
                    Placemark place = placemarks.first;

                    setState(() {
                      _currentLatLng = tappedLatLng;
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
                    });

                    LandmarkEditTextController.text = name.isNotEmpty ? name : street;
                    AddressEditTextController.text = [subLocality, city, state, postalCode]
                        .where((element) => element.isNotEmpty)
                        .join(', ');

                    if (_bottomSheetController == null) {
                      showBottomSheetforAddressChange();
                    } else {
                      _bottomSheetSetState?.call(() {
                        _isTextFieldsEditable = false;
                      });
                    }
                  }
                } catch (e) {
                  print('Error on map tap: $e');
                }
              },
              markers: {
                Marker(
                  markerId: const MarkerId("1"),
                  position: _currentLatLng,
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void showBottomSheetforAddressChange() {
    LandmarkEditTextController.text = name.isNotEmpty ? name : street;
    AddressEditTextController.text = [subLocality, city, state, postalCode]
        .where((element) => element.isNotEmpty)
        .join(', ');

    _isTextFieldsEditable = false;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _bottomSheetController = _scaffoldKey.currentState?.showBottomSheet(
        enableDrag: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
            (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                _bottomSheetSetState = setModalState;

                return PopScope(
                  canPop: false,
                  onPopInvokedWithResult: (bool didPop, Object? result) {
                    if (didPop) return;
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Material(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      constraints: BoxConstraints(
                        // Ye sheet ko kisi bhi haalat me screen ke 90% se upar nahi jane dega
                        maxHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                          left: height * 0.02,
                          top: height * 0.01,
                          right: height * 0.02,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // CONTENT KE HISAAB SE HEIGHT LEGA
                            children: [
                              Center(
                                child: Container(
                                  margin: EdgeInsets.only(top: height * 0.01, bottom: height * 0.03),
                                  width: width * 0.23,
                                  height: height * 0.006,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD9D9D9),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Enter the Location Details",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.017,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0x1A126086),
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: height * 0.01),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.022),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_rounded, color: const Color(0xFF1E6588), size: height * 0.02),
                                              SizedBox(width: height * 0.01),
                                              ValueListenableBuilder<TextEditingValue>(
                                                valueListenable: LandmarkEditTextController,
                                                builder: (context, value, _) {
                                                  return SizedBox(
                                                    width: width * 0.55,
                                                    child: Text(
                                                      value.text.isEmpty ? "No Landmark" : value.text,
                                                      style: TextStyle(
                                                        color: const Color(0xFF000000),
                                                        fontWeight: FontWeight.w700,
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: height * 0.0165,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setModalState(() {
                                                _isTextFieldsEditable = true;
                                              });
                                            },
                                            child: Text(
                                              "Change",
                                              style: TextStyle(
                                                color: const Color(0xFF1E6588),
                                                fontWeight: FontWeight.w600,
                                                fontSize: height * 0.0135,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: height * 0.005, top: height * 0.022),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: ValueListenableBuilder<TextEditingValue>(
                                                valueListenable: AddressEditTextController,
                                                builder: (context, value, _) {
                                                  return Text(
                                                    value.text,
                                                    style: TextStyle(
                                                      color: const Color(0xFF454545),
                                                      fontWeight: FontWeight.w400,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontSize: height * 0.017,
                                                    ),
                                                    softWrap: true,
                                                    maxLines: 1,
                                                  );
                                                }
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              _buildLabelWithAsterisk(context, 'Landmark', required: true),
                              _buildTextField(_focusNode1, LandmarkEditTextController, "House Number / Flat / Block No."),

                              _buildLabelWithAsterisk(context, 'Address', required: true),
                              _buildTextField(_focusNode2, AddressEditTextController, "e.g. Near ABC School"),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        _buildLabelWithAsterisk(context, 'Full Name', required: true),
                                        // YAHAN alwaysEnabled TRUE KIYA H (ISSUE 1)
                                        _buildTextField(_focusNode3, FullnameEditTextController, "", alwaysEnabled: true),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        _buildLabelWithAsterisk(context, 'Address Title', required: true),
                                        // YAHAN BHI alwaysEnabled TRUE KIYA H (ISSUE 1)
                                        _buildTextField(_focusNode4, AddressTitleEditTextController, "e.g. Home", alwaysEnabled: true),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: height * 0.01, bottom: height * 0.05),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: height * 0.05,
                                    width: height * 0.4,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(height * 0.012),
                                        gradient: const LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.center,
                                            colors: [Color(0xFF126086), Color(0xFF126086)])),
                                    child: TextButton(
                                      onPressed: () {
                                        String landmark = LandmarkEditTextController.text.trim();
                                        String address = AddressEditTextController.text.trim();
                                        String fullname = FullnameEditTextController.text.trim();
                                        String addressTitle = AddressTitleEditTextController.text.trim();

                                        if (landmark.isEmpty) {
                                          showTopNotification(context, title: 'Location Details', message: 'Please enter the Landmark Field', type: NotificationType.error);
                                        } else if (address.isEmpty) {
                                          showTopNotification(context, title: 'Location Details', message: 'Please enter the Address Field', type: NotificationType.error);
                                        } else if (fullname.isEmpty) {
                                          showTopNotification(context, title: 'Location Details', message: 'Please enter the Full Name Field', type: NotificationType.error);
                                        } else if (addressTitle.isEmpty) {
                                          showTopNotification(context, title: 'Location Details', message: 'Please enter the Address Title Field', type: NotificationType.error);
                                        } else {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                            return const AddressFindScreen();
                                          }));
                                        }
                                      },
                                      child: Text(
                                        "Save Address",
                                        style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: height * 0.015),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
          );
        });

    _bottomSheetController?.closed.then((_) {
      _bottomSheetController = null;
      _bottomSheetSetState = null;
    });
  }

  // YAHAN NAYA PARAMETER 'alwaysEnabled' ADD KIYA H
  Widget _buildTextField(FocusNode node, TextEditingController controller, String hint, {bool alwaysEnabled = false}) {
    bool isEditable = alwaysEnabled ? true : _isTextFieldsEditable;

    return GestureDetector(
      onTap: () {
        if (!isEditable) return;
        node.requestFocus();
      },
      child: AbsorbPointer(
        absorbing: !isEditable,
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * 0.005,
            right: MediaQuery.of(context).size.height * 0.005,
            bottom: MediaQuery.of(context).size.height * 0.005,
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: TextFormField(
              focusNode: node,
              controller: controller,
              readOnly: !isEditable,
              inputFormatters: [LengthLimitingTextInputFormatter(100)],
              style: TextStyle(
                color: const Color(0xFF171717),
                fontSize: MediaQuery.of(context).size.height * 0.014,
                fontWeight: FontWeight.w400,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
                filled: true,
                fillColor: const Color(0xFFFFFFFF),
                hintText: hint,
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
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildLabelWithAsterisk(BuildContext context, String label, {bool required = false}) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.015,
        left: MediaQuery.of(context).size.height * 0.005,
        bottom: MediaQuery.of(context).size.height * 0.006,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.014,
              color: const Color(0xFF333333),
              fontWeight: FontWeight.w500,
            ),
            children: required
                ? const [TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))]
                : [],
          ),
        ),
      ),
    );
  }
}