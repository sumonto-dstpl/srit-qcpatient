import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:newfolder/Screens/Utils/utils.dart';

final secureStorage = FlutterSecureStorage();
Future<bool> saveMpinAndEnabled(String mpin,String isMpinEnabled) async {
  await secureStorage.write(key: 'mpin', value: encodeBase64(mpin));
  await secureStorage.write(key: 'mpinEnabled', value: (isMpinEnabled));
  return true;
}
Future<bool> isForgetMpinSet() async {
  final value = await secureStorage.read(key: 'forgetMpin');
  return value == 'true';
}

Future<bool> checkEnableMpin() async{
  final storedPassword = await secureStorage.read(key: 'mpinEnabled');


  if(storedPassword != null) {
    return true;
  }
  else{
    return false;
  }
}
// Delete 'forgetMpin' key
Future<void> deleteForgetMpin() async {
  await secureStorage.delete(key: 'forgetMpin');
}

Future<bool> isMpinMatched(String inputMpin) async {
  final storedEncodedMpin = await secureStorage.read(key: 'mpin');
  if (storedEncodedMpin == null) return false;

  // Encode the input to base64 and compare
  final encodedInput = encodeBase64(inputMpin);
  return storedEncodedMpin == encodedInput;
}


Future<void> deleteEnableMpin() async {
  await secureStorage.delete(key: 'mpinEnabled');
}

Future<void> setForgetMpinTrue() async {
  await secureStorage.write(key: 'forgetMpin', value: 'true');
}



