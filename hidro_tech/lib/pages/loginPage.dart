import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidro_tech/pages/homePage.dart';
import 'package:hidro_tech/pages/passwordPage.dart';
import 'package:hidro_tech/pages/signUpPage.dart';
import 'package:hidro_tech/service/autentication.dart';
import 'package:hidro_tech/widgets/snackbar.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool pswd = false;
  Autentication _authService = Autentication();
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.all(0),
          height: 60,
          color: Colors.white,
          child: Container(
            
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Color(0xfff0f0f0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ainda não tem uma conta?',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => signUpPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Cadastre-se',
                    style: TextStyle(
                      color: Color(0xff2563EB),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(
          
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    width: 157,
                    height: 156.47,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Por favor digite seu email!";
                      } 
                      return null;
                    },
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Escreva seu E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xffd6d6d6),
                        contentPadding: EdgeInsets.symmetric(vertical: 15)),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: pswd ? false: true,
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return "Por favor digite sua senha!";
                      } 
                      return null;
                    },
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff333333),
                    )),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      hintText: 'Escreva sua senha',
                      
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      filled: true,
                      
                      fillColor: Color(0xffd6d6d6),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                          pswd = !pswd;
                        });
                        },
                        icon: Icon(
                          pswd ? Icons.visibility_off_outlined:Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => passwordPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Esqueçeu sua senha?',
                            style: TextStyle(
                              color: Color(0xff2563EB),
                              fontSize: 16,
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 42,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _authService.loginUsers(email: email.text, password: password.text).then((String? erro){
                                if (erro != null) {
                                  showSnackBar(context: context, texto: erro);
                                }
                              });
                              
                            }
                            
                          },
                          child: Text(
                            'Entrar',
                            style: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                0xFF2563EB,
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
