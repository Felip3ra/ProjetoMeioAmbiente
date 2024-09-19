import 'package:flutter/material.dart';
import 'package:hidro_tech/widgets/graphs.dart';
import 'package:hidro_tech/widgets/hardwareStatus.dart';
import 'package:hidro_tech/widgets/averageGraph.dart';
import 'package:hidro_tech/widgets/currentFlow.dart';
import 'package:hidro_tech/widgets/selectButtom.dart';

class graphsPage extends StatefulWidget {
  graphsPage({super.key});

  @override
  State<graphsPage> createState() => _graphsPageState();
}

class _graphsPageState extends State<graphsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Selectbuttom(),
              graphs(),
            ],
          ),
        ),
      ),
    );
  }
}
