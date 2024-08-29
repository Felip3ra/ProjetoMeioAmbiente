import 'package:flutter/material.dart';

class hardwareStatus extends StatelessWidget {
  const hardwareStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Hardware Status"),
          Row(
            children: [
              Text('HARDWARE'),
              Text('ESP32'),
            ],
          ),
          Row(
            children: [
              Text('NETWORK'),
              Text('UNISANTA'),
            ],
          ),
          Row(
            children: [
              Text('STATUS'),
              Text('CONNECTED'),
            ],
          ),
          Row(
            children: [
              Text('OPERATION'),
              Text('WORKING'),
            ],
          ),
        ],
      ),
    );
  }
}
