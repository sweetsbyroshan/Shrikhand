import 'package:flutter/material.dart';

class ShrikhandModal extends StatefulWidget {
  final Widget child, overlay;
  ShrikhandModal({@required this.child, @required this.overlay});
  @override
  _ShrikhandModalState createState() => _ShrikhandModalState();
}

class _ShrikhandModalState extends State<ShrikhandModal> {
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;
  double height = 0;
  @override
  Widget build(BuildContext context) {
    double limit = MediaQuery.of(context).size.height * .5;
    return WillPopScope(
      onWillPop: () async {
        if (height == limit) {
          setState(() {
            height = 0;
          });
          return false;
        } else
          return true;
      },
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                height = 0;
              });
            },
            onVerticalDragStart: (dragDetails) {
              startVerticalDragDetails = dragDetails;
            },
            onVerticalDragUpdate: (dragDetails) {
              updateVerticalDragDetails = dragDetails;
              double dy = updateVerticalDragDetails.globalPosition.dy -
                  startVerticalDragDetails.globalPosition.dy;

              setState(() {
                if (-height != limit && height < limit)
                  height = height + (dy * .025);
                else
                  height = limit;
              });
              //use dy
            },
            onVerticalDragEnd: (endDetails) {
              if (height < limit) {
                setState(() {
                  height = 0;
                });
              }
            },
            child: Container(
              height: limit * 2,
              child: widget.child,
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            constraints: BoxConstraints(maxHeight: limit),
            height: height,
            child: widget.overlay,
            width: MediaQuery.of(context).size.width,
            color: Color(0x9A000000),
          ),
        ],
      ),
    );
  }
}
