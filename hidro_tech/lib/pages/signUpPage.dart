import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidro_tech/pages/homePage.dart';
import 'package:hidro_tech/pages/loginPage.dart';
import 'package:hidro_tech/service/autentication.dart';
import 'package:hidro_tech/widgets/snackbar.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool pswd = false;
  Autentication _authService = Autentication();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.all(0),
          height: 60,
          surfaceTintColor: Colors.white,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 3, color: Color(0xfff0f0f0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Já possui uma conta?',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Entrar',
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
                      'Cadastra-se',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    style: GoogleFonts.poppins(),
                    controller: email,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Por favor digite seu email!";
                      }
                      return null;
                    },
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: TextFormField(
                      obscureText: pswd ? false : true,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                        color: Color(0xff333333),
                      )),
                      controller: password,
                      validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return "Por favor digite sua senha!";
                        }
                        return null;
                      },
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
                          onPressed: () {},
                          icon: Icon(
                            Icons.remove_red_eye_outlined,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff333333),
                    )),
                    validator: (senha) {
                      if (senha == null || senha.isEmpty) {
                        return "Por favor digite sua senha novamente!";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      hintText: 'Confirme sua senha',
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
                          pswd
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _authService
                                  .cadastrarUsuario(
                                      email: email.text, senha: password.text)
                                  .then((String? erro) {
                                if (erro != null) {
                                  showSnackBar(context: context, texto: erro);
                                } else {
                                  showSnackBar(
                                      context: context,
                                      texto: "Cadastro efetuado com sucesso!",
                                      isErro: false);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => homePage(),
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            'Cadastrar',
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
