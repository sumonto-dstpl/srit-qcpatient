import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newfolder/Screens/Maps/model/place_model.dart';

class Repo {
  Repo._();
  static Future<PredictionModel?> placeAutoComplete(
      {required String placeInput}) async {
    try {
      Map<String, dynamic> querys = {
        'input': placeInput,
        'key': "AIzaSyAiP1AcEDKvV8p5DxOe3_pcxLWZaJBmSH8"
      };
      final url = Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", querys);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return PredictionModel.fromJson(jsonDecode(response.body));
      } else {
        response.body;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}