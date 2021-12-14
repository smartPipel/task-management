import 'package:flutter/material.dart';
import 'package:to_do_list/app/data/constans.dart';

class CreateToDo extends StatefulWidget {
  const CreateToDo({Key? key}) : super(key: key);

  @override
  _CreateToDoState createState() => _CreateToDoState();
}

class _CreateToDoState extends State<CreateToDo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: width(context),
          height: height(context),
          // color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(spacing),
                  // color: Colors.red,
                  width: width(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(width: 0.5),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.chevron_left),
                        ),
                      ),
                      Container(
                        child: Text(
                          'Buat tugas',
                          style: defaultFontsStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ListView(
                      children: [
                        makeInput(label: 'Judul'),
                        makeInput(label: 'Deskripsi'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, obsureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obsureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!)),
          ),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
