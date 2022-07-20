import 'package:flutter/material.dart';
import 'package:todo/shadow_image.dart';
import 'package:todo/task_progress_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,

        textTheme: TextTheme(
          headline1: const TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.w500, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: 'TODO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String title;
  final todos = [
    {"code_point": 0xe878, "progress": 60.0, "color": Colors.green},
    {"code_point": 0xe7fd, "progress": 40.0, "color": Colors.blue},
    {"code_point": 0xe854, "progress": 90.0, "color": Colors.orange},
    // {"code_point": 0xe877, "progress": 100.0, "color": Colors.red},
  ];
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _counter = 0;
  MaterialColor color = Colors.purple;
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
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
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
      backgroundColor: color,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 36.0, left: 56.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ShadowImage(),
                Container(
                  margin: EdgeInsets.only(top: 22.0, bottom: 12.0),
                  child: Text(
                    "Hello Phong",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  'Looks like feel good.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white.withOpacity(0.7)),
                ),
                Container(
                  height: 4.0,
                ),
                Text('You have 3 tasks to do today'),
                Container(
                  margin: EdgeInsets.only(top: 52.0),
                  child: Text(
                    'Today: June 16 2022',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex:
                6, //trọng lượng của flex giúp phân bổ bố cục https://openplanning.net/13117/flutter-expanded
            child: NotificationListener<ScrollNotification>(
              onNotification: (notifacation) {
                if (notifacation is ScrollEndNotification) {
                  var currentPage = _pageController.page;
                  print("ScroolNotification = ${_pageController.page}");
                  print("_counter = ${_counter}");
                  setState(() {
                    int indexPage = currentPage!.toInt();
                    Object? materialColor = widget.todos[indexPage]["color"];
                    color = materialColor
                        as MaterialColor; //https://www.youtube.com/watch?v=x-5gF6IfLws
                  });
                  return true;
                }
                return false;
              },
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    elevation:
                        4.0, //độ mờ bên dưới https://api.flutter.dev/flutter/material/Material/elevation.html
                    margin:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                    //vertical - chiều dọc.
                    //  horizontal - ngang
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 26.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            //Icon trên đầu trang
                            child: Icon(
                              IconData(
                                widget.todos[index]["code_point"] as int,
                                fontFamily: 'MaterialIcons',
                              ),
                              color: widget.todos[index]["color"]
                                  as MaterialColor, //color in icon
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              'Work',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Colors.grey[500]),
                            ),
                          ),
                          TaskProgressIndicator(
                            color:
                                widget.todos[index]["color"] as MaterialColor,
                            progress: widget.todos[index]["progress"],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: widget.todos.length, //properties cua PageView ?????
              ),
            ),
          ),
          Spacer(
            flex: 1,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'New Todo',
        backgroundColor: Colors.white,
        foregroundColor: color,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}