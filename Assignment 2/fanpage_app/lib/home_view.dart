import 'package:fanpage_app/firebase.dart';
import 'package:fanpage_app/home.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ignore: non_constant_identifier_names
  CMethods method = CMethods();
  // late QuerySnapshot postsSnapshot;

  // ignore: non_constant_identifier_names
  // Widget PostsList() {
  //   return Column(
  //     children: <Widget>[
  //       ListView.builder(
  //           itemCount: postsSnapshot.docs.length,
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             return PostsTile(
  //                 message: postsSnapshot.docs[index].get('message'));
  //           }),
  //     ],
  //   );
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   method.getMessage().then((result) {
  //     postsSnapshot = result;
  //   });
  // }
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
        appBar: AppBar(title: const Text('Home View'), actions: [
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
                child: Text(messages.toString())),
          ],
        ));
  }
}

class PostsTile extends StatelessWidget {
  String message;
  PostsTile({required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        color: Colors.blue.shade200,
        child: Stack(
          children: <Widget>[
            Column(children: <Widget>[Text(message)])
          ],
        ));
  }
}
