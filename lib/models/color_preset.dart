import 'dart:convert';

import 'package:flutter/material.dart';

class ColorPreset {
  final String id;
  final String name;
  final Color backgroundColor;
  final Color textColor;

  const ColorPreset({
    required this.id,
    required this.name,
    required this.backgroundColor,
    required this.textColor,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'bg': backgroundColor.toARGB32(),
        'text': textColor.toARGB32(),
      };

  factory ColorPreset.fromJson(Map<String, dynamic> json) => ColorPreset(
        id: json['id'] as String,
        name: json['name'] as String,
        backgroundColor: Color(json['bg'] as int),
        textColor: Color(json['text'] as int),
      );

  String encode() => jsonEncode(toJson());

  factory ColorPreset.decode(String source) =>
      ColorPreset.fromJson(jsonDecode(source) as Map<String, dynamic>);
}
