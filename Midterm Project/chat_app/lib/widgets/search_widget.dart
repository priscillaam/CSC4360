import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';

import '../search.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Search Bar',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    )),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                  ),
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchUser(),
                        ));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
