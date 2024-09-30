import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidro_tech/pages/homePage.dart';
import 'package:hidro_tech/pages/loginPage.dart';
import 'package:hidro_tech/service/autentication.dart';
import 'package:hidro_tech/widgets/snackbar.dart';
import 'package:hidro_tech/main.dart';

class profilePage extends StatefulWidget {
  const profilePage({super.key});

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool pswd = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Center(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    width: 157,
                    height: 156.47,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Seu perfil',
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
                    
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'Escreva seu E-mail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      
                      fillColor: Color(0xffd6d6d6),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  TextFormField(
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: Color(0xff333333),
                    )),
                    controller: password,
                   
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
                  SizedBox(
                    height: 13,
                  ),
                  
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              
                              Autentication().changeEmailAndPassword(email: email.text, password: password.text).then((String? erro){
                                if (erro != null) {
                                  showSnackBar(context: context, texto: erro);
                                }
                                else{
                                  showSnackBar(context: context, texto: "Um email de confirmação foi enviado!",isErro: false);

                                }
                              });
                              
                            }
                            
                          },
                          child: Text(
                            'Mudar',
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
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            
                            Autentication().deslogar();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Roter(),
                              ),
                            );
                          },
                          child: Text(
                            'Sair da conta',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                width: 1.5,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
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
