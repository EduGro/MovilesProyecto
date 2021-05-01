import 'package:flutter/material.dart';
import 'package:proyectoMoviles/others/house/topic_details.dart';

class topicItem extends StatefulWidget {
  final Map<String, dynamic> topic;
  final Color fondo;
  topicItem({
    Key key,
    @required this.topic,
    @required this.fondo
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
              child: Text(
                "${topic['title']}",
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
                    Text(
                      "${topic['respuestas'].length} respuestas",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "${topic['description']}", //TODO .substring(0, 50) checar longitud de desc
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

  void _openTopic() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TopicDetailsPage(title: widget.topic['title'], desc: widget.topic['description'], respuestas: widget.topic['respuestas'], fondo: widget.fondo,);
        },
      ),
    );
  }
}
