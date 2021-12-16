import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';

class ToDoListTitleSections extends StatelessWidget {
  const ToDoListTitleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String length = context.watch<HomeScreenProvider>().getToDoLength;
    return Container(
      margin: const EdgeInsets.all(mainSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          length == '0'
              ? const Text('Loading...')
              : Text(
                  'Kamu punya $length tugas hari ini',
                  style: defaultFontsStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
          const Icon(Icons.date_range_rounded),
        ],
      ),
    );
  }
}
