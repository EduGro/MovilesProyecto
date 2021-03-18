import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/item_topic.dart';
import 'package:proyectoMoviles/others/topics.dart';

class HousePage extends StatelessWidget {
  final List<itemTopic> topicList;
  HousePage({
    Key key,
    @required this.topicList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Casa"), //TODO: Cambiar a G, S, H o R según el usuario
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //TODO
              },
            ),
        ],
      ),
      backgroundColor: Colors.green[900], //TODO: Cambiar a verde, azul, amarillo, rojo según la casa
      body: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: ListView.builder(
          itemCount: topicList.length,
          itemBuilder: (BuildContext context, int index) {
            return topicItem(
              topic: topicList[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}