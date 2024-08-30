import 'package:flutter/material.dart';
import 'package:hidro_tech/pages/connectPage.dart';
import 'package:hidro_tech/pages/graphsPage.dart';
import 'package:hidro_tech/widgets/hardwareStatus.dart';
import 'package:hidro_tech/widgets/averageGraph.dart';
import 'package:hidro_tech/widgets/currentFlow.dart';

class homePageBehind extends StatefulWidget {
  homePageBehind({super.key});

  @override
  State<homePageBehind> createState() => _homePageBehindState();
}

class _homePageBehindState extends State<homePageBehind> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
