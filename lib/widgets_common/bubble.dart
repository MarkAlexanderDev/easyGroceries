import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodz/style/colors.dart';

class Bubble extends StatelessWidget {
  final Widget content;

  Bubble({@required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipPath(
          clipper: _TriangleClipper(),
          child: Container(
            height: 10,
            width: 20,
            color: mainColor,
          ),
        ),
        Container(
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(padding: const EdgeInsets.all(8.0), child: content)),
      ],
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_TriangleClipper oldClipper) => false;
}
