import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoMoviles/others/house/house_page.dart';

class TopicDetailsPage extends StatefulWidget {
  final String title, desc, doc_id;
  final Color fondo;
  TopicDetailsPage(
      {Key key,
      @required this.title,
      @required this.desc,
      @required this.fondo,
      @required this.doc_id})
      : super(key: key);

  @override
  TopicDetailsPageState createState() => TopicDetailsPageState();
}

class TopicDetailsPageState extends State<TopicDetailsPage> {
  List<dynamic> repliesList;
  TextEditingController replyCont = new TextEditingController();
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
                FutureBuilder(
                  future: _getAnswers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Algo salio mal",
                            style:
                                TextStyle(fontSize: 32, color: Colors.white)),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text("Aún no hay respuestas",
                              style:
                                  TextStyle(fontSize: 32, color: Colors.white)),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.width * 1.2,
                        child: ListView.builder(
                          itemCount: repliesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  repliesList[index],
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Card(
                    color: Colors.white,
                    child: TextField(
                      controller: replyCont,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Agrega un comentario',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () async {
                            try {
                              await FirebaseFirestore.instance
                                  .collection('forums')
                                  .doc(widget.doc_id)
                                  .update({
                                "respuestas": FieldValue.arrayUnion(
                                    [replyCont.text as dynamic])
                              });
                            } catch (e) {
                              throw e;
                            }
                            replyCont.text = '';
                            await _getAnswers();
                            setState(() {});
                          },
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

  Future<List<dynamic>> _getAnswers() async {
    List<dynamic> replies = await FirebaseFirestore.instance
        .collection('forums')
        .doc(widget.doc_id)
        .get()
        .then((value) => value.data()['respuestas']);

    return repliesList = replies;
  }
}
