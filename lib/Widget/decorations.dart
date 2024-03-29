import 'package:flutter/material.dart';

const textinputdecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 1),
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2),
    borderRadius: BorderRadius.all(Radius.circular(50)),
  ),
);