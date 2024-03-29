import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/todo_list_model.dart';
import 'package:todo/page/detail_screen.dart';
import 'package:todo/route/scale_route.dart';
import 'package:todo/shadow_image.dart';
import 'package:todo/task_progress_indicator.dart';

import 'gradient_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var app = MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline1: const TextStyle(
              fontSize: 36.0, fontWeight: FontWeight.w500, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: 'TODO'),
    );

    return ScopedModel<TodoListModel>(
      model: TodoListModel(),
      child: app,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  final todos = [
    {
      "id": 923,
      "code_point": 0xe878,
      "progress": 60.0,
      "color": Colors.green,
    },
    {
      "id": 933,
      "code_point": 0xe7fd,
      "progress": 40.0,
      "color": Colors.blue,
    },
    {
      "id": 943,
      "code_point": 0xe854,
      "progress": 90.0,
      "color": Colors.orange,
    },
    // {"code_point": 0xe877, "progress": 100.0, "color": Colors.red},
  ];

  HeroId _generateHeroIds(int position) {
    var todo = todos[position];
    return HeroId(
        processId: 'progress_id_${todo['id']}',
        titleId: 'title_id_${todo['id']}',
        codePointId: 'code_point_id_${todo['id']}',
        remainingTaskId: 'remaining_task_id_${todo['id']}');
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _counter = 0;
  MaterialColor color = Colors.purple;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
    super.initState();
  }

  void _onHandleTap() {
    var currentPageIndex = _pageController.page!.toInt();
    var todo = widget.todos[currentPageIndex];
    var heroIds = widget._generateHeroIds(currentPageIndex);

    Navigator.push(
      context,
      ScaleRoute(
        widget: DetailScreen(
          color: todo['color'] as MaterialColor,
          codePoint: todo['code_point'] as int,
          progress: todo['progress'] as double,
          id: todo['id'] as int,
          heroIds: heroIds,
        ),
      ),

      // MaterialPageRoute(
      //   builder: (context) => DetailScreen(
      //         color: todo['color'],
      //         codePoint: todo['code_point'],
      //         progress: todo['progress'],
      //         id: todo['id'],
      //         heroIds: heroIds,
      //       ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      color: color,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    margin: EdgeInsets.only(top: 42.0),
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
                  1, //trọng lượng của flex giúp phân bổ bố cục https://openplanning.net/13117/flutter-expanded
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
                    var heroIds = widget._generateHeroIds(index);
                    return GestureDetector(
                      onTap: _onHandleTap,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation:
                            4.0, //độ mờ bên dưới https://api.flutter.dev/flutter/material/Material/elevation.html
                        margin: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 8.0),
                        //vertical - chiều dọc.
                        //  horizontal - ngang
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Hero(
                                tag: heroIds.codePointId,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.only(
                                    bottom: 6.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
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
                              ),
                              Spacer(
                                flex: 8,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 4.0),
                                child: Hero(
                                  tag: heroIds.remainingTaskId,
                                  child: Text(
                                    "12 Tasks",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ),
                              ),
                              Container(
                                child: Hero(
                                  tag: heroIds.remainingTaskId,
                                  child: Text(
                                    'Work',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Hero(
                                tag: heroIds.processId,
                                child: TaskProgressIndicator(
                                  color: widget.todos[index]["color"]
                                      as MaterialColor,
                                  progress: widget.todos[index]["progress"],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount:
                      widget.todos.length, //properties cua PageView ?????
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 68.0),
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
      ),
    );
  }
}