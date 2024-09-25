import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidro_tech/main.dart';
import 'package:hidro_tech/service/autentication.dart';
import 'package:hidro_tech/widgets/snackbar.dart';

class passwordPage extends StatefulWidget {
  const passwordPage({super.key});

  @override
  State<passwordPage> createState() => _passwordPageState();
}

class _passwordPageState extends State<passwordPage> {
  final TextEditingController email = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined),
          ),
          title: Text(
            'Retornar ao login',
            style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
          ),
          backgroundColor: Colors.white,
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
                    child: Column(
                      children: [
                        Text(
                          'Esqueceu sua senha?',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Text(
                            'Não se preocupe! Enviaremos um código para o email informado abaixo. Antes, verifique se seu email está corretamente escrito para evitar problemas.',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: email,
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
                    height: 32,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              Autentication()
                                  .sendPasswordReset(email: email.text)
                                  .then((String? erro) {
                                if (erro != null) {
                                  showSnackBar(context: context, texto: erro);
                                } else {
                                  showSnackBar(
                                      context: context,
                                      texto:
                                          "Uma redefinição de senha foi enviado ao email informado! Verifique seu email!",
                                      isErro: false);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Roter(),
                                    ),
                                  );
                                }
                              });
                            }
                          },
                          child: Text(
                            'Envie o E-mail',
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
