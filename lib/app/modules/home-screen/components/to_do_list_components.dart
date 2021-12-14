import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';
import 'package:to_do_list/app/data/models/to_do.dart';
import 'package:to_do_list/app/providers/todo/to_do_provider.dart';

class ToDoListComponents extends StatelessWidget {
  ToDoListComponents(
      {Key? key, required this.data, required this.i, required this.todo})
      : super(key: key);
  ToDoProvider? todo;
  List<ToDo> data;
  int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Slidable(
        // secondaryBackground: Container(
        //   color: Colors.blueAccent,
        // ),
        key: ValueKey<ToDo>(data[i]),
        // onUpdate: (details) {
        //   print('onupdate');
        // },
        // onResize: () {
        //   print('onresize');
        // },
        // background: Container(
        //   decoration:
        //       const BoxDecoration(color: Colors.amber),
        // ),
        // dismissThresholds: (),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              foregroundColor: Colors.green,
              onPressed: (context) {
                todo?.isDoneSet(data[i].id, 'endToStart');
              },
              backgroundColor: Colors.transparent,
              label: 'Selesai',
              icon: Icons.done,
            ),
            SlidableAction(
              foregroundColor: Colors.redAccent,
              onPressed: (context) {
                todo?.isDoneSet(data[i].id, 'startToEnd');
              },
              backgroundColor: Colors.transparent,
              label: 'Hapus',
              icon: Icons.delete_outlined,
            )
          ],
          dismissible: DismissiblePane(
            onDismissed: () {
              // print(data[i].createdAt);

              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('dismiss')));
            },
          ),
        ),
        child: TimelineTile(
          node: SizedBox(
            width: MediaQuery.of(context).size.width * .1,
            height: 80.0,
            child: TimelineNode(
              indicator: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  DateFormat.jm()
                      .format(data[i].doneEstimate.toDate())
                      .toString(),
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
                color: Colors.yellow, borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              title: Text(data[i].title),
            ),
          ),
        ),
      ),
    );
  }
}
