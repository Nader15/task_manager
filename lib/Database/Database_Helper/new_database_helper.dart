import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task_model.dart';

class TaskDatabaseHelper {
  static final TaskDatabaseHelper _instance = TaskDatabaseHelper._internal();

  factory TaskDatabaseHelper() => _instance;

  TaskDatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'tasks.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT,
            date TEXT,
            time TEXT,
            color INTEGER, 
            status TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertTask(TaskModel task) async {
    final db = await database;
    return await db.insert('tasks', task.toJson());
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (index) {
      // Convert the colorValue integer to Color object
      final int colorValue = maps[index]['color'];
      final Color color = Color(colorValue);

      // Pass the color object to the TaskModel constructor
      return TaskModel.fromJson(maps[index], color: color);
    });
  }

  // Method to get tasks with the same date as the selected date
  Future<List<TaskModel>> getTasksByDate(DateTime selectedDate) async {
    final db = await database;
    final tasks = await db.query(
      'tasks',
      where: 'date = ?',
      whereArgs: [selectedDate.toString()],
    );
    return tasks.map((taskMap) => TaskModel.fromJson(taskMap, color: Color(taskMap['color'] as int))).toList();
  }


  Future<int> updateTask(TaskModel task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toJson(excludeId: true), // Exclude the id field when updating
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
