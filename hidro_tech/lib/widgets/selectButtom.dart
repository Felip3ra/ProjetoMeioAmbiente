import 'package:flutter/material.dart';

class Selectbuttom extends StatefulWidget {
  const Selectbuttom({super.key});

  @override
  State<Selectbuttom> createState() => _SelectbuttomState();
}

class _SelectbuttomState extends State<Selectbuttom> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              onPressed: () {},
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
                onPressed: () {},
                child: Text('Day'),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () {},
              child: Text('Month'),
            ),
          ),
        ],
      ),
    );
  }
}
