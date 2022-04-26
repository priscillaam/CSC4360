import 'package:fanpage_app/firebase.dart';
import 'package:fanpage_app/home.dart';
import 'package:fanpage_app/maindrawer.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: non_constant_identifier_names
  CMethods method = CMethods();

  Future<void> _displayExitPopUp(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const Text('Log Out'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyHomePage(
                          title: '',
                        ),
                      ));
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MainDrawer(),
        appBar: AppBar(
            title: const Text('Ding Tea Duluth'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'logout',
                onPressed: () {
                  _displayExitPopUp(context);
                },
              )
            ]),

        // body: PostsList(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: const Text("welcome"),
            )
          ],
        ));
  }
}
