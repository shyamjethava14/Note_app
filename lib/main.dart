import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/first.dart';
import 'package:sqflite_common/sqlite_api.dart';

void main(){
  Database? database;
  runApp(MaterialApp(home: first(database),));
}