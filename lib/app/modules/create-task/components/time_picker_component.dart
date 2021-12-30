// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/utils/helpers/maxlinetype_enum.dart';
import 'package:to_do_list/app/widget/text_field_widget.dart';

class TimePickerComponent extends StatelessWidget {
  const TimePickerComponent(
      {Key? key, required this.provider, required this.timePickerController})
      : super(key: key);

  final CreateTaskScreenProvider provider;
  final TextEditingController timePickerController;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      readOnly: true,
      controller: timePickerController,
      lineType: MaxLineType.input,
      label: 'Pilih estimasi waktu',
      onTap: () {
        DatePicker.showTime12hPicker(
          context,
          onConfirm: (time) {
            timePickerController.text = DateFormat.jm().format(time).toString();
            provider.setHour(DateFormat.Hm().format(time));
            print(provider.getHour);
          },
          locale: LocaleType.id,
          // currentTime: dateNow,
          theme: DatePickerTheme(
              itemStyle: defaultFontsStyle(),
              itemHeight: 60,
              doneStyle: defaultFontsStyle(color: Colors.blueAccent),
              cancelStyle: defaultFontsStyle(color: Colors.red)),
        );
      },
    );
  }
}
