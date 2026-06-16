import 'package:flutter/material.dart';

class AppTable extends StatelessWidget {
  const AppTable({Key? key, this.head = const []}) : super(key: key);
  final List<String> head;

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(
            children: head
                .map((e) => Container(
                      decoration: BoxDecoration(),
                      child: Text(e),
                    ))
                .toList()),
      ],
    );
  }
}
