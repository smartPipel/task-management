import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constans.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: bigSpacing),
      margin: const EdgeInsets.only(bottom: mainSpacing),
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'Pengelola Tugas',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
