import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/initialize-screen/providers/check_connection_provider.dart';

class ShowConnectionDialogWidget extends StatelessWidget {
  const ShowConnectionDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _provider =
        Provider.of<CheckConnectionProvider>(context, listen: false);
    return Center(
      child: Container(
        height: 200,
        width: 200,
        child: Text(
          _provider.getMessage,
          style: defaultFontsStyle(),
        ),
      ),
    );
  }
}
