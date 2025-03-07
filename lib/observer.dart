/*// import 'dart:async';
// import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Map _source = {ConnectivityResult.none: false};
//   final MyConnectivity _connectivity = MyConnectivity.instance;

//   @override
//   void initState() {
//     super.initState();
//     _connectivity.initialise();
//     _connectivity.myStream.listen((source) {
//       setState(() => _source = source);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     String string;
//     switch (_source.keys.toList()[0]) {
//       case ConnectivityResult.mobile:
//         string = 'Mobile: Online';
//         break;
//       case ConnectivityResult.wifi:
//         string = 'WiFi: Online';
//         break;
//       case ConnectivityResult.none:
//       default:
//         string = 'Offline';
//     }

//     return Scaffold(
//       body: Center(child: Text(string)),
//     );
//   }

//   @override
//   void dispose() {
//     _connectivity.disposeStream();
//     super.dispose();
//   }
// }

// class MyConnectivity {
//   MyConnectivity._();

//   static final _instance = MyConnectivity._();
//   static MyConnectivity get instance => _instance;

//   final _controller = StreamController.broadcast();
//   Stream get myStream => _controller.stream;

//   void initialise() async {
//     ConnectivityResult result = await Connectivity().checkConnectivity();
//     _checkStatus(result);
//     Connectivity().onConnectivityChanged.listen((result) {
//       _checkStatus(result);
//     });
//   }

//   void _checkStatus(ConnectivityResult result) async {
//     bool isOnline = false;
//     try {
//       final result = await InternetAddress.lookup('example.com');
//       isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       isOnline = false;
//     }
//     _controller.sink.add({result: isOnline});
//   }

//   void disposeStream() => _controller.close();
// }
*/
import 'dart:io';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ActiveConnection = false;
  String T = "";
  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
          T = "Turn off the data and repress again";
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
        T = "Turn On the data and repress again";
      });
    }
  }

  @override
  void initState() {
    CheckUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GeeksforGeeks"),
      ),
      body: Column(
        children: [
          Text("Active Connection? $ActiveConnection"),
          const Divider(),
          Text(T),
          OutlinedButton(
              onPressed: () {
                CheckUserConnection();
              },
              child: const Text("Check")),
          ElevatedButton(onPressed: () async {}, child: const Text('Enter'))
        ],
      ),
    );
  }
}
