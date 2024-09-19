import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class hardwareStatus extends StatelessWidget {
  const hardwareStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 167,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(width: 2, color: Color(0xffEFEFEF)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hardware Status",
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HARDWARE',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'ESP32',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(fontSize: 12, ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'NETWORK',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'UNISANTA',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'STATUS',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'CONNECTED',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(fontSize: 12, color: Color(0XFF2563EB),backgroundColor: Color(0xffCEDCFC),),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'OPERATION',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                'WORKING',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(fontSize: 12, color: Color(0XFF2563EB),backgroundColor: Color(0xffCEDCFC),),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
