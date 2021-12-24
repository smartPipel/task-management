import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/constants/create_task_constants.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/utils/helpers/string_format.dart';

class SubmitTaskButtonComponent extends StatelessWidget {
  const SubmitTaskButtonComponent({
    Key? key,
    required this.dateNow,
    required this.descriptionController,
    required this.titleController,
    required this.provider,
    required this.formKey,
    required this.selectedColorIndex,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final CreateTaskScreenProvider provider;
  final GlobalKey<FormState> formKey;
  final int selectedColorIndex;
  final DateTime dateNow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (provider.getYear.toString().isNotEmpty &&
            provider.getHour.isNotEmpty &&
            formKey.currentState!.validate()) {
          final date = DateTime.parse(provider.getYear.toString() +
              provider.getMonth.toString() +
              provider.getDay.toString() +
              ' ' +
              provider.getHour);

          print(date);

          provider.createTask(
              context,
              color[selectedColorIndex].value.toString(),
              titleController.text.trim().capitalize,
              descriptionController.text.trim().capitalize,
              Timestamp.fromDate(dateNow),
              Timestamp.fromDate(date));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(bigSpacing),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        // width: width(context),
        child: Center(
          child: Text(
            'Buat',
            style: defaultFontsStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
