import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {

  const Pagination({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 20,
        width: 100,
        child: Row(
          children: [
            Column(
              children: [Text("Previous")],
            ),
            Column(
              children: [Text("Current")],
            ),
            Column(
              children: [Text("Next")],
            ),
          ],
        ),
      );
  }
}
