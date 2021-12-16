// ignore_for_file: avoid_print
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constans.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  _CreateToDoState createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: width(context),
          height: height(context),
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(mainSpacing),
                  // color: Colors.red,
                  width: width(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(width: 0.5),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.chevron_left),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          'Buat tugas',
                          style: defaultFontsStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView(
                      children: [
                        makeInput(label: 'Judul'),
                        makeInput(label: 'Deskripsi'),
                        CalendarTimeline(
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2019, 1, 15),
                          lastDate: DateTime(2022, 11, 20),
                          onDateSelected: (date) => print(date),
                          leftMargin: 20,
                          monthColor: Colors.blueGrey,
                          dayColor: Colors.teal[200],
                          activeDayColor: Colors.white,
                          activeBackgroundDayColor: Colors.redAccent[100],
                          dotsColor: Colors.pinkAccent,
                          selectableDayPredicate: (date) => date.day != 23,
                          locale: 'id_ID',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obsureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obsureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
