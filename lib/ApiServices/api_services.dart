import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_api/model/post_details_model.dart';
import 'package:new_api/model/post_model.dart';

class ApiServices {
  static Future<List<PostModel>?> fetchData() async {
    try {

      // final response = await http.get(Uri.parse('https://picsum.photos/v2/list'));
      final response = await http.get(Uri.parse('https://dummyjson.com/users'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // final postList = jsonData['users'] as List;
        // return postList.map((e) => PostModel.fromJson(e)).toList();
        final List<dynamic> postList = jsonData['users'];
        return postList.map((e) => PostModel.fromJson(e)).toList();

      } else {
        debugPrint("Failed with status code: ${response.statusCode}");
        return null;
      }
    } catch (error) {
      debugPrint("Error fetching data: $error");
      return null;
    }
  }

  static Future<PostDetailsModel?> fetchSinglePost(String id)async {
    try {
      final singleResponse = await http.get(Uri.parse('https://dummyjson.com/users/$id'));
      if(singleResponse.statusCode == 200){
        final singleJsonData = jsonDecode(singleResponse.body);
        return PostDetailsModel.fromJson(singleJsonData);

      }
      else{
        debugPrint("Error is ${singleResponse.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Error is $e");
      return null;
    }
  }
}

