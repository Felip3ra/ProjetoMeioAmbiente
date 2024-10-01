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

  double convertValue(Object? value) {
    if (value is Map<Object?, Object?>) {
      var innerValue = value['dado'];
      return convertValue(innerValue);
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
        return double.parse(value);
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
                  'Média de fluxo de água',
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
                  maxY: getMaxY(),
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

  double getMaxY() {
    // Retorna o máximo valor de Y com base nos dados
    double maxY = 0;
    for (var day in data3.values) {
      maxY = max(maxY, convertValue(day));
    }
    return maxY + 5; // Adiciona um buffer
  }

  List<BarChartGroupData> barGroups() {
    Map<String, double> dailyAverages = calculateDailyAverages();

    return List.generate(7, (index) {
      String weekday = _getWeekdayName(index + 1);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: dailyAverages[weekday] ?? 0,
            gradient: _barsGradient,
          )
        ],
        showingTooltipIndicators: [0],
      );
    });
  }

  Map<String, double> calculateDailyAverages() {
    Map<String, double> sums = {
      'Seg': 0,
      'Ter': 0,
      'Qua': 0,
      'Qui': 0,
      'Sex': 0,
      'Sáb': 0,
      'Dom': 0,
    };
    Map<String, int> counts = {
      'Seg': 0,
      'Ter': 0,
      'Qua': 0,
      'Qui': 0,
      'Sex': 0,
      'Sáb': 0,
      'Dom': 0,
    };

    data3.forEach((key, value) {
      int dayOfWeek = int.tryParse(key) ?? 0;
      if (dayOfWeek >= 1 && dayOfWeek <= 7) {
        String weekday = _getWeekdayName(dayOfWeek);
        double convertedValue = convertValue(value);
        sums[weekday] = sums[weekday]! + convertedValue;
        counts[weekday] = counts[weekday]! + 1;
      }
    });

    // Calcula a média
    Map<String, double> averages = {};
    sums.forEach((key, value) {
      averages[key] = counts[key] == 0 ? 0 : value / counts[key]!;
    });

    return averages;
  }

  String _getWeekdayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Seg';
      case 2:
        return 'Ter';
      case 3:
        return 'Qua';
      case 4:
        return 'Qui';
      case 5:
        return 'Sex';
      case 6:
        return 'Sáb';
      case 7:
        return 'Dom';
      default:
        return '';
    }
  }
}
