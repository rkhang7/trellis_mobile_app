import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class FileRepository {
  void uploadImage(XFile file) async {
    String fileName = file.path.split('/').last;

    FormData data = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    Dio dio = Dio();

    dio
        .post("http://10.0.2.2:8080/storage/uploadFile", data: data)
        .then(
          (response) => print(response),
        )
        .catchError(
          (error) => print(error),
        );
  }
}
