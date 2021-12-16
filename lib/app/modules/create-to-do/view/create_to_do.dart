// ignore_for_file: avoid_print
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/constants/calendar_constants.dart';
import 'package:to_do_list/app/widget/calendar/hour_list_widget.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  _CreateToDoState createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  DateTime dateNow = DateTime.now();
  int selectedIndex = 0;
  final _scrollContoller = ScrollController();
  final _listViewScrollControler = ScrollController();

  @override
  void dispose() {
    _listViewScrollControler.dispose();
    _scrollContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                          children: [
                            makeInput(
                                label: 'Judul', lineType: MaxLineType.input),
                            makeInput(
                                label: 'Deskripsi', lineType: MaxLineType.text),
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
                                      date.toLocal();
                                      date = DateTime(date.year, date.month,
                                          date.day, dateNow.hour);
                                      print(date.hour);
                                    }
                                  },
                                  leftMargin: smallSpacing,
                                  monthColor: Colors.pinkAccent,
                                  dayColor: Colors.blueAccent,
                                  activeDayColor: Colors.white,
                                  activeBackgroundDayColor: Colors.pink,
                                  dotsColor: Colors.white,
                                  // selectableDayPredicate: (date) => date.day != 23,
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
                              title: jam.map((e) => e).toList()[index],
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
                        height: mainSpacing * 4,
                      ),
                      TextButton(
                        onPressed: () {},
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

  Widget makeInput({label, obsureText = false, MaxLineType? lineType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: defaultFontsStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        const SizedBox(
          height: mainSpacing,
        ),
        TextField(
          maxLines: lineType == MaxLineType.text ? 3 : 1,
          obscureText: obsureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: Colors.grey[400]!)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.blueAccent)),
          ),
        ),
        const SizedBox(
          height: mainSpacing,
        )
      ],
    );
  }
}

enum MaxLineType {
  text,
  input,
}
