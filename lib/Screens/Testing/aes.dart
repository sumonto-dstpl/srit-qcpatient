import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfolder/Screens/Login/loginhome.dart';
import 'package:newfolder/Screens/Widgets/gradientdivider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class LoginUHIDPage extends StatefulWidget {
  const LoginUHIDPage({
    super.key,
  });
  @override
  State<LoginUHIDPage> createState() => LoginuhidPagestate();
}

class LoginuhidPagestate extends State<LoginUHIDPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TextEditingController UserNumberEditTextController =
        TextEditingController();
    TextEditingController PasswordEditTextController = TextEditingController();
    bool hidePassword = true;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            // image: AssetImage("assets/patternbackground.png"), // Replace with your image path
            image: AssetImage("assets/Background Pattern.png"),
            fit: BoxFit.cover, // Adjusts how the image fills the container
          ),
        ),
        child: Column(
          children: <Widget>[
            // Top Section with Back Arrow and Login Text
            Container(
              padding: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenWidth * 0.05,
              ),
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.height * 0.01,
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.0,
                  left: MediaQuery.of(context).size.height * 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Arrow
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: screenHeight * 0.035,
                      width: screenHeight * 0.035,
                      decoration: BoxDecoration(
                        color: Colors.blue[100]!.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: Color(0xFF126086),
                        size: screenHeight * 0.025,
                      ),
                    ),
                  ),
                  // Login Text
                  Expanded(
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Placeholder for alignment (Empty container for symmetry)
                  SizedBox(width: screenHeight * 0.05),
                ],
              ),
            ),

            // Main Content Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenHeight * 0.03),
                    topRight: Radius.circular(screenHeight * 0.03),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(screenHeight * 0.03),
                    child: Column(
                      children: [
                        // Logo Image
                        Container(
                          margin: EdgeInsets.only(top: screenHeight * 0.01),
                          child: Image.asset(
                            'assets/splashqc.png',
                            height: screenHeight * 0.06,
                            fit: BoxFit.contain,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome Back!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.022,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Padding(
                                padding: new EdgeInsets.only(
                                    left: MediaQuery.of(context).size.height *
                                        0.00,
                                    right: MediaQuery.of(context).size.height *
                                        0.0,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.00),
                                child: Text(
                                  "Use Credentials to access your account",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.016,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),

                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.005,
                              right: MediaQuery.of(context).size.height * 0.0,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "UHID",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.005,
                              right: MediaQuery.of(context).size.height * 0.005,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.025),
                          child: new TextFormField(
                            controller: UserNumberEditTextController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                              FilteringTextInputFormatter.allow(
                                  RegExp('[a-zA-Z0-9]'))
                            ],
                            textCapitalization: TextCapitalization.characters,
                            style: TextStyle(color: Colors.black45),
                            keyboardType: TextInputType.emailAddress,
                            // onSaved: (input) => loginRequestModel.email = input,
                            validator: (input) => input!.length < 3
                                ? "UHID should be more than 3 characters"
                                : null,
                            /* validator: (input) => !input.contains('@')
                              ? "Email Id should be valid"
                              : null,*/
                            decoration: new InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              filled: true,
                              fillColor: Colors.white60,
                              hintText: "Enter your UHID",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.016, // Adjust this size
                              ),
                              /* // below code for rectangular box even without touching
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            // below code only for underline with custom color
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).accentColor)),
                                                                           */
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.lightBlue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              /*  prefixIcon: Icon(
                                Icons.account_circle_sharp,
                                color: Colors.black45,
                              ),*/
                            ),
                          ),
                        ),
                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.005,
                              right: MediaQuery.of(context).size.height * 0.0,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "OTP",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.018,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.005,
                              right: MediaQuery.of(context).size.height * 0.005,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.00),
                          child: new TextFormField(
                            controller: PasswordEditTextController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(15),
                            ],
                            style: TextStyle(color: Colors.black45),
                            keyboardType: TextInputType.text,
                            /* onSaved: (input) => loginRequestModel.password =
                          base64.encode(utf8.encode(input)),*/
                            validator: (input) => input!.length < 3
                                ? "OTP should be more than 3 characters"
                                : null,
                            obscureText: hidePassword,
                            decoration: new InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.height * 0.012,
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                              filled: true,
                              fillColor: Colors.white60,
                              hintText: "Enter the OTP",
                              hintStyle: TextStyle(
                                color: Colors.black26,
                                fontSize: MediaQuery.of(context).size.height *
                                    0.016, // Adjust this size
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(color: Colors.lightBlue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              /*  prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black45,
                              ),*/
                              /*  suffixIcon: IconButton(
                                onPressed: () {},
                                color: Colors.black45,
                                icon: Icon(hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),*/
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.00,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.height *
                                      0.005,
                                  top: MediaQuery.of(context).size.height *
                                      0.005,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    // Add your onTap logic here
                                  },
                                  child: TextButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.zero),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(Size
                                              .zero), // Ensures no extra space
                                      tapTargetSize: MaterialTapTargetSize
                                          .shrinkWrap, // Shrinks the tap area
                                    ),
                                    onPressed: () {},
                                    child: RichText(
                                      text: TextSpan(
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .merge(
                                              TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                        children: [
                                          TextSpan(
                                            text: 'Didn\'t get OTP?',
                                            style: TextStyle(
                                              color: Color(0xFF126086),
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.014,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' Resend OTP',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.018,
                                              color: Color(0xFF126086),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // forgot password and AES Encryption

                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.height * 0.005,
                            top: MediaQuery.of(context).size.height * 0.005,
                            bottom: MediaQuery.of(context).size.height * 0.0,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              // ========>>>>>>>>>>>> Decryption Code (Receiver Side)
                              // Secret key and fixed IV
                              const secretKey =
                                  "ASDFGHJKLQWERTYUIOPZXCVBNMJHGFDS";
                              const fixedIV =
                                  "1234567890123456"; // Must match the sender's IV

                              // Encrypted value received
                              const receivedEncryptedValue =
                                  // "NkMzOEU2MDVFRDdFRTk2NXIKwW3O1k2Pojh520csyaLJLJgDAsH8wULA22VLNx/x";
                                  "KZppR3PDJ2ljzFRviaq/30W1q7bV1T8pT9cjg5Wx128=";

                              // Ensure the secret key is 32 bytes long
                              final key = encrypt.Key.fromUtf8(
                                  secretKey.padRight(32).substring(0, 32));
                              final iv = encrypt.IV.fromUtf8(fixedIV);

                              // Create AES encrypter
                              final encrypter = encrypt.Encrypter(
                                  encrypt.AES(key, mode: encrypt.AESMode.cbc));

                              // Decrypt the received value
                              final decrypted = encrypter
                                  .decrypt64(receivedEncryptedValue, iv: iv);
                              print("Decrypted Value: $decrypted");

                              /*// =====================> Encryption Code (Sender Side)
                                    // Secret key and fixed IV
                                    const secretKey =
                                        "ASDFGHJKLQWERTYUIOPZXCVBNMJHGFDS";
                                    const fixedIV =
                                        "1234567890123456"; // IV must match on both sides

                                    // Input plain text JSON
                                    final plainText = jsonEncode({
                                      "patientName": "Subramani",
                                    });

                                    // Ensure the secret key is 32 bytes long
                                    final key = encrypt.Key.fromUtf8(secretKey
                                        .padRight(32)
                                        .substring(0, 32));
                                    final iv = encrypt.IV.fromUtf8(fixedIV);

                                    // Create AES encrypter
                                    final encrypter = encrypt.Encrypter(encrypt
                                        .AES(key, mode: encrypt.AESMode.cbc));

                                    // Encrypt the plain text
                                    final encrypted =
                                        encrypter.encrypt(plainText, iv: iv);
                                    print(
                                        "Encrypted Value to Send: ${encrypted.base64}");*/
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                                decorationColor: Color(0xFFC80000),
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.018,
                                color: Color(0xFFC80000),
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),

                        /// below

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Login Button
                              Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      bottom: MediaQuery.of(context).size.height *
                                          0.00,
                                      left: MediaQuery.of(context).size.height *
                                          0.00,
                                      right: MediaQuery.of(context).size.height *
                                          0.00),
                                  margin: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.height *
                                          0.01,
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                      bottom: MediaQuery.of(context).size.height *
                                          0.01,
                                      left: MediaQuery.of(context).size.height *
                                          0.01),
                                  child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.012),
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.centerRight,
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
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: TextButton(
                                              onPressed: () async {},
                                              child: Text("Login",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.026)),
                                            ),
                                          ),
                                        ),
                                      ])),
                            ],
                          ),
                        ),

                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.035,
                              right: MediaQuery.of(context).size.height * 0.035,
                              bottom: MediaQuery.of(context).size.height * 0.0),
                          child: CustomDividerWithText(),
                        ),

                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.0,
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                            ),
                            margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.02,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1, // Border width
                              ),
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Google Logo
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  child: Image.asset(
                                    'assets/googleicon.png', // Replace with your asset path
                                    height: MediaQuery.of(context).size.height *
                                        0.04, // Adjust size as needed
                                  ),
                                ),
                                // "Sign up with Google" Text
                                Flexible(
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginHome(),
                                        ),
                                        (Route route) => false,
                                      );
                                    },
                                    child: Text(
                                      "Sign up with Google",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.026,
                                        overflow: TextOverflow
                                            .ellipsis, // Enable ellipsis
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.0,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.00,
                              left: MediaQuery.of(context).size.height * 0.00,
                              right: MediaQuery.of(context).size.height * 0.00,
                            ),
                            margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.height * 0.02,
                              top: MediaQuery.of(context).size.height * 0.00,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                              left: MediaQuery.of(context).size.height * 0.02,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Border color
                                width: 1, // Border width
                              ),
                              borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.height * 0.012,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                // Google Logo
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02,
                                  ),
                                  child: Image.asset(
                                    'assets/appleicon.png', // Replace with your asset path
                                    height: MediaQuery.of(context).size.height *
                                        0.04, // Adjust size as needed
                                  ),
                                ),
                                // "Sign up with Google" Text
                                Flexible(
                                  child: TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginHome(),
                                        ),
                                        (Route route) => false,
                                      );
                                    },
                                    child: Text(
                                      "Sign up with Apple",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.026,
                                        overflow: TextOverflow
                                            .ellipsis, // Enable ellipsis
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: new EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.0,
                              right: MediaQuery.of(context).size.height * 0.0,
                              bottom: MediaQuery.of(context).size.height * 0.0),
                          child: TextButton(
                            onPressed: () {},
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .merge(
                                      TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                children: [
                                  TextSpan(
                                      text: 'Don\'t have an account ?',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenHeight * 0.022)),
                                  TextSpan(
                                      text: ' Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: screenHeight * 0.022,
                                          color: Color(0xFF126086))),
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
            ),
          ],
        ),
      ),
    );
  }
}
