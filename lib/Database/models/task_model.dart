
import 'package:flutter/material.dart';

class TaskModel {
  int? id;
  String? title;
  String? description;
  String? date;
  String? time;
  Color? color;
  int? colorValue; // Store the color as an integer representing ARGB value
  String? status;
  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.time,
    required Color color, // Use Color type here
    this.status,
  }) : colorValue = color.value; // Convert Color to integer value

  TaskModel.fromJson(Map<String, dynamic> json, {Color? color}) {
    id = json["id"];
    title = json["title"];
    description = json["description"];
    date = json["date"];
    time = json["time"];
    colorValue = color != null ? color.value : json["color"];
    status = json["status"];
  }

  Map<String, dynamic> toJson({bool excludeId = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!excludeId) data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['time'] = time;
    data['color'] = colorValue;
    data['status'] = status;

    return data;
  }

  Color getColor() {
    return Color(colorValue ?? 0xFFFFFFFF); // Default to white if the value is null
  }
}
