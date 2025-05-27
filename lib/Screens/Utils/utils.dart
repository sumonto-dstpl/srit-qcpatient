import 'dart:convert';

String encodeBase64(String input) {
  return base64Encode(utf8.encode(input));
}

String decodeBase64(String encoded) {
  return utf8.decode(base64Decode(encoded));
}
