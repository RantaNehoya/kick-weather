import 'package:flutter/material.dart';

Card weatherForecast ({required String day, required String temp, required String humidity, required String pressure, required Color colour}){
  return Card(
    color: colour.withOpacity(0.05),
    elevation: 1.5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text(
              day,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text(
              temp,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
          ),

          Text(
            humidity,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13.0,
            ),
          ),

          Text(
            pressure,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 13.0,
            ),
          ),
        ],
      ),
    ),
  );
}