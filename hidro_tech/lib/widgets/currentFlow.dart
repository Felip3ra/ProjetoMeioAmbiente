import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Currentflow extends StatefulWidget {
  const Currentflow({super.key});

  @override
  State<Currentflow> createState() => _CurrentflowState();
}

class _CurrentflowState extends State<Currentflow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(width: 2, color: Color(0xffEFEFEF),),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Fluxo atual de água',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text('30L/Hour', style: GoogleFonts.inter(textStyle: TextStyle(fontSize: 12,),),),
        ],
      ),
    );
  }
}
