import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/profile_model.dart';

import '../utils/ApiConstant.dart';

Future<profileModel> userProfileData() async {

    http.Response response = await http.post(
      Uri.parse(ApiUrls.userProfile),
      headers: await getUserToken(),
    );

    print("Response Code......     ${response.body}");
    print("Status Code......     ${response.statusCode}");
    if (response.statusCode == 200) {
      return profileModel.fromJson(jsonDecode(response.body));
    } else {
      return profileModel(
        message: jsonDecode(response.body),

      );
    }

}
