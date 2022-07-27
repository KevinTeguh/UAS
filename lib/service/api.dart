import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mahasiswa_app/model/mahasiswa_model.dart';

class Api{
  static var url = 'http://192.168.147.200/api/mahasiswa';

  static Future<List<MahasiswaModel>> getMahasiswa() async {
    try {
      var response = await http.get(Uri.parse(url));
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (jsonResponse['data'] != null) {
        List<MahasiswaModel> data = (jsonResponse['data'] as List?) != null &&
            (jsonResponse['data'] as List).isNotEmpty
            ? (jsonResponse['data'] as List)
            .map((f) => MahasiswaModel.fromJson(f))
            .toList()
            : [];
        return data;
      } else {
        throw jsonResponse['message'];
      }
    } catch (e) {
      throw e;
    }
  }


  static Future<String> addMahasiswa(Map body) async {
    try {
      var response = await http.post(Uri.parse(url),body: body);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      if (response.statusCode == 200) {
        return jsonResponse['message'];
      } else {
        throw jsonResponse['message'];
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<String> updateMahasiswa(Map body,String id) async {
    try {
      var response = await http.post(Uri.parse('$url/$id'),body: body);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      if (response.statusCode == 200) {
        return jsonResponse['message'];
      } else {
        throw jsonResponse['message'];
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<String> deleteMahasiswa(String id) async {
    try {
      var response = await http.delete(Uri.parse('$url/$id'),);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(jsonResponse);
      if (response.statusCode == 200) {
        return jsonResponse['message'];
      } else {
        throw jsonResponse['message'];
      }
    } catch (e) {
      throw e;
    }
  }
}