import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import '../model/update_profile_model.dart';

import '../utils/ApiConstant.dart';
import '../utils/helper.dart';

Future<UpdateprofileModel> updateProfile({
  required mapData,
  required fieldName1,
  required File file1,
  required context,
}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);
  try {
    var request = http.MultipartRequest('POST', Uri.parse(ApiUrls.updateProfile));

    request.headers.addAll(await getUserToken());

    request.fields.addAll(mapData);

    if (file1.path != "") request.files.add(await multipartFile(fieldName1, file1));

    log(request.fields.toString());
    log(request.files.toString());

    final response = await request.send();
    Helpers.hideLoader(loader);
    if (response.statusCode == 200) {
      Helpers.hideLoader(loader);
      // log(jsonDecode(response.body)["message"]);
      return UpdateprofileModel.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else {
      Helpers.hideLoader(loader);
      return UpdateprofileModel.fromJson(jsonDecode(await response.stream.bytesToString()));
    }
  } on SocketException {
    Helpers.hideLoader(loader);
    return UpdateprofileModel(message: "No Internet Access", status: false);
  } catch (e) {
    Helpers.hideLoader(loader);
    return UpdateprofileModel(message: e.toString(), status: false);
  }
}

Future<http.MultipartFile> multipartFile(String? fieldName, File file1) async {
  return http.MultipartFile(
    fieldName ?? 'file',
    http.ByteStream(Stream.castFrom(file1.openRead())),
    await file1.length(),
    filename: file1.path.split('/').last,
  );
}
