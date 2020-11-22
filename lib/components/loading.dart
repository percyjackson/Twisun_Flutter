import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:twisun/constants.dart';

class Loading extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  const Loading(
      {Key key,
      @required this.inAsyncCall,
      this.opacity = 0.3,
      this.color = Colors.grey,
      this.valueColor,
      @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = new List<Widget>();
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = new Stack(
        children: [
          new Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          new Center(child: new CircularProgressIndicator()),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}

// class Loading extends StatefulWidget {
//   @override
//   _LoadingState createState() => _LoadingState();
// }

// class _LoadingState extends State<Loading> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: kPrimaryColor,
//         body: Center(
//           child: SpinKitWanderingCubes(
//             color: Colors.white,
//             size: 80.0,
//           ),
//         ));
//   }
// }
