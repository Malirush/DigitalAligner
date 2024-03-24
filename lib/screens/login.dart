import 'package:flutter/material.dart';
import 'package:teste/screens/arquivos.dart';
import '/services/loginapi.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);




  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background2.png'),
              fit: BoxFit.fill,
            ),
          ),

          child: Center(
            child: SizedBox(
              height: 280,
              width: 360,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '👋Bem-vindo (a)',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF54C8E8),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 60, right: 60, top: 10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 60, right: 60, top: 20),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                              String email = emailController.text;
                              String senha = passwordController.text;
                              Navigator.pushReplacementNamed(context, 'arquivos');
                              //ApiService.login(email, senha, context);
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0074FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 90, right: 90, top: 18, bottom: 18),
                          child: Text(
                            'Entrar',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
