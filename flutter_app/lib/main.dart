import 'package:flutter/material.dart';
import 'package:flutter_app/inherited/share_data_widget.dart';
import 'package:flutter_app/stream/stream_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> titles = ["InheritedWidget", "StreamWidget"];
  final List<Widget> pages = [InheritedWidgetTestRoute(), StreamWidget()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.separated(
            itemCount: titles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return pages[index];
                      }));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15),
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(titles[index]),
                  )
              );
            },
          separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.black26,
              );
          },
        )
    );
  }
}
