import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:flutter/material.dart';
import 'package:note_app/first.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

class second extends StatefulWidget {
  Database? database;

  second(this.database);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  List<Color> col = [
    Color(0xffda2621),
    Color(0xff5ed91a),
    Color(0xff1a79d9),
    Color(0xffcc1ad9),
    Color(0xffea5e6f),
    Color(0xffead35e),
    Color(0xff19ad86),
    Color(0xff2199da),
    Color(0xffda6821),
    Color(0xffda21c1),
    Color(0xff21da6b),
    Color(0xff9621da),
    Color(0xe5216bda),
    Color(0xffa6da21),
  ];
  List<Color> co = [
    Color(0x99da2621),
    Color(0x995ed91a),
    Color(0x991a79d9),
    Color(0x99cc1ad9),
    Color(0x99ea5e6f),
    Color(0x99ead35e),
    Color(0x9919ad86),
    Color(0x992199da),
    Color(0x99da6821),
    Color(0x99da21c1),
    Color(0x9921da6b),
    Color(0x999621da),
    Color(0x99216bda),
    Color(0x99a6da21),
  ];

  int i = 0;
  int back = 0;
  int textcol = 0;
  bool bo = false;
  bool io = false;
  bool uo = false;
  bool textbool = false;
  bool bagcolor = false;

  Database? database;
  int t = 15;

  @override
  void initState() {
    super.initState();
    print(widget.database);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: col[i],
        title: TextField(
          controller: t1,
          decoration: InputDecoration(
            hintText: "Edit title",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                String str1, str2, qry;
                str1 = t1.text;
                str2 = t2.text;
                qry =
                    "insert into note(title, content) values('$str1','$str2')";
                int r_id;
                r_id = await widget.database!.rawInsert(qry);
                print("qry = $qry");
                print("id = $r_id");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return first(widget.database);
                  },
                ));
              },
              icon: Icon(Icons.save)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  child: Row(
                children: [
                  Container(
                      color: Colors.white,
                      child: Icon(
                        Icons.push_pin,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Pin"),
                ],
              )),
              PopupMenuItem(
                onTap: () {
                  String str1, str2;
                  str1 = t1.text;
                  str2 = t2.text;
                  Share.share("${str1}\n ${str2}");
                },
                  child: Row(
                children: [
                  Container(
                      color: Colors.white,
                      child: Icon(Icons.share,color: Colors.black,),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("share"),
                ],
              )),
              PopupMenuItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Container(
                          color: Colors.white,
                          child: Icon(
                            Icons.delete,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Delete"),
                    ],
                  ))
            ],
          )
        ],
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          color: co[i],
          child: TextField(
            maxLines: 500,
            controller: t2,
            decoration: InputDecoration(hintText: "No content"),
            style: TextStyle(
              fontSize: t.toDouble(),
              color: textbool ? col[textcol] : Colors.black,
              backgroundColor: bagcolor ? col[back] : Colors.transparent,
              fontWeight: bo ? FontWeight.bold : FontWeight.normal,
              fontStyle: io ? FontStyle.italic : FontStyle.normal,
              decoration: uo ? TextDecoration.underline : TextDecoration.none,
            ),
          )),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () => boot(context),
                icon: Icon(Icons.color_lens_outlined)),
            IconButton(
                onPressed: () {
                  bo = !bo;
                  print(bo);
                  setState(() {});
                },
                icon: Icon(Icons.format_bold)),
            IconButton(
                onPressed: () {
                  io = !io;
                  setState(() {});
                },
                icon: Icon(Icons.format_italic)),
            IconButton(
                onPressed: () {
                  uo = !uo;
                  setState(() {});
                },
                icon: Icon(Icons.format_underline)),
            IconButton(
                onPressed: () => backgroun(context),
                icon: Icon(Icons.format_color_text)),
            InkWell(
              onTap: () {
                textcolor(context);
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: GradientBoxBorder(
                      gradient: LinearGradient(colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.cyan,
                    Colors.blue,
                    Colors.purple
                  ])),
                  color: Colors.black,
                ),
              ),
            ),
            DropdownButton(
                value: t.toDouble(),
                onChanged: (value) {
                  setState(() {
                    print("$t");
                    t = value as int;
                  });
                },
                items: [
                  DropdownMenuItem(
                    child: Text("30"),
                    value: 30,
                  ),
                  DropdownMenuItem(child: Text("25"), value: 25),
                  DropdownMenuItem(child: Text("20"), value: 20),
                  DropdownMenuItem(child: Text("15"), value: 15),
                  DropdownMenuItem(child: Text("10"), value: 10),
                  DropdownMenuItem(child: Text("5"), value: 5),
                ])
          ],
        ),
      ),
    );
  }

  textcolor(BuildContext context) {
    return showModalBottomSheet(
        builder: (context) {
          return Container(
            height: 300,
            width: 100,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GridView.builder(
                      itemCount: col.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              textbool = true;
                              textcol = index;
                              print(textbool);
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: col[index],
                            ),
                            margin: EdgeInsets.all(5),
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5)),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
          );
        },
        context: context);
  }

  boot(BuildContext context) {
    return showModalBottomSheet(
        builder: (context) {
          return Container(
            height: 300,
            width: 100,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GridView.builder(
                      itemCount: col.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              i = index;
                            });
                          },
                          child: Container(
                            height: 100,
                            margin: EdgeInsets.all(5),
                            width: 100,
                            color: col[index],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5)),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
          );
        },
        context: context);
  }

  backgroun(BuildContext context) {
    return showModalBottomSheet(
        builder: (context) {
          return Container(
            height: 300,
            width: 100,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: GridView.builder(
                      itemCount: col.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              bagcolor = true;
                              back = index;
                              print("bagcolor=$bagcolor");
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.all(5),
                            color: col[index],
                          ),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5)),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
          );
        },
        context: context);
  }
}
