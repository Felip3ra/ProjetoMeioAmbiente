import 'package:flutter/material.dart';
import 'package:hidro_tech/widgets/hardwareStatus.dart';
import 'package:hidro_tech/widgets/averageGraph.dart';
import 'package:hidro_tech/widgets/currentFlow.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
        
        currentIndex: 1,
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
              hardwareStatus(),
              averageGraph(),
              Currentflow(),
            ],
          ),
        ),
      ),
    );
  }
}
