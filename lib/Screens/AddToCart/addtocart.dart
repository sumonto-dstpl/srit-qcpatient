import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newfolder/Core/Dialog/bottom_payment_method.dart';
import 'package:newfolder/Core/Dialog/delete_dialog.dart';
import 'package:newfolder/Core/Image%20Action/delete.dart';
import 'package:newfolder/Screens/AddToCart/addtocarPackageDetails.dart';
import 'package:newfolder/Screens/LabTests/labtestmain.dart';
import 'package:newfolder/Screens/Utils/customNotification.dart';
import 'package:newfolder/Screens/Utils/user_secure_storage.dart';
import 'package:newfolder/Screens/Widgets/dotteddivider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import '../../utils/cart_provider.dart';

class AddToCartMain extends StatefulWidget {

  AddToCartMain({
    super.key,
  });

  @override
  State<AddToCartMain> createState() => AddToCartMainstate();
}

class AddToCartMainstate extends State<AddToCartMain> {
  String usernameValue = "My Health";
  bool isExpanded = true; // For collapse/expand toggle
  String saveForLaterKey = "saveForLater";
  List<Map<String, dynamic>> carttoplist = [];
  List<Map<String, dynamic>> savedbottomlist = [];
  List<Map<String, dynamic>> _currentList = [];

  //Asgar
  bool isSavedForLater = true;
  int saveForLaterCount = 0;

  //sumonto
  int cartPrice = 0;
  int disPrice = 99;
  int platformPrice = 9;

  @override
  void initState() {
    super.initState();
    _loadCart();

  }

