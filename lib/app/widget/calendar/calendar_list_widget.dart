import 'package:flutter/material.dart';

class CalendarListWidget extends StatefulWidget {
  const CalendarListWidget({Key? key}) : super(key: key);

  @override
  _CalendarListWidgetState createState() => _CalendarListWidgetState();
}

class _CalendarListWidgetState extends State<CalendarListWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            tileColor:
                selectedIndex == index ? Colors.pinkAccent : Colors.black,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}
