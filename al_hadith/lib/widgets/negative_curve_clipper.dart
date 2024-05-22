import 'package:flutter/material.dart';

class DownwardCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);

   
    path.quadraticBezierTo(
      size.width *0.5, 
      size.height - 40, 
     size.width , 
      size.height, 
    );

    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
