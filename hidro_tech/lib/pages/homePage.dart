import 'package:flutter/material.dart';
import 'package:hidro_tech/widgets/hardwareStatus.dart';
import 'package:hidro_tech/widgets/averageGraph.dart';
class homePage extends StatefulWidget {
  homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
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
              AspectRatio(aspectRatio: 1.6, child: averageGraph(),)
            ],
          ),
        ),
      ),
    );
  }
}
