import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:note_app/image.dart';
import 'package:note_app/second.dart';
import 'package:note_app/third.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class first extends StatefulWidget {
  Database? database;

  first(this.database);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  List title = [];
  List content = [];
  List id = [];
  DateTime now = DateTime.now();
  String time = "";
  String image = "1.png";

  @override
  void initState() {
    super.initState();
    time = "${now.day.toString()}"
        "/"
        "${now.month.toString()}"
        "/"
        "${now.year.toString()}";
    print(time);
  }

  get_data() async {
    String qry = "select * from note";
    List<Map> list = [];
    list = await widget.database!.rawQuery(qry);
    print("list = $list");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SUPER NOTE",
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          SizedBox(
            width: 10,
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.cloud_upload)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return first(widget.database);
                  },));
                },
                child: Text("Color"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("bagecolor"),
                value: 2,
              )
            ],
          )
        ],
      ),
      body: FutureBuilder(
          future: get_data(),
          builder: (context, snapshot) {
            title.clear();
            content.clear();
            id.clear();
            if (snapshot.connectionState == ConnectionState.done) {
              List<Map>? test = [];
              if (snapshot.hasData) {
                test = snapshot.data as List<Map>?;
                test!.forEach((element) {
                  id.add(element['id']);
                  title.add(element['title']);
                  content.add(element['content']);
                });
              }
              return ListView.builder(
                itemCount: content.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 10,
                    color: Colors.green,
                    child: InkWell(
                      onTap: () {
                        print(id[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return third(id[index], title[index],content[index], widget.database);
                          },
                        ));
                      },
                      child: ListTile(
                        leading: Image.asset("img/${image}"),
                        title: Text("${title[index]}"),
                        subtitle: Text(
                          "${content[index]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Text("$time"),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: SpeedDial(
        children: [
          SpeedDialChild(
            onTap: () {},
            backgroundColor: Colors.lightBlue,
            child: Icon(Icons.note_add_outlined),
            label: "Note",
            labelBackgroundColor: Colors.black,
            labelStyle: TextStyle(color: Colors.white),
          ),
          SpeedDialChild(
            onTap: () {
              print(widget.database);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return second(widget.database);
                },
              ));
            },
            backgroundColor: Colors.lightBlue,
            child: Icon(Icons.table_chart_outlined),
            label: "Notes",
            labelBackgroundColor: Colors.black,
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        child: Icon(Icons.add),
      ),
    );
  }
}
