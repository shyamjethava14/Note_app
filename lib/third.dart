import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:note_app/first.dart';
import 'package:sqflite/sqflite.dart';

class third extends StatefulWidget {
  int id;
  String title, content;
  Database? database;

  third(this.id, this.title, this.content, this.database);

  @override
  State<third> createState() => _thirdState();
}

class _thirdState extends State<third> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    t1.text = widget.title;
    t2.text = widget.content;
  }

  List<Color> co = [
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
  List<Color> col = [
    Color(0xbada2621),
    Color(0xb35ed91a),
    Color(0xb31a79d9),
    Color(0xb3cc1ad9),
    Color(0xb3ea5e6f),
    Color(0xb3ead35e),
    Color(0xb319ad86),
    Color(0xb32199da),
    Color(0xb3da6821),
    Color(0xb3da21c1),
    Color(0xb321da6b),
    Color(0xb39621da),
    Color(0xb3216bda),
    Color(0xb3a6da21),
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
                String title, content, qry;
                title = t1.text;
                content = t2.text;
                qry =
                    "update note set title='$title',content='$content' where id=${widget.id}";
                int r_id;
                r_id = await widget.database!.rawUpdate(qry);
                if (r_id == 1) {
                  print("Data Updated");
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return first(widget.database);
                    },
                  ));
                } else {
                  print("Data not Updated");
                }
              },
              icon: Icon(Icons.system_update_alt)),
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
                  child: Row(
                children: [
                  Container(
                      color: Colors.white,
                      child: Icon(
                        Icons.share_rounded,
                        color: Colors.black,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text("share"),
                ],
              )),
              PopupMenuItem(
                  onTap: () async {
                    String qry;
                    qry = "delete from note where id=${widget.id}";
                    int r_id = await widget.database!.rawDelete(qry);
                    if (r_id == 1) {
                      setState(() {});
                    } else {
                      print("Not Deleted");
                    }
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
                      itemCount: co.length,
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
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: col[index],
                            ),
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
                      itemCount: co.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              i = index;
                            });
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.all(5),
                            color: co[index],
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
                      itemCount: co.length,
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
                            color: co[index],
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
