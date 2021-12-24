import 'package:flutter/material.dart';
import 'package:to_do_list/app/constants/app_constants.dart';

class HourListWidget extends StatelessWidget {
  const HourListWidget(
      {Key? key,
      required this.title,
      required this.onTap,
      required this.titleColor,
      required this.selectedColor})
      : super(key: key);
  final VoidCallback onTap;
  final Color titleColor;
  final Color selectedColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.all(smallSpacing),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius - 5),
        color: selectedColor,
        border: Border.all(width: .2),
      ),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        selected: true,
        title: Align(
          alignment: Alignment.center,
          heightFactor: 2,
          child: Text(
            title,
            style: defaultFontsStyle(color: titleColor, fontSize: 16),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
