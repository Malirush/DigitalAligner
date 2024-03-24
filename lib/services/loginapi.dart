
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
    try{
      var response = await http.post(
      Uri.parse('http://digital-aligner.ddns.net:3000/login'),
      headers: headers,
      body: jsonEncode(body),
    );
    } catch(e){
      Navigator.pushReplacementNamed(context, 'arquivos');
    }

  
  }
}