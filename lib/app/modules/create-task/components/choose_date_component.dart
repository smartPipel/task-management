import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';

class ChooseDateComponent extends StatelessWidget {
  ChooseDateComponent({Key? key, required this.dateNow, required this.provider})
      : super(key: key);
  final DateTime dateNow;

  CreateTaskScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih tanggal',
          style: defaultFontsStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: mainSpacing,
        ),
        CalendarTimeline(
          initialDate: dateNow,
          firstDate: dateNow,
          lastDate: DateTime(dateNow.year, dateNow.month + 1, dateNow.day),
          onDateSelected: (date) {
            if (date != null) {
              // date.toLocal();
              provider.setDay(date.day);
              provider.setMonth(date.month);
              provider.setYear(date.year);
              print(provider.getDay);
            }
          },
          leftMargin: smallSpacing,
          monthColor: Colors.pinkAccent,
          dayColor: Colors.blueAccent,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: Colors.pink,
          dotsColor: Colors.white,
          locale: 'id',
        ),
      ],
    );
  }
}
