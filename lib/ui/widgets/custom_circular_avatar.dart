import 'dart:convert';

import 'package:flutter/material.dart';

class CustomCircularAvatar extends StatelessWidget {
  final String _imageData;
  final Characters _letter;
  final double _radius;
  final Color backgroundColor;
  final TextStyle theme;

  const CustomCircularAvatar(this._imageData, this._radius, this._letter,
      {this.backgroundColor = Colors.amber,
      this.theme = const TextStyle(fontSize: 15),
      super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: _radius,
      backgroundColor: backgroundColor,
      backgroundImage:
          _imageData.isNotEmpty ? MemoryImage(base64Decode(_imageData)) : null,
      child: Text(
        _letter.first.toUpperCase(),
        style: theme,
      ),
    );
  }
}
