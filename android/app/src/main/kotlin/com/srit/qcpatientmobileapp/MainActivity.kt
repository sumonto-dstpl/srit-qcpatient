////package com.companyname.qcpatientmobileapp.newfolder
//package com.srit.qcpatientmobileapp
//
//import android.os.Bundle
//import io.flutter.embedding.android.FlutterActivity
//import io.flutter.embedding.engine.FlutterEngine
//import io.flutter.plugins.GeneratedPluginRegistrant
//import android.content.pm.PackageManager
//import android.os.Build
//import androidx.core.app.ActivityCompat
//import androidx.core.content.ContextCompat
//import io.flutter.embedding.android.FlutterFragmentActivity
//
////class MainActivity: FlutterActivity() {
//class MainActivity: FlutterFragmentActivity() {
//    private val REQUEST_CODE = 1001
//
//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        // 🔹 This is required for plugin registration (including local_auth)
//        GeneratedPluginRegistrant.registerWith(flutterEngine)
//    }
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        checkLocationPermission()
//    }
//
//    private fun checkLocationPermission() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            if (ContextCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION)
//                != PackageManager.PERMISSION_GRANTED) {
//                ActivityCompat.requestPermissions(this,
//                    arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION), REQUEST_CODE)
//            }
//        }
//    }
//}


package com.srit.qcpatientmobileapp

import android.os.Bundle
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        println("✅ Using FlutterFragmentActivity at runtime")
    }
}
