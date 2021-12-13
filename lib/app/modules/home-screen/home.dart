import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import 'package:to_do_list/app/data/models/to_do.dart';
import 'package:to_do_list/app/providers/todo/to_do_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          height: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(left: 24, top: 24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://uselooper.com/docs/images/avatars/uifaces1.jpg'),
                      )),
                ),
              ),
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(top: 24, right: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.pink),
                child: IconButton(
                  onPressed: () {
                    var todo =
                        Provider.of<ToDoProvider>(context, listen: false);
                    todo.setTitle('alvin');
                    todo.setDescription('desc');
                    todo.setIsDone(false);
                    todo.setDoneEstimate(DateTime.now());

                    todo.saveToDo();
                  },
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                margin: const EdgeInsets.only(bottom: 24),
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'To Do',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 24),
                color: Colors.blue,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text('To Do Progress'),
                    ),
                    Container(
                      child: const Text('14/18'),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                // padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<List<ToDo>>(
                  stream: context.watch<ToDoProvider>().getData(),
                  builder: (context, snapshot) {
                    final _data = snapshot.data;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: _data?.length ?? 0,
                      itemBuilder: (context, i) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else {
                          if (_data!.isNotEmpty) {
                            return Container(
                              // height: 70,
                              child: Dismissible(
                                secondaryBackground: Container(
                                  color: Colors.blueAccent,
                                ),
                                key: ValueKey<ToDo>(_data[i]),
                                onUpdate: (details) {
                                  print('onupdate');
                                },
                                onResize: () {
                                  print('onresize');
                                },
                                background: Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.amber),
                                ),
                                // dismissThresholds: (),
                                onDismissed: (direction) {
                                  var todo = Provider.of<ToDoProvider>(context,
                                      listen: false);

                                  todo.isDoneSet(
                                      _data[i].id,
                                      direction == DismissDirection.startToEnd
                                          ? 'startToEnd'
                                          : 'endToStart');
                                  // print(_data[i].createdAt);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              direction.index.toString())));
                                },
                                child: TimelineTile(
                                  node: SizedBox(
                                    width: 60,
                                    height: 80.0,
                                    child: TimelineNode(
                                      indicator: Text(DateFormat.jm()
                                          .format(
                                              _data[i].doneEstimate.toDate())
                                          .toString()),
                                      startConnector: const SolidLineConnector(
                                        thickness: 1,
                                      ),
                                      endConnector: const SolidLineConnector(
                                        thickness: 1,
                                      ),
                                    ),
                                  ),
                                  // Text(_data[i]
                                  //     .doneEstimate
                                  //     .toDate()
                                  //     .day
                                  //     .toString()),
                                  nodeAlign: TimelineNodeAlign.start,
                                  contents: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: ListTile(
                                      title: Text(_data[i].title),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (_data.isEmpty) {
                            return const Text('no data');
                          }
                          return const CircularProgressIndicator();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
