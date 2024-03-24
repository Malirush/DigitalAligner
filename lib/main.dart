import 'package:flutter/material.dart';


import './screens/login.dart';
import './screens/arquivos.dart';


void main() async {
 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DigitalAlign",
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 24, 24, 24),
        fontFamily: 'Public Sans',
      ),
      initialRoute: 'TelaInicial',
      routes: {
        'TelaInicial': (context) =>   LoginPage(),
        'arquivos':(context) =>  MyHomePage(),
        
      },
    );
  }
}
