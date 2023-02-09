import 'ReferenceTab.dart';
import 'PlayTab.dart';
import 'AboutGame.dart';
import 'RulesTab.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyGameApp());
}

class MyGameApp extends StatefulWidget {
  const MyGameApp({super.key});
  @override
  State<MyGameApp> createState() => _MyGameAppState();
}

class _MyGameAppState extends State<MyGameApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keeps & Counters',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'FrizQuadrata'),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Cards'),
                Tab(text: 'Play'),
                Tab(text: 'Rules'),
                Tab(text: 'About'),
              ],
            ),
            title: const Text(textAlign: TextAlign.center, "Keeps & Counters"),
          ),
          body: TabBarView(
            children: [
              const ReferenceTab(),
              const PlayTab(),
              const RulesTab(),
              GameWidget(game: AboutGameTab()),
            ],
          ),
        ),
      ),
    );
  }
}
