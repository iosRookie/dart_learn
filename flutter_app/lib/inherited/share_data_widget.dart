import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShareDataWidget extends InheritedWidget {
  final int data;

  ShareDataWidget({
    @required this.data,
    Widget child
  }) : super(child: child);

  static ShareDataWidget of(BuildContext context) {
    return context.getElementForInheritedWidgetOfExactType<ShareDataWidget>().widget;
    // return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      ShareDataWidget.of(context).data.toString()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("Dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InheritedWidgetTestRouteState();

}

class InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
          data: count,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: _TestWidget(),
              ),
              RaisedButton(
                child: Text("Increment"),
                onPressed: () => setState(() => ++count),
              )
            ],
          )
      ),
    );
  }
}