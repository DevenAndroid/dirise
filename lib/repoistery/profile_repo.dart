import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/profile_model.dart';

import '../utils/ApiConstant.dart';

Future<profileModel> userProfileData() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader: 'Bearer ${user.authToken}'
  };
  // print(user.authToken);
  http.Response response = await http.get(Uri.parse(ApiUrls.userProfile), headers: headers);
  if (response.statusCode == 200 || response.statusCode == 400) {
    print("<<<<<<<UserProfileData from repository=======>${response.body}");
    return profileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}
