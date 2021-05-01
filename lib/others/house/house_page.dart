import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectoMoviles/others/house/topics.dart';
import 'package:proyectoMoviles/utils/constants.dart';

class HousePage extends StatefulWidget {
  final String casa;
  HousePage({Key key, this.casa}) : super(key: key);

  @override
  _HousePageState createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  List<Map<String, dynamic>> topicsList;
  Color fondo;

  @override
  Widget build(BuildContext context) {
    if (widget.casa == 'Slytherin')
      fondo = SLYTHERIN_COLOR;
    else if (widget.casa == 'Ravenclaw')
      fondo = RAVENCLAW_COLOR;
    else if (widget.casa == 'Hufflepuff')
      fondo = HUFFLEPUFF_COLOR;
    else
      fondo = GRYFFINDOR_COLOR;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.casa)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //TODO
            },
          ),
        ],
      ),
      backgroundColor: fondo,
      body: FutureBuilder(
          future: _getTopics(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Algo salio mal",
                    style: TextStyle(fontSize: 32, color: Colors.white)),
              );
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data.length == 0) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text("Aún no hay temas de conversación en esta casa",
                      style: TextStyle(fontSize: 32, color: Colors.white)),
                ),
              );
            }else if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: ListView.builder(
                  itemCount: topicsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return topicItem(
                      topic: topicsList[index],
                      fondo: fondo,
                    );
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController _title = new TextEditingController();
          TextEditingController _desc = new TextEditingController();
          showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: Text('Agrega un nuevo tema'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(hintText: "Título de tu tema"),
                    controller: _title,
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: "Contenido"),
                    controller: _desc,
                  ),
                ],
              ),
              actions: <Widget>[
                Center(
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        await FirebaseFirestore.instance
                            .collection('forums')
                            .add({
                          "casa": widget.casa[0],
                          "title": _title.text,
                          "description": _desc.text,
                          "respuestas": [],
                        });
                      } catch (e) {
                        throw e;
                      }
                      await _getTopics();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                    child: Text('Agregar'),
                  ),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getTopics() async {
    List<QueryDocumentSnapshot> documentList;
    documentList = await FirebaseFirestore.instance
        .collection('forums')
        .where('casa', isEqualTo: widget.casa[0])
        .get()
        .then((value) => value.docs);

    return topicsList = documentList.map((e) => e.data()).toList();
  }
}
