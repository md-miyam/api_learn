import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_api/model/post_details_model.dart';
import 'package:new_api/model/post_model.dart';

class ApiServices {
  // get all data
  static Future<List<PostModel>?> fetchData() async {
    try {
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
  // get single data
  static Future<PostDetailsModel?> fetchSinglePost(String id) async {
    try {
      final singleResponse =
          await http.get(Uri.parse('https://dummyjson.com/users/$id'));
      if (singleResponse.statusCode == 200) {
        final singleJsonData = jsonDecode(singleResponse.body);
        return PostDetailsModel.fromJson(singleJsonData);
      } else {
        debugPrint("Error is ${singleResponse.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Error is $e");
      return null;
    }
  }

  // post data
  static Future postData(String title,String body,String userId,) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "title": title,
          "body": body,
          "userId": userId,
          "id" : 103,
        }),
      );

      if (response.statusCode == 201) {
        debugPrint("post create ${jsonDecode(response.body)}");
        return jsonDecode(response.body);
      } else {
        debugPrint("post create failed");
        return null;
      }
    } catch (e) {
      debugPrint("error is $e");
      return null;
    }
  }

}

//<Map<String, dynamic>?>