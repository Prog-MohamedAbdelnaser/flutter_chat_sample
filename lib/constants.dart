import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      borderSide: BorderSide(
          color: Colors.lightBlueAccent, width: 1.0, style: BorderStyle.solid),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      borderSide: BorderSide(
          color: Colors.lightBlueAccent, width: 1.0, style: BorderStyle.solid),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32)),
      borderSide: BorderSide(
          color: Colors.lightBlueAccent, width: 2.0, style: BorderStyle.solid),
    ));

/*
* border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(
            color: Colors.lightBlueAccent,
            width: 1.0,
            style: BorderStyle.solid)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(32),
        borderSide: BorderSide(
            color: Colors.lightBlueAccent,
            width: 1.0,
            style: BorderStyle.solid)*/
