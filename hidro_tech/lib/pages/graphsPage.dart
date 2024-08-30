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
      appBar: AppBar(
        shape: Border(bottom: BorderSide(width: 1, color: Color(0xffF0F0F0),),),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/logo2.png'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        currentIndex: 2,
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
              Selectbuttom(),
              graphs(),
            ],
          ),
        ),
      ),
    );
  }
}
