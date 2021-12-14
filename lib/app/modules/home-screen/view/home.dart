import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/data/models/to_do.dart';
import 'package:to_do_list/app/modules/home-screen/components/app_bar_components.dart';
import 'package:to_do_list/app/modules/home-screen/components/page_title.dart';
import 'package:to_do_list/app/modules/home-screen/components/progress_card.dart';
import 'package:to_do_list/app/modules/home-screen/components/to_do_list_components.dart';
import 'package:to_do_list/app/modules/home-screen/components/to_do_list_title_sections.dart';
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
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: AppBarComponents(),
      ),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Expanded(flex: 1, child: PageTitle()),
            const Expanded(flex: 2, child: ProgressCard()),
            const Expanded(flex: 1, child: ToDoListTitleSections()),
            Expanded(
              flex: 6,
              child: StreamBuilder<List<ToDo>>(
                stream: context.watch<ToDoProvider>().getData(),
                builder: (context, snapshot) {
                  final _data = snapshot.data;
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _data?.length ?? 0,
                    itemBuilder: (context, i) {
                      var todo =
                          Provider.of<ToDoProvider>(context, listen: false);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        if (_data!.isNotEmpty) {
                          return ToDoListComponents(
                              data: _data, i: i, todo: todo);
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
          ],
        ),
      ),
    );
  }
}
