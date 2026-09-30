import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class FitnessDataContext {
  Database? _exercisesDb;
  Database? _mealsDb;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    _exercisesDb = await _openAssetDb(
      dir: dir,
      assetPath: 'assets/images/exercises.db',
      dbName: 'exercises.db',
    );

    _mealsDb = await _openAssetDb(
      dir: dir,
      assetPath: 'assets/images/meals.db',
      dbName: 'meals.db',
    );
  }

  Future<Database> _openAssetDb({
    required Directory dir,
    required String assetPath,
    required String dbName,
  }) async {
    final dbPath = p.join(dir.path, dbName);
    final file = File(dbPath);
    if (!await file.exists()) {
      final bytes = await rootBundle.load(assetPath);
      final buffer = bytes.buffer;
      await file.writeAsBytes(
        buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      );
    }
    return openDatabase(dbPath, readOnly: true);
  }

  Future<String> buildContextSummary() async {
    final buffer = StringBuffer();

    // --- Exercises summary ---
    if (_exercisesDb != null) {
      final muscleGroups = await _query(
        _exercisesDb!,
        'SELECT name FROM muscle_group ORDER BY name',
      );
      final difficulties = await _query(
        _exercisesDb!,
        'SELECT name FROM difficulty_level ORDER BY rank',
      );
      final equipment = await _query(
        _exercisesDb!,
        'SELECT name FROM equipment ORDER BY name',
      );
      final exerciseCount = await _count(_exercisesDb!, 'exercise');
      final topExercises = await _query(
        _exercisesDb!,
        'SELECT name FROM exercise ORDER BY popularity DESC LIMIT 10',
      );

      buffer.writeln('=== EXERCISE DATABASE ($exerciseCount exercises) ===');
      buffer.writeln('Muscle Groups: ${muscleGroups.join(", ")}');
      buffer.writeln('Difficulty Levels: ${difficulties.join(", ")}');
      buffer.writeln('Equipment: ${equipment.join(", ")}');
      buffer.writeln('Top Exercises: ${topExercises.join(", ")}');
      buffer.writeln();
    }

    // --- Meals summary ---
    if (_mealsDb != null) {
      final categories = await _query(
        _mealsDb!,
        'SELECT name FROM meal_category ORDER BY name',
      );
      final mealCount = await _count(_mealsDb!, 'meal');
      final topMeals = await _query(
        _mealsDb!,
        'SELECT name FROM meal ORDER BY popularity DESC LIMIT 10',
      );
      final sampleMeals = await _query(
        _mealsDb!,
        'SELECT name, kcal, protein_g, carbs_g, fat_g FROM meal '
        'WHERE protein_g IS NOT NULL AND protein_g > 0 '
        'ORDER BY protein_g DESC LIMIT 5',
      );

      buffer.writeln('=== MEAL DATABASE ($mealCount meals) ===');
      buffer.writeln('Categories: ${categories.join(", ")}');
      buffer.writeln('Top Meals: ${topMeals.join(", ")}');
      if (sampleMeals.isNotEmpty) {
        buffer.writeln('High-Protein Meals (name | kcal | protein | carbs | fat):');
        for (final m in sampleMeals) {
          buffer.writeln('  - $m');
        }
      }
    }

    return buffer.toString();
  }

  Future<List<String>> _query(Database db, String sql) async {
    try {
      final rows = await db.rawQuery(sql);
      return rows.map((r) => r.values.first?.toString() ?? '').toList();
    } catch (e) {
      log('DB query error: $e');
      return [];
    }
  }

  Future<int> _count(Database db, String table) async {
    try {
      final result = await db.rawQuery('SELECT COUNT(*) as c FROM $table');
      return result.first['c'] as int? ?? 0;
    } catch (e) {
      return 0;
    }
  }

  void close() {
    _exercisesDb?.close();
    _mealsDb?.close();
  }
}
