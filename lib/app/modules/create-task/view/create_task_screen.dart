// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/constants/create_task_constants.dart';
import 'package:to_do_list/app/modules/create-task/components/choose_color_component.dart';
import 'package:to_do_list/app/modules/create-task/components/choose_date_component.dart';
import 'package:to_do_list/app/modules/create-task/components/submit_task_button_component.dart';
import 'package:to_do_list/app/modules/create-task/components/time_picker_component.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/widget/text_field_widget.dart';
import 'package:to_do_list/app/utils/helpers/maxlinetype_enum.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  DateTime dateNow = DateTime.now();

  final _scrollContoller = ScrollController();
  final _listViewScrollControler = ScrollController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timePickerController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _listViewScrollControler.dispose();
    _scrollContoller.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _timePickerController.dispose();

    super.dispose();
  }

  hour(int hour) => DateTime(hour);

  @override
  Widget build(BuildContext context) {
    final _provider =
        Provider.of<CreateTaskScreenProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: mainSpacing),
          width: width(context),
          height: height(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: mainSpacing, bottom: mainSpacing),
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
                        style: defaultFontsStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  controller: _scrollContoller,
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        // color: Colors.white,
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: mediumSpacing,
                            ),
                            Text(
                              'Pilih warnamu',
                              style: defaultFontsStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: mainSpacing),
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _listViewScrollControler,
                                physics: const BouncingScrollPhysics(),
                                itemCount: color.length,
                                itemBuilder: (context, index) {
                                  print(_provider.getColorIndex);
                                  return ChooseColorComponent(
                                    index: index,
                                  );
                                },
                              ),
                            ),
                            TextFieldWidget(
                              controller: _titleController,
                              label: 'Judul',
                              lineType: MaxLineType.input,
                            ),
                            TextFieldWidget(
                              controller: _descriptionController,
                              label: 'Deskripsi',
                              lineType: MaxLineType.text,
                            ),
                            ChooseDateComponent(
                              dateNow: dateNow,
                              provider: _provider,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: mainSpacing,
                      ),
                      TimePickerComponent(
                          provider: _provider,
                          timePickerController: _timePickerController),
                      const SizedBox(
                        height: mainSpacing * 1.5,
                      ),
                      SubmitTaskButtonComponent(
                          dateNow: dateNow,
                          descriptionController: _descriptionController,
                          titleController: _titleController,
                          provider: _provider,
                          formKey: _formKey,
                          selectedColorIndex: _provider.getColorIndex),
                      const SizedBox(
                        height: mainSpacing,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
