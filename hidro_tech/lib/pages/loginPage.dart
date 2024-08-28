import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
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
              border: Border.all(width: 3, color: Color(0xfff0f0f0))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ainda não tem uma conta?', style: TextStyle(color: Color(0xff333333),fontSize: 16,),),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cadastre-se',
                      style: TextStyle(
                        color: Color(0xff2563EB),
                        fontSize: 16,
                      ),
                    ),),
              ],
            ),
          ),
        ), 
        body: Center(
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
                TextField(
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
                TextField(
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
    );
  }
}
