import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoMoviles/others/house/topics.dart';
import 'package:proyectoMoviles/utils/constants.dart';

import 'bloc/house_bloc.dart';

final bloc = HouseBloc();

class HousePage extends StatefulWidget {
  final String casa;
  HousePage({Key key, this.casa}) : super(key: key);

  @override
  _HousePageState createState() => _HousePageState();
}

class _HousePageState extends State<HousePage> {
  var input = new TextEditingController();
  Color fondo;
  bool search = false;
  bool themes = false;

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
              setState(() {
                search = !search;
              });
            },
          ),
        ],
      ),
      backgroundColor: fondo,
      body: BlocProvider(
        create: (context) => HouseBloc()
          ..add(InitialEvent())
          ..add(TopicsEvent(casa: widget.casa[0])),
        child: BlocConsumer<HouseBloc, HouseState>(
          listener: (context, state) {
            if (state is HouseInitial) {
              print(themes);
              themes = false;
            }
          },
          builder: (context, state) {
            print(state);
            if (state is TopicsState) {
              if (state.topicsList.length == 0) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Visibility(
                        maintainAnimation: true,
                        maintainState: true,
                        visible: search,
                        child: Card(
                          color: Colors.white,
                          child: SizedBox(
                            height: 35.0,
                            child: TextField(
                              controller: input,
                              decoration: InputDecoration(
                                hintText: "Palabra a buscar",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<HouseBloc>(context).add(
                                        SearchEvent(
                                            casa: widget.casa[0],
                                            keyword: input.text));
                                    setState(() {
                                      themes = true;
                                    });
                                  },
                                  icon: Icon(Icons.search),
                                ),
                              ),
                              onSubmitted: (content) {
                                BlocProvider.of<HouseBloc>(context).add(
                                    SearchEvent(
                                        casa: widget.casa[0],
                                        keyword: input.text));
                                setState(() {
                                  themes = true;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: Text(
                                "Aún no hay temas de conversación en esta casa",
                                style: TextStyle(
                                    fontSize: 32, color: Colors.white)),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            visible: themes,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    search = !search;
                                  });
                                  BlocProvider.of<HouseBloc>(context)
                                      .add(TopicsEvent(casa: widget.casa[0]));
                                },
                                child: Text("Volver a ver todos los temas"),
                                color: Colors.black,
                                textColor: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              onPressed: () {
                                TextEditingController _title =
                                    new TextEditingController();
                                TextEditingController _desc =
                                    new TextEditingController();
                                showDialog(
                                  context: context,
                                  builder: (context2) => new AlertDialog(
                                    title: Text('Agrega un nuevo tema'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                              hintText: "Título de tu tema"),
                                          controller: _title,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                              hintText: "Contenido"),
                                          controller: _desc,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      Center(
                                        child: MaterialButton(
                                          onPressed: () {
                                            BlocProvider.of<HouseBloc>(context)
                                                .add(AddTopicEvent(
                                                    casa: widget.casa[0],
                                                    title: _title.text,
                                                    desc: _desc.text));
                                            Navigator.of(context2).pop();
                                          },
                                          child: Text('Agregar'),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Icon(Icons.add),
                              color: Colors.black,
                              textColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    Visibility(
                      maintainAnimation: true,
                      maintainState: true,
                      visible: search,
                      child: Card(
                        color: Colors.white,
                        child: SizedBox(
                          height: 35.0,
                          child: TextField(
                            controller: input,
                            decoration: InputDecoration(
                              hintText: "Palabra a buscar",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  BlocProvider.of<HouseBloc>(context).add(
                                      SearchEvent(
                                          casa: widget.casa[0],
                                          keyword: input.text));
                                  setState(() {
                                    themes = true;
                                  });
                                },
                                icon: Icon(Icons.search),
                              ),
                            ),
                            onSubmitted: (content) {
                              BlocProvider.of<HouseBloc>(context).add(
                                  SearchEvent(
                                      casa: widget.casa[0],
                                      keyword: input.text));
                              setState(() {
                                themes = true;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: state.topicsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return topicItem(
                              topic: state.topicsList[index],
                              fondo: fondo,
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: themes,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  search = !search;
                                });
                                setState(() {
                                  themes = false;
                                });
                                BlocProvider.of<HouseBloc>(context)
                                    .add(TopicsEvent(casa: widget.casa[0]));
                              },
                              child: Text("Volver a ver todos los temas"),
                              color: Colors.black,
                              textColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: RaisedButton(
                            onPressed: () {
                              TextEditingController _title =
                                  new TextEditingController();
                              TextEditingController _desc =
                                  new TextEditingController();
                              showDialog(
                                context: context,
                                builder: (context2) => new AlertDialog(
                                  title: Text('Agrega un nuevo tema'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                            hintText: "Título de tu tema"),
                                        controller: _title,
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                            hintText: "Contenido"),
                                        controller: _desc,
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    Center(
                                      child: MaterialButton(
                                        onPressed: () {
                                          BlocProvider.of<HouseBloc>(context)
                                              .add(AddTopicEvent(
                                                  casa: widget.casa[0],
                                                  title: _title.text,
                                                  desc: _desc.text));
                                          Navigator.of(context2).pop();
                                        },
                                        child: Text('Agregar'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Icon(Icons.add),
                            color: Colors.black,
                            textColor: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
