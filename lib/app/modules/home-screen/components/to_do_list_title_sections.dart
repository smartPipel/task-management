import 'package:flutter/material.dart';
import 'package:to_do_list/app/data/constans.dart';

class ToDoListTitleSections extends StatelessWidget {
  const ToDoListTitleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(spacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Kamu mempunyai 6 tugas',
            style: defaultFontsStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Icon(Icons.date_range_rounded),
        ],
      ),
    );
  }
}
