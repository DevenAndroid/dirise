import 'dart:convert';
import 'dart:io';
import 'package:dirise/model/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../model/model_whishlist.dart';
import '../utils/ApiConstant.dart';

Future<WhishlistModel> getWishlistData() async {

  var map = <String, dynamic>{};
  SharedPreferences pref = await SharedPreferences.getInstance();
  var token;
  if(pref.getString('user')!=null){
    LoginModal? user = LoginModal.fromJson(jsonDecode(pref.getString('user')!));
    token = user.token;
  } else {
    map['device_id'] = pref.getString('deviceId');
  }
  map['currency_code'] = pref.getString('userCurrency') != null ? pref.getString("userCurrency") : "USD";

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: "Bearer $token"
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.wishListUrl),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    return WhishlistModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}