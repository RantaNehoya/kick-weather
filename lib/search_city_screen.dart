import 'package:flutter/material.dart';

class SearchCity extends StatelessWidget {
  const SearchCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: mediaQuery.width * 0.07,
          vertical: mediaQuery.height * 0.06,
        ),

        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.location_city_outlined,
                ),
                hintText: 'City Name',
              ),
            )
          ],
        ),
      ),
    );
  }
}
