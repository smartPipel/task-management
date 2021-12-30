// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/constants/create_task_constants.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/widget/hour_list_widget.dart';

class ChooseColorComponent extends StatefulWidget {
  const ChooseColorComponent({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<ChooseColorComponent> createState() => _ChooseColorComponentState();
}

class _ChooseColorComponentState extends State<ChooseColorComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateTaskScreenProvider>(
      builder: (context, provider, _) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
                color: provider.getColorIndex == widget.index
                    ? color[provider.getColorIndex]
                    : Colors.transparent),
          ),
          child: HourListWidget(
            title: '',
            onTap: () {
              provider.setColorIndex(widget.index);
              print(provider.getColorIndex);
            },
            titleColor: provider.getColorIndex == widget.index
                ? Colors.white
                : Colors.black,
            selectedColor: color[widget.index],
          ),
        );
      },
    );
  }
}
