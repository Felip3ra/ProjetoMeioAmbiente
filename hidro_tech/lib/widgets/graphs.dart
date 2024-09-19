import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidro_tech/models/option.dart';
import 'dart:async';

int _controle = 0;
int? op = 0;

class graphs extends StatefulWidget {
  graphs({super.key, required this.option});
  final Option option;

  @override
  State<graphs> createState() => _graphsState();
}

class _graphsState extends State<graphs> {
  late Timer _timer;
  String? texto;
  int? op2;
  @override
  void initState() {
    super.initState();
    // Inicia um temporizador que atualiza a cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        op = widget.option.optionSelect;
        if (op != op2) {
          _controle = 0;
          op2 = op;
        } else {
          
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancela o temporizador ao destruir o widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: Color(0xffEFEFEF),
          ),
          color: Colors.white),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (_controle != 0) {
                          _controle--;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined)),
                Text(
                  widget.option.text_,
                  style: GoogleFonts.poppins(
                    textStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (_controle != 5 && op == 0) {
                          _controle++;
                        }
                        else if(_controle != 7 && op == 1){
                          _controle++;
                        }
                        else if(_controle != 2 && op == 2){
                          _controle++;
                        }
                      });
                    },
                    icon: Icon(Icons.arrow_forward_ios_outlined)),
              ],
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  barTouchData: barTouchData,
                  titlesData: titlesData,
                  borderData: borderData,
                  barGroups: barGroups,
                  gridData: const FlGridData(show: false),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
      if (op == 0) {
        const valores = ['00', '04', '08', '12', '16', '20'];
        text = valores[_controle];
      } 
      else if(op == 1){
        const valores = ['01', '05', '09', '13', '17', '21','25','29'];
        text = valores[_controle];
      }
      else if(op == 2){
        const valores = ['01', '05', '09'];
        text = valores[_controle];
      }
      else {
        text = '';
      }
      //text = 'Mn';
      break;
    case 1:
      if (op == 0) {
        const valores = ['01', '05', '09', '13', '17', '21'];
        text = valores[_controle];
      }
      else if(op == 1){
        const valores = ['02', '06', '10', '14', '18', '22','26','30'];
        text = valores[_controle];
      }
      else if(op == 2){
        const valores = ['02', '06', '10'];
        text = valores[_controle];
      } 
      else {
        text = '';
      }
      break;
    case 2:
      if (op == 0) {
        const valores = ['02', '06', '10', '14', '18', '22'];
        text = valores[_controle];
      }
      else if(op == 1){
        const valores = ['03', '07', '11', '15', '19', '23','27','31'];
        text = valores[_controle];
      } 
      else if(op == 2){
        const valores = ['03', '07', '11'];
        text = valores[_controle];
      }
      else {
        text = '';
      }
      break;
    case 3:
      if (op == 0) {
        const valores = ['03', '07', '11', '15', '19', '23'];
        text = valores[_controle];
      }
      else if(op == 1){
        const valores = ['04', '06', '12', '16', '20', '24','28','-'];
        text = valores[_controle];
      } 
      else if(op == 2){
        const valores = ['04', '08', '12'];
        text = valores[_controle];
      }
      else {
        text = '';
      }

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

List<BarChartGroupData> get barGroups => [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 8,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 12,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 14,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 15,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      ),
    ];
