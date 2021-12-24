import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';

class TaskTitleSections extends StatelessWidget {
  const TaskTitleSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String length = context.watch<HomeScreenProvider>().getToDoLength;
    return Container(
      margin: const EdgeInsets.all(mediumSpacing),
      width: width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          length == '0'
              ? Text(
                  'Tidak ada tugas.',
                  style: defaultFontsStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                )
              : Text(
                  'Kamu punya $length tugas hari ini.',
                  style: defaultFontsStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
          const SizedBox(
            width: 60,
          ),
          const Icon(Icons.date_range_rounded),
        ],
      ),
    );
  }
}
