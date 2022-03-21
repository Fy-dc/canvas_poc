import 'package:flutter/material.dart';
import 'package:poc/circle.dart';
import 'package:poc/painter.dart';
import 'package:poc/place_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Draw canvas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> points = [];
  bool startDrawing = false;
  String pathString = '';
  List<dynamic> paths = [];
  List<dynamic> placeOffset = [];
  int currentPathIndex = 0;
  late Offset startPoints;
  bool setingPlaces = false;

  String pointToChar(type, x, y) => '$type $x $y';
  String arrayPointsToPath(List<dynamic> pts) {
    List<String> p = [];
    for (var point in pts) {
      p.add(
        pointToChar(point['type'], point['x'], point['y']),
      );
    }
    return p.join(' ');
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      // pathString = points.isNotEmpty ? arrayPointsToPath(points) : '';
      // if (pathString != '') paths.add(parseSvgPathData('$pathString Z'));
    });
  }

  void drawPath(Offset clientOffset) {
    int newX = clientOffset.dx.toInt();
    int newY = clientOffset.dy.toInt();

    if (!setingPlaces) {
      if (pathString == '' && !startDrawing) {
        setState(() {
          startDrawing = true;
          currentPathIndex++;
          startPoints = clientOffset;
          points.add({
            'type': 'M',
            "x": newX,
            "y": newY,
          });
        });
      } else {
        setState(() {
          startDrawing = false;
          points.add({
            'type': 'L',
            "x": newX,
            "y": newY,
          });
        });

        if ((newX <= startPoints.dx.toInt() + 5 &&
                newX >= startPoints.dx.toInt() - 5) &&
            (newY <= startPoints.dy.toInt() + 5 &&
                newY >= startPoints.dy.toInt() - 5)) {
          setState(() {
            startDrawing = false;
            points.add({
              'type': 'L',
              "x": startPoints.dx,
              "y": startPoints.dy,
            });
            pathString = arrayPointsToPath(points);
            paths.insert(
                currentPathIndex, {"id": currentPathIndex, "path": pathString});
            points.clear();
          });
        }
      }
    } else {
      placeOffset.add(clientOffset);
    }

    setState(() {
      pathString = arrayPointsToPath(points);
      if (paths.isEmpty) {
        paths.add({"id": currentPathIndex, "path": pathString});
      } else {
        paths.insert(
            currentPathIndex, {"id": currentPathIndex, "path": pathString});
      }
    });
  }

  void movePlace(String move) {
    Offset current = placeOffset[placeOffset.length - 1];

    switch (move) {
      case 'UP':
        current = Offset(current.dx, current.dy - 10);
        break;
      case 'DOWN':
        current = Offset(current.dx, current.dy + 10);
        break;
      case 'LEFT':
        current = Offset(current.dx - 10, current.dy);
        break;
      case 'RIGHT':
        current = Offset(current.dx + 10, current.dy);
        break;
    }

    setState(() {
      placeOffset[placeOffset.length - 1] = current;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GestureDetector(
        onTapUp: (tapDetails) {
          drawPath(tapDetails.localPosition);
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.white,
          child: Stack(children: [
            ...paths
                .map(
                  (path) => CustomPaint(
                    size: const Size.square(3600),
                    painter: FilledPathPainter(
                      path: path['path'],
                      points: points,
                      color: Colors.blue,
                      currentIndex: currentPathIndex,
                      startDrawing: startDrawing,
                    ),
                  ),
                )
                .toList(),
            ...placeOffset
                .map(
                  (place) => CustomPaint(
                    painter: CirclePainter(
                      offset: place,
                      color: Colors.red,
                    ),
                  ),
                )
                .toList(),
            setingPlaces ? PlaceController(movePlace: movePlace) : Container(),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            setingPlaces = !setingPlaces;
          });
        },
        child: const Icon(Icons.chair),
        backgroundColor: setingPlaces ? Colors.red : Colors.blue,
      ),
    );
  }
}
