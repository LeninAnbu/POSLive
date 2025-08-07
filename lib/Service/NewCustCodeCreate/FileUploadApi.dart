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

      log('file picker:${response.body}');

      if (response.statusCode == 200) {
        return FilePostModel.fromJson(
          response.body,
          response.statusCode,
        );
      } else {
        log("File Exception11");

        return FilePostModel.issue(
          'Bad Request..',
          response.statusCode,
        );
      }
    } catch (e) {
      log("File Exception222");

      return FilePostModel.exception('Someting went wrong Try again..', 500);
    }
  }
}
