import 'package:flutter/material.dart';

Column weatherDetail ({required String detail, required Color colour, required String label}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        detail,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: colour,
        ),
      ),

      Text(
        label,
        style: TextStyle(
          color: colour,
        ),
      ),
    ],
  );
}