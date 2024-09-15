import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/plant_identification.dart';
import '../models/plant_detail.dart';
import '../utils/constants.dart';

class PlantApiService {
  static Future<List<PlantIdentification>> identifyPlant(File image) async {
    var url = Uri.parse('https://my-api.plantnet.org/v2/identify/all?api-key=${Constants.apiKey}');

    var request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('images', image.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return (jsonResponse['results'] as List)
          .map((result) => PlantIdentification.fromJson(result))
          .toList();
    } else {
      throw Exception('Failed to identify plant');
    }
  }

  static Future<PlantDetail> getPlantDetails(String gbifId) async {
    var url = Uri.parse('https://api.gbif.org/v1/species/$gbifId');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return PlantDetail.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get plant details');
    }
  }
}