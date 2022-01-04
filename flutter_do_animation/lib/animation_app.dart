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

  @override
  void initState() {
    // TODO: implement initState
    peoples.add(People('해피', 165, 60));
    peoples.add(People('손데이', 174, 70));
    peoples.add(People('누수노시뇽', 164, 53));
    peoples.add(People('페이커', 170, 100));
    peoples.add(People('클로저', 100, 80));
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
                      color: Colors.blue,
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
                      }
                    });
                  },
                  child: const Text('다음')),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (current > 0) {
                        current--;
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
}
