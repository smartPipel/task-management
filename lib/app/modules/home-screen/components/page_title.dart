import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context),
      child: FittedBox(
        alignment: Alignment.topLeft,
        child: Text(
          'Pengelola Tugas',
          style: defaultFontsStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
