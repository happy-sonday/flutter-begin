import 'package:flutter/material.dart';
import 'package:flutter_do_animation/people.dart';

class AnimationApp extends StatefulWidget {
  const AnimationApp({Key? key}) : super(key: key);

  @override
  _AnimationAppState createState() => _AnimationAppState();
}

class _AnimationAppState extends State<AnimationApp> {
  List<People> peoples = List.empty(growable: true);
  int current = 0;
  Color weightColor = Colors.blue;

  @override
  void initState() {
    // TODO: implement initState
    peoples.add(People('해피', 120, 39));
    peoples.add(People('손데이', 174, 70));
    peoples.add(People('누수노시뇽', 164, 53));
    peoples.add(People('페이커', 170, 62));
    peoples.add(People('클로저', 100, 80));
    peoples.add(People('잠만보', 120, 150));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation APp"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text('이름: ${peoples[current].name}'),
                    ),
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInCubic,
                      color: Colors.amber,
                      child: Text(
                        "키: ${peoples[current].height}",
                        textAlign: TextAlign.center,
                      ),
                      width: 50,
                      height: peoples[current].height,
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                      curve: Curves.easeInCubic,
                      color: weightColor,
                      child: Text(
                        "몸무게 ${peoples[current].weight}",
                        textAlign: TextAlign.center,
                      ),
                      width: 50,
                      height: peoples[current].weight,
                    ),
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                      curve: Curves.linear,
                      color: Colors.pinkAccent,
                      child: Text(
                        "bmi ${peoples[current].bmi.toString().substring(0, 2)}",
                        textAlign: TextAlign.center,
                      ),
                      width: 50,
                      height: peoples[current].bmi,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                ),
                height: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current < peoples.length - 1) {
                        current++;
                        _changeWeightColor(peoples[current].weight);
                      }
                    });
                  },
                  child: const Text('다음')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current > 0) {
                        current--;
                        _changeWeightColor(peoples[current].weight);
                      }
                    });
                  },
                  child: const Text('이전')),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      ),
    );
  }

  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }
}
