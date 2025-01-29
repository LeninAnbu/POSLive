import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/Service%20Model/FileUpload.dart';
import 'package:posproject/url/url.dart';

class FilePostApi {
  static Future<FilePostModel> getFilePostData(
    String? fileBytes,
    String? filename,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(
          '${URL.urlLocal}SaveToPhysicalLocation',
        ),
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode({
          'files': [
            {
              'imageBytes': '$fileBytes',
              'filePath': 'D:\\Checkout Attachements\\$filename'
            }
          ]
        }),
      );

      // log(jsonEncode({
      //   'files': [
      //     {
      //       'imageBytes': '$fileBytes',
      //       'filePath': 'D:\\Checkout Attachements\\$filename'
      //     }
      //   ]
      // }));
      log('file picker:${response.body}');

      // log("json: " +
      //     jsonEncode({
      //       "files": [
      //         {
      //           "imageBytes": "$fileBytes",
      //           "filePath": "C:\\SupportApp\\Profile\\$filename"
      //         }
      //       ]
      //     }).toString());

      // log("file picker:" + response.body.toString());
      if (response.statusCode == 200) {
        return FilePostModel.fromJson(
          response.body,
          response.statusCode,
        );
      } else {
        log("File Exception11");
        //  throw Exception("Error");

        return FilePostModel.issue(
          'Something went wrong Bad Request..',
          response.statusCode,
        );
      }
    } catch (e) {
      log("File Exception222");

      // throw Exception(e.toString());
      return FilePostModel.exception('Someting went wrong Try again..', 500);
    }
  }
}
