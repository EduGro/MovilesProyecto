import 'package:flutter/material.dart';
import 'package:proyectoMoviles/utils/item_topic.dart';

class topicItem extends StatefulWidget {
  final itemTopic topic;
  topicItem({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  _topicItemState createState() => _topicItemState();
}

class _topicItemState extends State<topicItem> {
  @override
  Widget build(BuildContext context) {
    var topic = widget.topic;
    return Padding(
        padding: EdgeInsets.only(bottom: 10.0, top: 10.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Colors.white,
          child: GestureDetector(
            onTap: _openTopic,
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text("${topic.title}",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.question_answer),
                      Text("${topic.respuestas} Respuestas",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text("${topic.first_post.substring(0, 50)}",
                      style: TextStyle(
                        fontSize: 18,
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

  void _openTopic(){
    //TODO
  }
}
