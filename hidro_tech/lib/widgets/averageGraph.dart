import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math'; // Importar a biblioteca necessária

class AverageGraph extends StatefulWidget {
  const AverageGraph({super.key});

  @override
  State<AverageGraph> createState() => _AverageGraphState();
}

class _AverageGraphState extends State<AverageGraph> {
  final DatabaseReference _databaseRef3 = FirebaseDatabase.instance.ref();
  late DatabaseReference daysRef;
  Map<String, dynamic> data3 = {};
  List dados = [0.0,0.0,0.0,0.0,0.0,0.0,0.0];
  var aux;
  @override
  void initState() {
    super.initState();
    setupListener();
  }

  void setupListener() {
    
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString();

    daysRef = _databaseRef3.child(year).child(month);

    daysRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          var snapshotValue = event.snapshot.value;
          if (snapshotValue is List) {
            data3 = Map<String, dynamic>.fromIterable(
              snapshotValue.asMap().entries,
              key: (entry) => (entry.key + 1).toString(),
              value: (entry) => entry.value,
            );
          } else if (snapshotValue is Map) {
            data3 = Map<String, dynamic>.from(snapshotValue as Map);
          }
        });
      }
    });
  }
  int aux2 = 0;
  double convertValue(Object? value) {
    if (value is Map<Object?, Object?>) {
      if (aux2 == 0) {
        var innerValue = value['dia_da_semana'];
        aux2 = 1;
        return convertValue(innerValue);
      } else {
        var innerValue = value['dado'];
        aux2 = 0;
        return convertValue(innerValue);
      }
      
      
    }

    if (value == null) {
      return 0;
    }

    if (value is int) {
      return value.toDouble();
    }

    if (value is double) {
      return value;
    }

    if (value is String) {
      try {
        //arrumar aqui
        switch (value) {
          case "Segunda-feira":
            dados[0] = dados[0] + convertValue(aux); 
            break;
          case "Terça-feira":
            dados[1] = dados[1] + convertValue(aux); 
            break;
          case "Quarta-feira":
            dados[2] = dados[2] + convertValue(aux); 
            break;
          case "Quinta-feira":
            dados[3] = dados[3] + convertValue(aux); 
            break;
          case "Sexta-feira":
            dados[4] = dados[4] + convertValue(aux); 
            break;
          case "Sábado":
            dados[5] = dados[5] + convertValue(aux); 
            break;
          case "Domingo":
            dados[6] = dados[6] + convertValue(aux); 
            break;
          default:
        }
        return 0;
      } catch (e) {
        print("Falha ao converter string para double: $value");
        return 0;
      }
    }

    print("Tipo de valor não reconhecido: ${value.runtimeType}");
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 2, color: Color(0xffEFEFEF)),
        color: Colors.white,
      ),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Consumo total de água do mês atual',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: barGroups(),
                  gridData: const FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blueAccent,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Seg';
        break;
      case 1:
        text = 'Ter';
        break;
      case 2:
        text = 'Qua';
        break;
      case 3:
        text = 'Qui';
        break;
      case 4:
        text = 'Sex';
        break;
      case 5:
        text = 'Sáb';
        break;
      case 6:
        text = 'Dom';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );


  List<BarChartGroupData> barGroups() {
    List<BarChartGroupData> groups = [];

    // Cria os grupos de barras com base nos dados obtidos do Firebase
    setState(() {
      dados = [0.0,0.0,0.0,0.0,0.0,0.0,0.0];
      for (int i = 0; i < 30; i++) {
        // Assumindo 30 dias no mês
        String day =
            (i + 1).toString(); // Formato de dia com 0 à esquerda
        int cvs = int.parse(day) + 1;
        var value =
            data3[cvs.toString()] ?? 0; // Pega o valor ou 0 se não existir
        aux = value;
        // Verifica e imprime o valor e seu tipo antes da conversão
        print("Valor antes da conversão: $value (Tipo: ${value.runtimeType})");
        double convertedValue = convertValue(value); // Converte o valor
        print("Valor convertido: $convertedValue");
        
        
      }
      for (var i = 0; i <= 6; i++) {
        if (true) {
          groups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: dados[i], 
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ),
        );
        } 
      }
    });

    return groups;
  }


  
}
