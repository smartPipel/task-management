import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/data/constans.dart';
import 'package:to_do_list/app/providers/todo/to_do_provider.dart';

class AppBarComponents extends StatelessWidget {
  const AppBarComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height(context),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(left: spacing, top: spacing),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
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
            margin: const EdgeInsets.only(top: spacing, right: spacing),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.pink,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.pinkAccent.shade200,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            child: IconButton(
              onPressed: () {
                var todo = Provider.of<ToDoProvider>(context, listen: false);
                todo.setTitle('alvin');
                todo.setDescription('desc');
                todo.setIsDone(false);
                todo.setDoneEstimate(DateTime.now());

                todo.saveToDo();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
