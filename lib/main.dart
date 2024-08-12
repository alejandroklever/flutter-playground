import 'package:flutter/material.dart';
import 'package:testing_lab/pages/game_page.dart';
import 'package:testing_lab/pages/scrollable_table_page.dart';

import 'pages/counter_page.dart';
import 'pages/list_view_page.dart';
import 'pages/scrollable_positioned_list_view_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "list_view_page",
      routes: {
        "counter_page": (context) => const CounterPage(title: "Counter Page"),
        "scrollable_table_page": (context) => const ScrollableTablePage(),
        "game_page": (context) => const GamePage(),
        "list_view_page": (context) => const ListViewPage(),
        "scrollable_positioned_list_view_page": (context) =>
            const ScrollablePositionedListPage(),
      },
    );
  }
}
