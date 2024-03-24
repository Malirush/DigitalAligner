import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<void> uploadFiles(List<File> files) async {
  

  
    var url = Uri.parse('http://digital-aligner.ddns.net:3000/api/v1/uploads');

  var headers = {
    'Authorization': 'Bearer TOKEN',
    'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
  };

  var request = http.MultipartRequest('POST', url)
    ..headers.addAll(headers);
  print(request);
  for (var file in files) {
    request.files.add(await http.MultipartFile.fromPath('arquivo', file.path));
  }
  
    var response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print('Erro: ${response.reasonPhrase}');
    }
  
}