import 'package:flutter/widgets.dart';

class InheritedProvider<T> extends InheritedWidget {
  final T data;

  InheritedProvider({
    this.data,
    Widget child
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) {
      return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({
    this.data,
    this.child
  });

  static T of<T>(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider> {
  void update() {
    setState(() {
    });
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<ChangeNotifier> oldWidget) {
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }


  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}