  @override
  Widget build(BuildContext context) {

    saveForLaterCount = savedbottomlist.length;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cart = Provider.of<CartProvider>(context);
    int cartPrice = cart.totalPrice;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Stack(children: [
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: screenHeight * 0.05, left: screenWidth * 0.02, right: screenWidth * 0.02, bottom: screenWidth * 0.02,),
                margin: EdgeInsets.only(bottom: screenHeight * 0.01,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * 0.03), topRight: Radius.circular(screenHeight * 0.03),),),
                  child : Column(
                    children: [

                      Container(
                        padding: EdgeInsets.only(left: screenHeight * 0.02, right: screenHeight * 0.02, top: screenHeight * 0.02, bottom: screenHeight * 0.01),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(screenHeight * 0.03), topRight: Radius.circular(screenHeight * 0.03),),),
                        child: Column(children: [
                          // Inkwell & Cart Text
                          Container(
                            padding: EdgeInsets.only(bottom: screenWidth * 0.01,),
                            margin: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.01,),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    margin: EdgeInsets.only(left: screenHeight * 0.01,),
                                    height: screenHeight * 0.035,
                                    width: screenHeight * 0.035,
                                    decoration: BoxDecoration(color: Color(0xFFF7F5F6), shape: BoxShape.circle,),
                                    child: Icon(Icons.arrow_back_ios_sharp, color: Color(0xFF999999), size: screenHeight * 0.018,),
                                  ),
                                ),
                                Expanded(child: Center(child: Text("Cart", style: TextStyle(fontSize: screenHeight * 0.018, color: Colors.black, fontWeight: FontWeight.w600,), textAlign: TextAlign.center,),),),
                                SizedBox(width: screenHeight * 0.035),
                              ],
                            ),
                          ),
                        ]
                        ),
                      ),
                      // Main Content Section
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.zero,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.white,),
                          child: (_currentList.isEmpty && savedbottomlist.isEmpty) ?
                          ListView(
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),),
                                  padding: EdgeInsets.zero,
                                  child: Card(
                                    elevation: 0.0, color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.5, 0.9], colors: [Colors.white, Colors.white])),
                                      margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.006 , vertical: screenHeight * 0.003),
                                      padding: EdgeInsets.all( screenHeight * 0.005),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(left: screenHeight * 0.020, right: screenHeight * 0.020, top: screenHeight * 0.030, ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Image.asset('assets/Cart_Empty_vector.png', height: screenHeight * 0.4, fit: BoxFit.fill,),
                                                        Container(
                                                          padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.02,),
                                                          child: Text("Your cart is empty", textAlign: TextAlign.center, style: TextStyle(color: Color(0x66000000), fontWeight: FontWeight.w400, fontSize: screenHeight * 0.014, fontFamily: "Inter"),),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return LabTestsMain();
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.zero,
                                      margin: EdgeInsets.only(right: screenHeight * 0.07, bottom: screenHeight * 0.01, left: screenHeight * 0.07),
                                      child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(screenHeight * 0.012), gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.center, stops: [0.5, 0.9], colors: [Color(0xFF126086), Color(0xFF126086),])),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(left: 0.0),
                                                child: TextButton(
                                                  onPressed: () async {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder:
                                                            (BuildContext context) {
                                                          return LabTestsMain();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Text("Add package", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.018, fontWeight: FontWeight.w700)),
                                                ),
                                              ),
                                            ),
                                          ]
                                      )
                                  ),
                                )
                              ]
                          )
                              :
                          ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              // Top ListView

                              // Top 3 Cards
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: screenHeight* 0.015,),
                                padding: EdgeInsets.only(top: screenHeight * 0.005,),
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _currentList.length,
                                  itemBuilder: (context, index) {
                                    final item = _currentList[index];
                                    return Slidable(
                                        key : UniqueKey(),
                                        closeOnScroll: true,
                                        endActionPane: ActionPane(
                                          extentRatio: 0.15,
                                          motion: const ScrollMotion(),
                                          children: [
                                            // Container(
                                            //   width: 50,
                                            //   height: double.infinity,
                                            //
                                            //   child: Column(
                                            //     children: [
                                            //       // Upper icon (Save)
                                            //       Expanded(
                                            //         child: GestureDetector(
                                            //           onTap: (){
                                            //             showTopNotification(context, title: "Cart Save For Later", message: "Cart is Saved for Later Successfully", type: NotificationType.success,);
                                            //             if (index >= _currentList.length) {
                                            //               savedbottomlist.add(_currentList.last);
                                            //               _currentList.removeLast();
                                            //               setState(() {});
                                            //               return;
                                            //             }
                                            //             setState(() {
                                            //               addToCart(item['id'],item['plan'],item['test'],item['qr'],key: saveForLaterKey);
                                            //               _currentList.removeAt(index);
                                            //             });
                                            //             _deleteCart(item['id'],index);
                                            //           },
                                            //           child: Container(
                                            //             alignment: Alignment.center,
                                            //             child: Image.asset("assets/addtofoldersaveicon.png", width: 20, height: 20, color: Colors.black, colorBlendMode: BlendMode.srcIn,),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //
                                            //       // Lower icon (Delete)
                                            //       Expanded(
                                            //         child: GestureDetector(
                                            //           // onTap: () async {
                                            //           //   final result = await DeleteDialog.show(
                                            //           //     context: context,
                                            //           //     barrierLabel: "InsuranceDelete",
                                            //           //     message: "Are you sure to Remove the Selected Cart ?",
                                            //           //   );
                                            //           //   if(result!) {
                                            //           //
                                            //           //     _deleteCart(item['id'],index);
                                            //           //     showTopNotification(context, title: "Cart Delete", message: "Cart is deleted Successfully", type: NotificationType.error,);
                                            //           //   }
                                            //           // },
                                            //
                                            //           onTap : () {
                                            //             _deleteCart(item['id'],index);
                                            //             showTopNotification(context, title: "Cart Delete", message: "Cart is deleted Successfully", type: NotificationType.error,);
                                            //           },
                                            //           child: AppDeleteIcon(isCenter: true,),
                                            //
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),

                                            // ActionPane ke children list ke andar Container ko Builder se wrap karein:
                                            Builder(
                                                builder: (slidableContext) {
                                                  return Container(
                                                    width: 50,
                                                    height: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        // Upper icon (Save)
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              // Save karte time bhi pehle close karein
                                                              Slidable.of(slidableContext)?.close();

                                                              showTopNotification(context, title: "Cart Save For Later", message: "Cart is Saved for Later Successfully", type: NotificationType.success,);
                                                              if (index >= _currentList.length) {
                                                                savedbottomlist.add(_currentList.last);
                                                                _currentList.removeLast();
                                                                setState(() {});
                                                                return;
                                                              }
                                                              setState(() {
                                                                addToCart(item['id'],item['plan'],item['test'],item['qr'],key: saveForLaterKey);
                                                                _currentList.removeAt(index);
                                                              });
                                                              _deleteCart(item['id'],index);
                                                            },
                                                            child: Container(
                                                              alignment: Alignment.center,
                                                              child: Image.asset("assets/addtofoldersaveicon.png", width: 20, height: 20, color: Colors.black, colorBlendMode: BlendMode.srcIn,),
                                                            ),
                                                          ),
                                                        ),

                                                        // Lower icon (Delete)
                                                        Expanded(
                                                          child: GestureDetector(
                                                            onTap: () async {
                                                              // 1. Dialog kholne se pehle Slidable ko smoothly close karein
                                                              Slidable.of(slidableContext)?.close();

                                                              // 2. 250ms wait karein taaki close animation poora ho jaye
                                                              // Isse BackdropFilter (blur) aur UI freeze nahi hoga
                                                              await Future.delayed(const Duration(milliseconds: 250));

                                                              // 3. Ab aaram se Dialog show karein
                                                              final result = await DeleteDialog.show(
                                                                context: context,
                                                                barrierLabel: "InsuranceDelete",
                                                                message: "Are you sure to Remove the Selected Cart ?",
                                                              );

                                                              if(result!) {
                                                                // 4. Delete confirm hone par UI ko turant list se remove karein
                                                                setState(() {
                                                                  _currentList.removeAt(index);
                                                                });
                                                                _deleteCart(item['id'],index);
                                                                showTopNotification(context, title: "Cart Delete", message: "Cart is deleted Successfully", type: NotificationType.error,);
                                                              }
                                                            },
                                                            child: AppDeleteIcon(isCenter: true,),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                            )
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return AddtocardPackageDetails(id: item['id'],plan: item['plan'],qr: item['qr'],test: item['test'],);
                                                },
                                              ),
                                            );
                                          },
                                          child: Card(
                                            elevation: 0.0,
                                            color: Colors.white,
                                            child: Container(
                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black.withOpacity(0.1), width: 1,), borderRadius: BorderRadius.circular(8),),
                                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, ),
                                              child: Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.5, 0.9], colors: [Color(0xFFffffff), Color(0xFFffffff)])),
                                                margin: EdgeInsets.zero,
                                                padding: EdgeInsets.all(screenHeight * 0.005),
                                                child: MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1),),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.015, vertical:  screenHeight * 0.005,),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                padding: EdgeInsets.zero,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(130.0),
                                                                  child: Image.asset("assets/Harmonebackground.png", fit: BoxFit.fill,),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width:screenHeight * 0.02),
                                                            Expanded(
                                                              flex: 6,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.zero,
                                                                    child: Text(item['plan'], style: TextStyle(color: Colors.black87, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600, fontSize: screenHeight * 0.014,),),
                                                                  ),
                                                                  SizedBox(height: screenHeight * 0.005,),
                                                                  Container(
                                                                    padding: EdgeInsets.zero,
                                                                    child: Text(item['test'] + " tests included", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.012,),),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Adding the side arrow at the end

                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
                                                                padding: EdgeInsets.zero,
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(horizontal: 2),
                                                                        height: screenHeight * 0.005, width: screenHeight * 0.005,
                                                                        decoration: BoxDecoration(color: Color(0xFF12B76A), shape: BoxShape.circle,),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(left: screenHeight * 0.002,),
                                                                        child: Text(item['qr'], style: TextStyle(fontSize: screenHeight * 0.014, color: Color(0xFF12B76A), fontWeight: FontWeight.w500,), overflow: TextOverflow.ellipsis, textAlign: TextAlign.right,),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    );
                                  },
                                ),
                              ),

                              // Price Details
                              _currentList.isEmpty ? Container() :Padding(
                                padding: EdgeInsets.only(left: screenHeight * 0.02, top: screenHeight * 0.015, bottom: screenHeight * 0.01),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Price Details", style: TextStyle(fontSize: screenHeight * 0.016, color: Colors.black, fontWeight: FontWeight.bold,), textAlign: TextAlign.start,
                                  ),
                                ),
                              ),

                              // down card savedbottomlist.isEmpty
                              _currentList.isEmpty ? Container() : Container(
                                margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.01,),
                                padding: EdgeInsets.all( screenHeight * 0.01,),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8),),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: Color(0xFFF8F8F8), borderRadius: BorderRadius.circular(8),),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01, vertical: screenHeight * 0.005, ),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.zero,
                                                        child: Text("Price ("+_currentList.length.toString()+" Package)", style: TextStyle(color: Color(0x80000000), fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.014,),),
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.only(left:screenHeight * 0.005,),
                                                          child: Text('QR '+cartPrice.toString(), style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.014),)
                                                      ),
                                                    ]
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01, vertical: screenHeight * 0.005,),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.zero,
                                                        child: Text("Discount", style: TextStyle(color: Color(0x80000000), fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.014,),),
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.only(left:screenHeight * 0.005,),
                                                          child: Text('You saved QR '+(_currentList.length<=0?0:disPrice).toString(), style: TextStyle(color: Color(0xFF12B76A), fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.014),)
                                                      ),
                                                    ]
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01, vertical: screenHeight * 0.005,),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.zero,
                                                        child: Text("Platform Fee", style: TextStyle(color: Color(0x80000000), fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, fontSize:screenHeight * 0.014,),),
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.only(left:screenHeight * 0.005,),
                                                          child: Text('QR '+(_currentList.length<=0?0:platformPrice).toString(), style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.014),)
                                                      ),
                                                    ]
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(screenHeight * 0.01,),
                                                child: DottedDivider(color: Color(0x4D000000), strokeWidth: 0.5, gap: 5.0, height: 0.0,),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01, vertical: screenHeight * 0.005,),
                                                child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.zero,
                                                        child: Text('Total Amount', style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis, fontSize:screenHeight * 0.014),),
                                                      ),
                                                      Container(
                                                          padding: EdgeInsets.only(left:screenHeight * 0.005,),
                                                          child: Text('QR '+(_currentList.length<=0?0:(cartPrice-disPrice+platformPrice)).toString(), style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.014),)
                                                      ),
                                                    ]
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),

                              // Saved for later Text
                              savedbottomlist.isEmpty ? Container() : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded; // Toggle collapse/expand
                                  });
                                },
                                child: Container(

                                  margin: EdgeInsets.only(top: screenHeight * 0.01, bottom: screenHeight * 0.015, left: screenHeight * 0.020, right: screenHeight * 0.020,),
                                  padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.01, vertical: screenHeight * 0.008),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.14), width: 0.5,),),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          height: screenHeight * 0.02,
                                          width: screenHeight * 0.02,
                                          child: Image.asset('assets/addcartFolder.png', height: screenHeight * 0.015, width: screenHeight * 0.015,),
                                        ),
                                      ),

                                      SizedBox(width: screenHeight * 0.01),

                                      // Saved For Later Text
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Saved For Later ($saveForLaterCount)", style: TextStyle(fontSize: screenHeight * 0.014, color: Color(0xFF000000), fontWeight: FontWeight.w500,),),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isExpanded = !isExpanded; // Toggle collapse/expand
                                                });
                                              },
                                              child: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: screenHeight * 0.02, color: Colors.black54,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              ,

                              // Bottom ListView
                              isExpanded && savedbottomlist.isNotEmpty ? Container(
                                margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.015,),
                                padding: EdgeInsets.zero,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: savedbottomlist.length,
                                  itemBuilder: (context, index) {
                                    final item = savedbottomlist[index];
                                    return Slidable(
                                        key : UniqueKey(),
                                        closeOnScroll: true,
                                        endActionPane: ActionPane(
                                          extentRatio: 0.15,
                                          motion: const ScrollMotion(),
                                          children: [
                                            Container(
                                              width: 50,
                                              height: double.infinity,

                                              child: Column(
                                                children: [
                                                  // Upper icon (Save)
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        addToCart(item['id'],item['plan'],item['test'],item['qr']);
                                                        _deleteCart(item['id'],index,key: saveForLaterKey);
                                                        showTopNotification(context, title: "Cart Added", message: "Saved For Later Cart is added back to Cart", type: NotificationType.success,);
                                                        setState(() {
                                                          savedbottomlist.removeAt(index);
                                                        });
                                                        if (savedbottomlist.isEmpty) {
                                                          isSavedForLater = false;
                                                        }
                                                      },
                                                      child: Container(
                                                        alignment: Alignment.center,
                                                        child: Image.asset("assets/Add to cart.png", width: 25, height: 25, color: Colors.black, colorBlendMode: BlendMode.srcIn,),
                                                      ),
                                                    ),
                                                  ),

                                                  // Lower icon (Delete)
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        final result = await DeleteDialog.show(
                                                          context: context,
                                                          barrierLabel: "InsuranceDelete",
                                                          message: "Are you sure to Remove the Saved For Later Cart ?",
                                                        );
                                                        if(result!) {
                                                          showTopNotification(context, title: "Cart Delete", message: "Saved For Later Cart is deleted Successfully", type: NotificationType.error,);
                                                          setState(() {
                                                            _deleteCart(item['id'],index,key: saveForLaterKey);
                                                          });
                                                          if (savedbottomlist.isEmpty) {
                                                            isSavedForLater = false;
                                                          }
                                                        }
                                                      },
                                                      child: AppDeleteIcon(isCenter: true,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) {
                                                  return AddtocardPackageDetails(id: item['id'],plan: item['plan'],qr: item['qr'],test: item['test'],);
                                                },
                                              ),
                                            );
                                          },
                                          child: Card(
                                            elevation: 0.0,
                                            color: Colors.white,
                                            child: Container(
                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black.withOpacity(0.1), width: 1,), borderRadius: BorderRadius.circular(8),),
                                              padding: EdgeInsets.symmetric(vertical:  screenHeight * 0.01, ),
                                              child: Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.5, 0.9], colors: [Color(0xFFffffff), Color(0xFFffffff)])),
                                                margin: EdgeInsets.zero,
                                                padding: EdgeInsets.all(screenHeight * 0.005),
                                                child: MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(textScaleFactor:  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.1),),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal:screenHeight * 0.015, vertical:screenHeight * 0.005,),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                padding: EdgeInsets.zero,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(130.0),
                                                                  child: Image.asset("assets/Harmonebackground.png", fit: BoxFit.fill,),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: screenHeight * 0.02),
                                                            Expanded(
                                                              flex: 6,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.zero,
                                                                    child: Text(savedbottomlist[index]['plan'], style: TextStyle(color: Colors.black87, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600, fontSize: screenHeight * 0.014,),),
                                                                  ),
                                                                  SizedBox(height: screenHeight * 0.005,),
                                                                  Container(
                                                                    padding: EdgeInsets.zero,
                                                                    child: Text(savedbottomlist[index]['test'] + " Tests Included", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis, fontSize: screenHeight * 0.012,),),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Adding the side arrow at the end

                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),

                                                                padding: EdgeInsets.zero,
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: <Widget>[
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(horizontal: 2),
                                                                        height: screenHeight * 0.005,
                                                                        width: screenHeight * 0.005,
                                                                        decoration: BoxDecoration(color: Color(0xFF12B76A), shape: BoxShape.circle,),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(left: screenHeight * 0.002,),
                                                                        child: Text(savedbottomlist[index]['qr'], style: TextStyle(fontSize: screenHeight * 0.014, color: Color(0xFF12B76A), fontWeight: FontWeight.w500,), overflow: TextOverflow.ellipsis, textAlign: TextAlign.right,),
                                                                      ),
                                                                    ]
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
                                            ),
                                          ),
                                        )
                                    );
                                  },
                                ),
                              ): Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),

      // Bottom Navigation with another  positioned on the right
      bottomNavigationBar: (_currentList.isEmpty && savedbottomlist.isEmpty)  ? null : Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: Offset(0, -2), blurRadius: 6,),],),
        height: screenHeight * 0.1,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: screenHeight * 0.01,),
              margin: EdgeInsets.symmetric(horizontal: screenHeight * 0.04, vertical: screenHeight * 0.01,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque, // ✅ makes the whole container tappable
                      onTap: () async {
                        showPaymentBottomSheet(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(screenHeight * 0.012,), gradient: LinearGradient(begin: Alignment.centerRight, end: Alignment.center, stops: [0.5, 0.9], colors: [Color(0xFF126086), Color(0xFF126086),],),),
                        alignment: Alignment.center,
                        padding: EdgeInsets.zero,
                        child: TextButton(
                          onPressed: () async {
                            showPaymentBottomSheet(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 9.5, horizontal: 12.0,),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text("Next", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: screenHeight * 0.018, fontWeight: FontWeight.w600,),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      )   ,
    );
  }


  void _loadCart() async {
    bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
    String? username =  await UserSecureStorage.getUsernameid();

    if(isGuestUser) {
      username = "GUEST";
    }
    print("username : $username");


    List<dynamic> _loadedCart2  = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');
    List<dynamic> saveForLater  = await UserSecureStorage.getAddToCart(saveForLaterKey,username ?? '');


    print("_loadedCart2 : $_loadedCart2");
    print("saveForLater : $saveForLater");




    // Future.delayed(const Duration(milliseconds: 500), () {
    setState(() {
      _currentList = [..._loadedCart2,];
      savedbottomlist = [...saveForLater];
    });
    // });

    // Future.delayed(const Duration(milliseconds: 500), () {
    //   setState(() {
    //
    //   });
    // });

    Future.microtask(() {
      Provider.of<CartProvider>(context, listen: false).loadCart();
    });

  }

  void _deleteCart(int id,int index,{String? key}) async {

    bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
    String? username =  await UserSecureStorage.getUsernameid();

    if(isGuestUser) {
      username = "GUEST";
    }

    if(key == null || key.isEmpty){

      List<dynamic> addToCart2 = await UserSecureStorage.getAddToCart("addToCart2",username ?? '');
      bool _loadedCartCache = addToCart2.any((item) => item['id'] == id);

      if(_loadedCartCache){
        await UserSecureStorage.deleteFromAddToCart(
          key: "addToCart2", // tumhara constant key name
          userId: username ?? '',
          index: index,
        );
      }



    }
    else if(key.isNotEmpty && key == saveForLaterKey){
      List<dynamic> saveForLaterCache = await UserSecureStorage.getAddToCart(saveForLaterKey,username ?? '');
      bool _loadedCartCache = saveForLaterCache.any((item) => item['id'] == id);

      if(_loadedCartCache){
        await UserSecureStorage.deleteFromAddToCart(
          key: saveForLaterKey, // tumhara constant key name
          userId: username ?? '',
          index: index,
        );
      }
    }

    _loadCart();
  }

  void addToCart(int id,String plan,String test,String qr,{String? key}) async{
    Map<String,dynamic> addToCart = {
      "id": id,
      "plan" : plan,
      "test" : test,
      "qr" : qr
    };

    bool isGuestUser = await UserSecureStorage.getIfGuestLogged() == "YES";
    print("isGuestUser : $isGuestUser");
    String? username =  await UserSecureStorage.getUsernameid();

    Map<String, dynamic>? user = await UserSecureStorage.getUser(username ?? '');


    String userId = "";
    if(isGuestUser){
      userId  = "GUEST";
    }
    else {
      userId = username ?? '';
    }

    if(key == saveForLaterKey){
      UserSecureStorage.saveAddToCard(key: key!,userId: userId, newData: addToCart);
    }
    else {
      UserSecureStorage.saveAddToCard(key: "addToCart2",userId: userId, newData: addToCart);
    }
    _loadCart();
  }


}