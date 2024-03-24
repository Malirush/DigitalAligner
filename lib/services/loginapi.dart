
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';





class ApiService {
  static Future<void> login(String email, String password,context) async {
    print(email);
    print(password);

    var headers = {
      'User-Agent': 'Apidog/1.0.0 (https://apidog.com)',
      'Content-Type': 'application/json',
    };
   var body = {
      'email': email,
      'password': password,
    };
    
    var response = await http.post(
      Uri.parse('http://digital-aligner.ddns.net:3000/login'),
      // headers: headers,
      body: jsonEncode(body),
    );
    

    if (response.statusCode == 401) {   //Teste mesmo com erro
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true) {
        Navigator.pushReplacementNamed(context, 'arquivos');
        
      } else {
        Navigator.pushReplacementNamed(context, 'arquivos');
        throw Exception('Credenciais inválidas');
      }
    } else {
      Navigator.pushReplacementNamed(context, 'arquivos');
      throw Exception('Erro ao fazer login: ${response.reasonPhrase}');
    }
  }
}