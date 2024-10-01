import 'dart:ffi';

import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

int _controle = 0;
int? op = 0;
int control = 0;

class GraphsPage extends StatefulWidget {
  @override
  State<GraphsPage> createState() => _GraphsPageState();
}

class _GraphsPageState extends State<GraphsPage> {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref(); // Referência ao banco de dados
  Map<String, dynamic> data = {}; // Armazena os dados lidos
  bool isLoading = true; // Flag para indicar carregamento
  double? valor = 0;
  double? media = 0;
  double? total = 0;
  double? litro = 0;
  double? litroMedio = 0;
  double? litroTotal = 0;
  late DatabaseReference
      yearMonthRef; // Referência ao caminho específico no Firebase

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
    yearMonthRef = _databaseRef.child(year).child(month);

    // Ouvinte em tempo real
    yearMonthRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          var snapshotValue = event.snapshot.value;

          if (snapshotValue is List) {
            // Se for uma lista, converte para um Map
            data = Map<String, dynamic>.fromIterable(
              snapshotValue.asMap().entries,
              key: (entry) =>
                  (entry.key + 1).toString(), // Os dias (índice da lista + 1)
              value: (entry) => entry.value,
            );
          } else if (snapshotValue is Map) {
            // Se for um Map, mantém como está
            data = Map<String, dynamic>.from(snapshotValue as Map);
          }
          for (var i = 1; i <= data.length; i++) {
            media = media! + convertValue(data[i.toString()] ?? 0);
          }
          total = media;
          valor = convertValue(data[(now.day + 1).toString()] ?? 0);
          litro = valor;
          litroMedio = media!/data.length;
          litroTotal = media;
          try {
            setState(() {
              valor = (valor! / 1000) * 5.38;
              media = ((media! / 1000) / 31) * 5.38;
              total = total!/1000 * 5.38;
            });
          } catch (e) {
            setState(() {
              valor = 0;
            });
          }
          isLoading = false;
        });
      } else {
        setState(() {
          data = {};
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Mostra um indicador de carregamento
          : data.isEmpty
              ? Center(
                  child:
                      Text('Nenhum dado disponível.')) // Caso não tenha dados
              : Column(
  
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: Color(0xffB1B1B1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              
                              decoration: BoxDecoration(
                                border: Border.symmetric(
                                  vertical: BorderSide(
                                    width: 1,
                                    color: Color(0xffB1B1B1),
                                  ),
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    op = 0;
                                    control = 0;
                                    _controle = 0;
                                  });
                                },
                                child: Text('Dia'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  op = 1;
                                  control = 0;
                                  _controle = 0;
                                });
                              },
                              child: Text('Mês'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        //margin: EdgeInsets.symmetric(horizontal: 10,),
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
                        padding: EdgeInsets.symmetric(vertical: 10),
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
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_controle != 0) {
                                            _controle--;
                                            control -= 4;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.arrow_back_ios_outlined)),
                                  Text(
                                    'Setembro - 2024',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_controle != 7 && op == 0) {
                                            _controle++;
                                            control += 4;
                                            print('to aqui $_controle');
                                          } else if (_controle != 2 && op == 1) {
                                            _controle++;
                                            
                                          } 
                      
                                          
                                        });
                                      },
                                      icon:
                                          Icon(Icons.arrow_forward_ios_outlined)),
                                ],
                              ),
                              
                      
                              Expanded(
                                child: BarChart(
                                  BarChartData(
                                    barTouchData: barTouchData,
                                    titlesData: titlesData,
                                    borderData: borderData,
                                    barGroups:
                                        barGroups(), // Chama a função para obter os grupos de barras
                                    gridData: const FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY:
                                        20, // Pode ser ajustado conforme necessário
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Hoje"),
                                        Text("R\$${valor?.toStringAsFixed(2)}"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Média"),
                                        Text("R\$${media?.toStringAsFixed(2)}"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Total"),
                                        Text("R\$${total?.toStringAsFixed(2)}"),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10,),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        
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
                            //crossAxisAlignment: CrossAxisAlignment.stretch,
                            
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_controle != 0) {
                                            _controle--;
                                            control -= 4;
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.arrow_back_ios_outlined)),
                                  Text(
                                    'Setembro - 2024',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_controle != 7 && op == 0) {
                                            _controle++;
                                            control += 4;
                                          } else if (_controle != 2 && op == 1) {
                                            _controle++;
                                          } 
                      
                                          print(_controle);
                                        });
                                      },
                                      icon:
                                          Icon(Icons.arrow_forward_ios_outlined)),
                                ],
                              ),
                              
                              
                              Expanded(
                                child: BarChart(
                                  BarChartData(
                                    barTouchData: barTouchData,
                                    titlesData: titlesData,
                                    borderData: borderData,
                                    barGroups:
                                        barGroups(), // Chama a função para obter os grupos de barras
                                    gridData: const FlGridData(show: false),
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY:
                                        20, // Pode ser ajustado conforme necessário
                                  ),
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Hoje"),
                                        Text("${litro?.toStringAsFixed(2)}L"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Média"),
                                        Text("${litroMedio?.toStringAsFixed(2)}L"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Total"),
                                        Text("${litroTotal?.toStringAsFixed(2)}L"),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  @override
  void dispose() {
    // Remove o listener ao sair da tela
    yearMonthRef.onValue.drain();
    super.dispose();
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
          const valores = ['01', '05', '09', '13', '17', '21', '25', '29'];
          text = valores[_controle];
        } else if (op == 1) {
          const valores = ['01', '05', '09'];
          text = valores[_controle];
        } else {
          text = '';
        }
        //text = 'Mn';
        break;
      case 1:
        if (op == 0) {
          const valores = ['02', '06', '10', '14', '18', '22', '26', '30'];
          text = valores[_controle];
        } else if (op == 1) {
          const valores = ['02', '06', '10'];
          text = valores[_controle];
        } else {
          text = '';
        }
        break;
      case 2:
        if (op == 0) {
          const valores = ['03', '07', '11', '15', '19', '23', '27', '31'];
          text = valores[_controle];
        } else if (op == 1) {
          const valores = ['03', '07', '11'];
          text = valores[_controle];
        } else {
          text = '';
        }
        break;
      case 3:
        if (op == 0) {
          const valores = ['04', '08', '12', '16', '20', '24', '28'];
          text = valores[_controle];
        } else if (op == 1) {
          const valores = ['04', '08', '12'];
          text = valores[_controle];
        } else {
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

  double convertValue(Object? value) {
    if (value is Map<Object?, Object?>) {
      // Se o valor é um mapa, tenta acessar a chave "dado"
      var innerValue = value['dado'];
      return convertValue(innerValue); // Chama a função recursivamente
    }

    if (value == null) {
      return 0; // Retorna 0 se o valor for null
    }

    // Verifica se o valor é um int
    if (value is int) {
      return value.toDouble();
    }

    // Verifica se o valor é um double
    if (value is double) {
      return value;
    }

    // Verifica se o valor é uma string
    if (value is String) {
      try {
        return double.parse(value); // Tenta converter a string para double
      } catch (e) {
        print(
            "Falha ao converter string para double: $value"); // Adiciona log de erro
        return 0; // Retorna 0 se a conversão falhar
      }
    }

    print(
        "Tipo de valor não reconhecido: ${value.runtimeType}"); // Log de tipo não reconhecido
    return 0; // Retorna 0 se o tipo não for reconhecido
  }

  List<BarChartGroupData> barGroups() {
    List<BarChartGroupData> groups = [];

    // Cria os grupos de barras com base nos dados obtidos do Firebase
    setState(() {
      for (int i = 0; i < 4; i++) {
        // Assumindo 30 dias no mês
        String day =
            (i + 1 + control).toString(); // Formato de dia com 0 à esquerda
        int cvs = int.parse(day) + 1;
        var value =
            data[cvs.toString()] ?? 0; // Pega o valor ou 0 se não existir

        // Verifica e imprime o valor e seu tipo antes da conversão
        print("Valor antes da conversão: $value (Tipo: ${value.runtimeType})");
        double convertedValue = convertValue(value); // Converte o valor
        print("Valor convertido: $convertedValue");
        if ((day != "32" && op == 0) || op == 1) {
          groups.add(
          BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: convertedValue, // Usa o valor convertido
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ),
        );
        } else {
          
        }
        
      }
    });

    return groups;
  }
}
