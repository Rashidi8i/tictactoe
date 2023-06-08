// ignore_for_file: depend_on_referenced_packages, unused_import, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tictactoe/models/tournmentModel.dart';
import 'package:tictactoe/models/tournmentmatchModel.dart';
import 'dart:io' as io;

import 'package:tictactoe/views/tournamentMaker/tournamentMaker.dart';

class DBHelper {
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'matchesData.db');
    var db = await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE tournament (t_id INTEGER PRIMARY KEY AUTOINCREMENT, playerList TEXT NOT NULL, tournamentType TEXT NOT NULL, playerCount INTEGER NOT NULL)",
    );
    await db.execute(
      "CREATE TABLE tournmentMatch (m_id INTEGER PRIMARY KEY AUTOINCREMENT,playerList TEXT NOT NULL, matchPlayed TEXT NOT NULL, tournment_id INTEGER NOT NULL, winner TEXT NOT NULL)",
    );
  }

  Future<TournmentModel> insert_tournment(TournmentModel tournmentModel) async {
    // delete(0);
    var dbClient = await db;

    await dbClient!.insert('tournament', tournmentModel.toMap());

    return tournmentModel;
  }

  Future<TournmentMatchModel> insert_tournment_match(
      TournmentMatchModel tournmentMatchModel) async {
    var dbClient = await db;
    await dbClient!.insert('tournmentMatch', tournmentMatchModel.toMap());
    return tournmentMatchModel;
  }

  Future<void> getTournmentData() async {
    var dbClient = await db;
    final List<Map<String, Object?>> result =
        await dbClient!.rawQuery('SELECT * FROM tournament');
    if (kDebugMode) {
      print(result);
    }
  }

  Future<List<TournmentMatchModel>> getMatchesData(int t_id) async {
    var dbClient = await db;
    final List<Map<String, Object?>> result = await dbClient!
        .rawQuery('SELECT * FROM tournmentMatch WHERE tournment_id = $t_id');
    if (kDebugMode) {
      print(result);
    }
    return result
        .map<TournmentMatchModel>((e) => TournmentMatchModel.fromMap(e))
        .toList();
  }

  Future<List<TournmentModel>> getLastTrnmnt() async {
    var dbClient = await db;
    final List<Map<String, Object?>> result = await dbClient!
        .rawQuery('SELECT * FROM tournament ORDER BY t_id DESC LIMIT 1');
    if (kDebugMode) {
      print(result);
    }
    return result
        .map<TournmentModel>((e) => TournmentModel.fromMap(e))
        .toList();
  }

  Future<int> updateMatch(int id, String winner, String matchPlayed) async {
    var dbClient = await db;
    return await dbClient!.update(
      'tournmentMatch',
      {
        'winner': winner,
        'matchPlayed': matchPlayed,
      },
      where: 'm_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('tournament', where: 't_id > ?', whereArgs: [id]);
  }

  Future<int> deletematch(int id) async {
    var dbClient = await db;
    return await dbClient!
        .delete('tournmentMatch', where: 'm_id > ?', whereArgs: [id]);
  }
}
