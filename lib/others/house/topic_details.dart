import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopicDetailsPage extends StatefulWidget {
  final String title, desc;
  final Color fondo;
  final List<dynamic> respuestas;
  TopicDetailsPage(
      {Key key,
      @required this.title,
      @required this.desc,
      @required this.respuestas,
      @required this.fondo})
      : super(key: key);

  @override
  TopicDetailsPageState createState() => TopicDetailsPageState();
}

class TopicDetailsPageState extends State<TopicDetailsPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Respuestas al tema"),
      ),
      backgroundColor: widget.fondo,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.title == null ? '' : widget.title}",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.desc == null ? '' : widget.desc}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 1.2,
                  child: ListView.builder(
                    itemCount: widget.respuestas.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            widget.respuestas[index],
                            style: TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Card(
                    color: Colors.white,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Agrega un comentario',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
