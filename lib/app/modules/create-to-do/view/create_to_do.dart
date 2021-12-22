// ignore_for_file: avoid_print
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/constants/calendar_constants.dart';
import 'package:to_do_list/app/modules/create-to-do/components/text_field_conponents.dart';
import 'package:to_do_list/app/modules/create-to-do/providers/task_create_screen_provider.dart';
import 'package:to_do_list/app/utils/helpers/maxlinetype_enum.dart';
import 'package:to_do_list/app/widget/calendar/hour_list_widget.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  _CreateToDoState createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  DateTime dateNow = DateTime.now();
  DateTime? dateEstimate;
  int selectedIndex = 0;
  int selectedPeriodIndex = 0;
  int selectedColorIndex = 0;
  final _scrollContoller = ScrollController();
  final _listViewScrollControler = ScrollController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    setState(() {
      dateEstimate = DateTime.now();
      selectedIndex;
      selectedColorIndex;
      selectedPeriodIndex;
    });
    super.initState();
  }

  @override
  void dispose() {
    _listViewScrollControler.dispose();
    _scrollContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider =
        Provider.of<TaskCreateScreenProvider>(context, listen: false);
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
                      Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(borderRadius),
                                        border: Border.all(
                                            color: selectedColorIndex == index
                                                ? color[selectedColorIndex]
                                                : Colors.transparent)),
                                    child: HourListWidget(
                                      title: '',
                                      onTap: () {
                                        setState(() {
                                          selectedColorIndex = index;
                                        });
                                        print(selectedIndex);
                                      },
                                      titleColor: selectedColorIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                      selectedColor: color[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                            TextFieldComponents(
                              controller: _titleController,
                              label: 'Judul',
                              lineType: MaxLineType.input,
                            ),
                            TextFieldComponents(
                              controller: _descriptionController,
                              label: 'Deskripsi',
                              lineType: MaxLineType.text,
                            ),
                            Column(
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
                                  lastDate: DateTime(dateNow.year,
                                      dateNow.month + 1, dateNow.day),
                                  onDateSelected: (date) {
                                    if (date != null) {
                                      // date.toLocal();
                                      dateEstimate = date;
                                      print(dateEstimate!.day);
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: mainSpacing,
                      ),
                      Text(
                        'Pilih jam',
                        style: defaultFontsStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: mainSpacing,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: Colors.white,
                          // border: Border.all(color: Colors.black, width: .5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 20,
                              offset: const Offset(0, 0),
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(smallSpacing),
                        padding: const EdgeInsets.all(smallSpacing),
                        height: 80,
                        width: width(context),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _listViewScrollControler,
                          physics: const BouncingScrollPhysics(),
                          itemCount: jam.length,
                          itemBuilder: (context, index) {
                            return HourListWidget(
                              title: jam[index],
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                                print(selectedIndex);
                              },
                              titleColor: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                              selectedColor: selectedIndex == index
                                  ? Colors.pink
                                  : Colors.white,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: mainSpacing * 2.5,
                      ),
                      TextButton(
                        onPressed: () {
                          if (dateEstimate != null) {
                            TimeOfDay _hourEstimate = TimeOfDay(
                              hour: int.parse(jam[selectedIndex].split(":")[0]),
                              minute:
                                  int.parse(jam[selectedIndex].split(":")[1]),
                            );
                            final date = DateTime(
                                dateEstimate!.year,
                                dateEstimate!.month,
                                dateEstimate!.day,
                                _hourEstimate.hour);

                            print(dateEstimate!.day);
                            print(_hourEstimate);

                            _provider.createTask(
                                color[selectedColorIndex].value.toString(),
                                _titleController.text.trim(),
                                _descriptionController.text.trim(),
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
                          width: width(context),
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
                      ),
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
