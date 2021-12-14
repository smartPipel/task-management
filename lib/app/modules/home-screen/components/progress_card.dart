import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:to_do_list/app/data/constans.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(subSpacing),
      width: width(context),
      margin: const EdgeInsets.only(bottom: spacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(width: .5, color: Colors.grey),
      ),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: CircularPercentIndicator(
              radius: 80.0,
              lineWidth: 10.0,
              animation: true,

              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.blueAccent,
              percent: .7,
              center: Text(
                "100%",
                style: defaultFontsStyle(
                    fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
              // progressColor: Colors.green,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    '14/18',
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
      ),
    );
  }
}
