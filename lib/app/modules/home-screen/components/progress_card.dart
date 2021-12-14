// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:to_do_list/app/data/constans.dart';
import 'package:to_do_list/app/data/models/to_do.dart';
import 'package:to_do_list/app/providers/todo/to_do_provider.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({Key? key, this.provider}) : super(key: key);
  final ToDoProvider? provider;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(superSubSpacing),
      width: width(context),
      // margin: const EdgeInsets.only(bottom: spacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(width: .5, color: Colors.grey),
      ),
      // color: Colors.blue,
      child: StreamBuilder<List<ToDo>>(
        stream: provider!.getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isNotEmpty) {
            final jumlahBagian = snapshot.data!
                .where((element) => (element.isDone == true))
                .length;
            final jumlahKeseluruhan = snapshot.data!.length;
            final presentase = (jumlahBagian / jumlahKeseluruhan) * 100 / 100;
            final presentaseHasil =
                presentase.toStringAsFixed(2).toString().split('');
            presentaseHasil.remove('.');
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 10.0,
                    animation: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.blueAccent,
                    percent: presentase,
                    center: Text(
                      "${int.parse(presentaseHasil.join())}%",
                      style: defaultFontsStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                    ),
                    // progressColor: Colors.green,
                  ),
                ),
                // const Expanded(
                //   flex: 1,
                //   child: SizedBox(),
                // ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Perkembangan tugas',
                                style: defaultFontsStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Expanded(
                                flex: 1, child: Icon(Icons.auto_graph_rounded)),
                          ],
                        ),
                      ),
                      SizedBox(
                        // margin: const EdgeInsets.all(superSubSpacing),
                        child: Text(
                          '${snapshot.data!.where((element) => (element.isDone == true)).length}/${snapshot.data!.length}',
                          style: defaultFontsStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Tidak ada tugas'),
            );
          }
        },
      ),
    );
  }
}
