import 'package:flutter/material.dart';
import 'package:salla_thumara/core/utilities/constatnt.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TweenAnimationBuilder(
              duration: const Duration(milliseconds: 1500),
              // curve: Curves.elasticInOut,
              tween: Tween(begin: 300.0, end: 100.0),
              builder: (context, size, child) {
                // horizontal disposition of the widget.
                return IconButton(
                    iconSize: size,
                    onPressed: () {},
                    icon: const Icon(Icons.linked_camera));

                /*
                    Transform.translate( 
                     offset:  Offset( 
                       value * 500, 
                        0.0 
                     ), 
                     child: child, 
                   ); */
              },
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.purpleAccent,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (c) {
                    return const Center(
                      child: MyWidget(),
                    );
                  }));
                },
                child: const Text('Enter')),
            const SizedBox(
              height: 150,
            ),
            ElevatedButton(
                onPressed: () {
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: true,
                    barrierColor: Colors.transparent,
                    transitionDuration: const Duration(seconds: 1),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return GestureDetector(
                        onVerticalDragUpdate: (dragUpdateDetails) {
                          Navigator.of(context).pop();
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 40),
                            Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Container(
                                height: 25,
                                width: width(context) / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:
                                    const Center(child: Text('Notification ')),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: anim1.drive(Tween(
                            begin: const Offset(0, -1),
                            end: const Offset(0, 0))),
                        child: child,
                      );
                    },
                  );
                },
                child: const Text('Show'))
          ],
        ),
      ),
    );
  }
}
