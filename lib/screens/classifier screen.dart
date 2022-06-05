import 'package:flutter/material.dart';

import '../apiServices/classifier.dart';
//import 'package:tflite_flutter_plugin_example/classifier.dart';

class classifier extends StatefulWidget {
  @override
  _classifierState createState() => _classifierState();
}

class _classifierState extends State<classifier> {
  late TextEditingController _controller;
  late Classifier _classifier;
  late List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _classifier = Classifier();
    _children = [];
    _children.add(Container());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.orangeAccent,
              title: const Text('Text classification'),
            ),
            body: Container(
                padding: const EdgeInsets.all(4),
                child: Column(children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    itemCount: _children.length,
                    itemBuilder: (_, index) {
                      return _children[index];
                    },
                  )),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orangeAccent)),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                                hintText: 'Write some text here'),
                            controller: _controller,
                          ),
                        ),
                        TextButton(
                            child: const Text('Classify'),
                            onPressed: () async {
                              final text = _controller.text;
                              var prediction = _classifier.classify(text);
                              setState(() {
                                _children.add(Dismissible(
                                  key: GlobalKey(),
                                  onDismissed: (direction) {},
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      color: prediction[1] > prediction[0]
                                          ? Colors.lightGreen
                                          : Colors.redAccent,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Input: $text",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text("Output:"),
                                          if (prediction[1] > prediction[0])
                                            Text(
                                                "   Positive: ${prediction[1]}")
                                          else
                                            Text(
                                                "   Negative: ${prediction[0]}"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                                _controller.clear();
                              });
                            })
                      ]))
                ]))));
  }
}
