import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/display_group.dart';
import '../provider/all_provider.dart';

class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupInformation = ref.watch(countProvider);
    final selectedGroupKey = ref.watch(selectedKeyProvider);
    var selectedGroup = groupInformation[selectedGroupKey];
    if (groupInformation[selectedGroupKey] != null) {
      selectedGroup as GroupInformation;
    } else {
      return SizedBox();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('MJカウンター'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Text(
            '合計回数 0',
            style: TextStyle(fontSize: 25),
          ),
          Container(
            padding: EdgeInsets.only(right: 80),
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  Text('ビリ:${selectedGroup.countGroup.lastRate}'),
                  SizedBox(
                    height: 5,
                  ),
                  Text('飛び: ${selectedGroup.countGroup.flyAwayRate}')
                ],
              ),
            ),
          ),
          Divider(),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Container(
                width: 100,
                height: 50,
                child: Text('メンバー'),
              ),
              Container(
                width: 100,
                height: 50,
                child: Text(
                  "ビリ",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 100,
                height: 50,
                child: Text(
                  "飛び",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          if (selectedGroup != null && selectedGroup.countMembers != null)
            for (var member in selectedGroup.countMembers!)
              Container(
                height: 100,
                padding: const EdgeInsets.all(6),
                color: Colors.deepOrangeAccent.shade100.withOpacity(0.5),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 100,
                      child: Text(member.name),
                    ),
                    Container(
                      width: 100,
                      height: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade200),
                          // side: MaterialStateProperty.all<BorderSide>(
                          //   BorderSide(
                          //     color: Colors.red, //色
                          //     width: 1, //太さ
                          //   ),
                          // ),
                        ),
                        onPressed: () {},
                        child: Text('${member.lastCount}回'),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 100,
                      height: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.shade200),
                        ),
                        onPressed: () {},
                        child: Text('${member.flyAwayCount}回'),
                      ),
                    )
                  ],
                ),
              )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
