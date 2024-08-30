import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class connectPage extends StatefulWidget {
  const connectPage({super.key});

  @override
  State<connectPage> createState() => _connectPageState();
}

class _connectPageState extends State<connectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(width: 1, color: Color(0xffF0F0F0),),),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/logo2.png'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.hardware_outlined), label: 'Connect'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment_outlined), label: 'Graphs'),
        ],
      ),
      body: Center(
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
                      'Registre seu SSID',
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
                      prefixIcon: Icon(Icons.wifi),
                      hintText: 'Escreva seu SSID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffd6d6d6),
                      contentPadding: EdgeInsets.symmetric(vertical: 15)),
                ),
                SizedBox(height: 13,),
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
                SizedBox(height: 40,),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Conectar',
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
    );
  }
}