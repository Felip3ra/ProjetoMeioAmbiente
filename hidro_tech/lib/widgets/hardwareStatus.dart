import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';



class Hardwarestatus extends StatefulWidget {
  const Hardwarestatus({super.key});

  @override
  State<Hardwarestatus> createState() => _HardwarestatusState();
}

class _HardwarestatusState extends State<Hardwarestatus> {

  String timeEstamp = '';
  var ssid;
  final DatabaseReference _databaseRef2 =
      FirebaseDatabase.instance.ref(); // Referência ao banco de dados
  Map<String, dynamic> data2 = {}; // Armazena os dados lidos
  
  late DatabaseReference
      SSIDRef; // Referência ao caminho específico no Firebase
  
  

  @override
  void initState() {
    super.initState();
    setupListener(); // Configura o listener para dados em tempo real
  }

  // Função para configurar o listener em tempo real
  void setupListener() {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();

    // Caminho baseado no ano e mês
    SSIDRef = _databaseRef2.child("SSID");
    
    // Ouvinte em tempo real
    SSIDRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          var snapshotValue = event.snapshot.value;
          timeEstamp = DateTime.now().toString();
          
          if (snapshotValue is List) {
            // Se for uma lista, converte para um Map
            data2 = Map<String, dynamic>.fromIterable(
              snapshotValue.asMap().entries,
              key: (entry) =>
                  (entry.key + 1).toString(), // Os dias (índice da lista + 1)
              value: (entry) => entry.value,
            );
          } else if (snapshotValue is Map) {
            // Se for um Map, mantém como está
            data2 = Map<String, dynamic>.from(snapshotValue as Map);
          }
          
          try {
            setState(() {
              ssid = snapshotValue ?? '';
            });
          } catch (e) {
            setState(() {
              
            });
          }
          
        });
      } else {
        setState(() {
          data2 = {};
          
        });
      }
    });
  }
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
                ssid != null ? ssid:'nada',
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
                'LAST UPDATE',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffCEDCFC),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text(
                  timeEstamp,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(fontSize: 12, color: Colors.black,),
                  ),
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }

  String? convertValue(Object? value) {
    if (value is Map<Object?, Object?>) {
      // Se o valor é um mapa, tenta acessar a chave "dado"
      var innerValue = value['SSID'];
      return convertValue(innerValue); // Chama a função recursivamente
    }
    if (value == null) {
      return 'nada'; // Retorna 0 se o valor for null
    }
    if (value is String) {
      return value;
    }
  }
}


