import 'package:flutter/material.dart';
import 'package:hidro_tech/pages/connectPage.dart';
import 'package:hidro_tech/pages/graphsPage.dart';
import 'package:hidro_tech/pages/homePageBehind.dart';
import 'package:hidro_tech/pages/profilePage.dart';
import 'package:hidro_tech/widgets/hardwareStatus.dart';
import 'package:hidro_tech/widgets/averageGraph.dart';
import 'package:hidro_tech/widgets/currentFlow.dart';

class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _opcaoSelecionada = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xffF0F0F0),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => profilePage(),
                ),
              );
            
          },
          icon: Image.asset('assets/logo2.png'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _opcaoSelecionada,
        onTap: (index) {
          setState(() {
            _opcaoSelecionada = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.hardware_outlined),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assessment_outlined), label: 'Graphs'),
        ],
      ),
      body: IndexedStack(
        index: _opcaoSelecionada,
        children: [
          connectPage(),
          homePageBehind(),
          graphsPage(),
        ],
      ),
    );
  }
}
