import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/constants/app_constans.dart';
import 'package:to_do_list/app/modules/home-screen/components/app_bar_components.dart';
import 'package:to_do_list/app/modules/home-screen/components/page_title.dart';
import 'package:to_do_list/app/modules/home-screen/components/progress_card.dart';
import 'package:to_do_list/app/modules/home-screen/components/to_do_list_components.dart';
import 'package:to_do_list/app/modules/home-screen/components/to_do_list_title_sections.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    providerDispose();
    super.dispose();
  }

  providerDispose() {
    // Your Code
    Provider.of<HomeScreenProvider>(context, listen: false).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<HomeScreenProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBarComponents(
            onPressed: () => Navigator.pushNamed(context, Routes.createRoute),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Expanded(flex: 2, child: PageTitle()),
              Expanded(flex: 3, child: ProgressCard(provider: _provider)),
              const Expanded(flex: 2, child: ToDoListTitleSections()),
              Expanded(
                flex: 15,
                child: StreamBuilder<List<ToDo>>(
                  stream: _provider.getData(),
                  builder: (context, snapshot) {
                    final _data = snapshot.data;

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator()));
                    } else {
                      if (_data!.isNotEmpty) {
                        WidgetsBinding.instance!
                            .addPostFrameCallback((timeStamp) {
                          _provider.setToDoLength(_data.length.toString());
                        });
                        return ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _data.length,
                          itemBuilder: (context, i) {
                            return ToDoListComponents(
                                data: _data, i: i, todo: _provider);
                          },
                        );
                      } else {
                        return SizedBox(
                            width: width(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: SizedBox(
                                    height: 200,
                                    width: 200,
                                    child: Image.asset(illustrationAssets +
                                        'tidak-ada-tugas.png'),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'Tidak ada tugas',
                                    style: defaultFontsStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ));
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
