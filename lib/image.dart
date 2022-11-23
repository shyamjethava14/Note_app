import 'package:flutter/material.dart';
import 'package:note_app/first.dart';
import 'package:sqflite/sqflite.dart';

class imagechang extends StatefulWidget {

  Database database;
  imagechang(this.database);


  @override
  State<imagechang> createState() => _imagechangState();
}

class _imagechangState extends State<imagechang> {
  List<String> ima= [
    "1.jpg","2.jpg","3.jpg","4.jpg","5.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("image"),
      ),
      body: GridView.builder(itemCount: ima.length,
          itemBuilder:(context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return first(widget.database);
                },));
              },
              child: Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("img/${ima[index]}"))
                ),
              ),
            );
          },gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)),
    );
  }
}

