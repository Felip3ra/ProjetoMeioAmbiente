import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidro_tech/pages/loginPage.dart';

class codePage extends StatefulWidget {
  const codePage({super.key});

  @override
  State<codePage> createState() => _codePageState();
}

class _codePageState extends State<codePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_outlined),
          title: Text(
            'Retornar ao login',
            style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16)),
          ),
          backgroundColor: Colors.white,
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
                  child: Column(
                    children: [
                      Text(
                        'Escreva seu código',
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
                          'Um email com o código de segurança foi enviado para felipesantanasantos1812@gmail.com',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 56,
                      child: TextField(
                        style: GoogleFonts.poppins(),
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xffd6d6d6),
                            contentPadding: EdgeInsets.symmetric(vertical: 15)),
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: TextField(
                        style: GoogleFonts.poppins(),
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xffd6d6d6),
                            contentPadding: EdgeInsets.symmetric(vertical: 15)),
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: TextField(
                        style: GoogleFonts.poppins(),
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xffd6d6d6),
                            contentPadding: EdgeInsets.symmetric(vertical: 15)),
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: TextField(
                        style: GoogleFonts.poppins(),
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xffd6d6d6),
                            contentPadding: EdgeInsets.symmetric(vertical: 15)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Envie o código novamente',
                          style: TextStyle(
                            color: Color(0xff2563EB),
                            fontSize: 16,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => loginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Validar',
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
