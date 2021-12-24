import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';

class AppBarComponents extends StatelessWidget {
  const AppBarComponents({Key? key, required this.onPressed}) : super(key: key);
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Consumer<HomeScreenProvider>(builder: (context, _provider, _) {
      return Container(
        height: height(context),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PopupMenuButton(
              offset: const Offset(40, 80),
              enableFeedback: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Container(
                width: 50,
                height: 50,
                margin:
                    const EdgeInsets.only(left: mainSpacing, top: mainSpacing),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(user!.photoURL.toString()),
                  ),
                ),
              ),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.blueAccent,
                    ),
                    title: Text('seting'),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: Text(
                      'keluar',
                      style: defaultFontsStyle(),
                    ),
                    onTap: () {
                      _provider.logout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.loginRoute, (route) => false);
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: 50,
              height: 50,
              margin:
                  const EdgeInsets.only(top: mainSpacing, right: mainSpacing),
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
                onPressed: () => onPressed.call(),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
