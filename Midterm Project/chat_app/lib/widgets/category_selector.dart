import 'package:flutter/material.dart';

import '../profile.dart';
import '../search.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Messages', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90.0,
        color: Colors.blue,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30,
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color:
                        index == selectedIndex ? Colors.white : Colors.white60,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
