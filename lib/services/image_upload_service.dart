// ignore: deprecated_member_use
import 'dart:html' as html;
import 'package:http/http.dart' as http;

Future<void> uploadImage(html.File imageFile) async {
  final reader = html.FileReader();
  reader.readAsArrayBuffer(imageFile);
  reader.onLoadEnd.listen((e) async {
    var uri = Uri.parse('http://localhost:5000/ocr');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'image',
        reader.result as List<int>,
        filename: imageFile.name,
      ));
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      // Handle the extracted text
    } else {
      // Handle error
    }
  });
}
