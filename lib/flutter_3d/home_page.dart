import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'dart:math';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic earth = Object();
  final TextEditingController _controller = TextEditingController();
  String value = "";

  @override
  void initState() {
    set();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  set() {
    // value = _controller.text;
    setState(() {
      value = "";
    });
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        value = _controller.text;
        value.isNotEmpty
            ? {
                earth = Object(fileName: "assets/${value.toUpperCase()}.obj"),
              }
            : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      // appbar yaratish
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "3D Objects in Flutter",
          style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // const Spacer(),
            const SizedBox(
              height: 100,
            ),
            buildCube(earth),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "belgi kiriting...",
                      ),
                      keyboardType: TextInputType.text,
                      maxLength: 1,
                      onChanged: (String v) {
                        if (!(v.codeUnitAt(0) > 64 && v.codeUnitAt(0) < 123 ||
                            v.codeUnitAt(0) > 47 && v.codeUnitAt(0) < 58)) {
                          _controller.clear();
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      set();
                    },
                    child: const Text("3D"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCube(Object obj) {
    return Expanded(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          // ..setEntry(4, 3, 0.001)
          ..rotateY(180 / 180 * pi),
        child: value.isNotEmpty
            ? Cube(
                onSceneCreated: (scene) {
                  scene.world.add(obj);
                  scene.camera.zoom = 10;
                },
              )
            : const Text(""),
      ),
    );
  }
}
