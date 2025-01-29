class FilePostModel{
  int? stCode;
  String?exception;
String? filepath;

  FilePostModel({
   required this.exception,
   required this.stCode,
   required this.filepath,
  });
   factory FilePostModel.fromJson(String jsons,int stcode) {
      return FilePostModel(
       exception: null,
       stCode: stcode,
       filepath: jsons,
      );
  }

   factory FilePostModel.issue(String json,int? stcode) {
      return  FilePostModel(
       exception: json,
       stCode: stcode,
      filepath: null,

      );
  }

     factory FilePostModel.exception(String exp,int? stcode) {
      return FilePostModel(
       exception: exp,
       stCode: stcode,
       filepath: null,
          );
  }
}
