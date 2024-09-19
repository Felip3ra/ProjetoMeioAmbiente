import 'package:flutter/material.dart';
import 'package:hidro_tech/models/option.dart';
import 'package:hidro_tech/widgets/graphs.dart';
import 'package:hidro_tech/widgets/hardwareStatus.dart';
import 'package:hidro_tech/widgets/averageGraph.dart';
import 'package:hidro_tech/widgets/currentFlow.dart';
import 'package:hidro_tech/widgets/selectButtom.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';




class graphsPage extends StatefulWidget {
  graphsPage({super.key});

  @override
  State<graphsPage> createState() => _graphsPageState();
}

class _graphsPageState extends State<graphsPage> {

  Option _optionSelect = Option(optionSelect: 0,text_: 'Fluxo de água por hora');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _optionSelect = Option(optionSelect: 0, text_: 'Fluxo de água por hora');
                          });
                        },
                        child: Text('Hour'),
                      ),
                    ),
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
                            _optionSelect = Option(optionSelect: 1, text_: 'Fluxo de água por dia');
                          });
                          },
                          child: Text('Day'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _optionSelect = Option(optionSelect: 2, text_: 'Fluxo de água por mes');
                          });
                        },
                        child: Text('Month'),
                      ),
                    ),
                  ],
                ),
              ),
              graphs(option: _optionSelect),
            ],
          ),
        ),
      ),
    );
  }
}


