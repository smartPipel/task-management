import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timelines/timelines.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';
import 'package:to_do_list/app/utils/helpers/date_time_helper.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class ToDoListComponents extends StatelessWidget {
  const ToDoListComponents(
      {Key? key, required this.data, required this.i, required this.todo})
      : super(key: key);
  final HomeScreenProvider? todo;
  final List<ToDo> data;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: smallSpacing, bottom: smallSpacing),
      child: Slidable(
        key: ValueKey<ToDo>(data[i]),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            data[i].isDone == false
                ? SlidableAction(
                    foregroundColor: Colors.green,
                    onPressed: (context) {
                      todo?.isDoneSet(data[i].id, true);
                    },
                    backgroundColor: Colors.transparent,
                    label: 'Selesai',
                    icon: Icons.done,
                  )
                : SlidableAction(
                    foregroundColor: Colors.redAccent,
                    onPressed: (context) {
                      todo?.isDoneSet(data[i].id, false);
                    },
                    backgroundColor: Colors.transparent,
                    label: 'Ulangi',
                    icon: Icons.settings_backup_restore_rounded,
                  )
          ],
        ),
        child: TimelineTile(
          node: SizedBox(
            width: MediaQuery.of(context).size.width * .1,
            height: 80.0,
            child: TimelineNode(
              indicator: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  dateHourFormat(toDateTime(data[i].doneEstimate)),
                  style: const TextStyle(
                      fontSize: 10,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              startConnector: const SolidLineConnector(
                thickness: .5,
                indent: 3,
              ),
              endConnector: const SolidLineConnector(
                thickness: .5,
                indent: 3,
              ),
            ),
          ),
          nodeAlign: TimelineNodeAlign.start,
          contents: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Color(int.parse(data[i].color)),
                borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(
                data[i].title,
                style: defaultFontsStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color:
                      data[i].color == Colors.yellow.shade700.value.toString()
                          ? Colors.black
                          : Colors.white,
                ),
              ),
              subtitle: Text(
                data[i].description,
                style: defaultFontsStyle(
                  fontSize: 14,
                  color:
                      data[i].color == Colors.yellow.shade700.value.toString()
                          ? Colors.black54
                          : Colors.white54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
