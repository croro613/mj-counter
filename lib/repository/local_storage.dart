import 'dart:convert';

import 'package:mj_counter/model/count_group.dart';
import 'package:mj_counter/model/count_member.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/display_group.dart';

class LocalStorage {
  Future<Database> get database async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        db.execute("CREATE TABLE count_group(id TEXT PRIMARY KEY, json TEXT)");
        db.execute(
            'CREATE TABLE count_member(id TEXT, json TEXT, count_group_id, FOREIGN KEY(count_group_id) REFERENCES count_group(id))');
      },
      version: 1,
    );
    return await database;
  }

  Future<List<GroupInformation>> fetchGroupInformation() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT count_group.json as json,group_concat(count_member.json) AS conc FROM count_member INNER JOIN count_group ON count_group.id = count_member.count_group_id GROUP BY count_group.id ');
    return maps.map((aho) {
      final countMemberJsons = aho['conc'] as String;
      final List<CountMember> countMembers = countMemberJsons
          .split(',')
          .map((baka) => CountMember.fromLocalStorage(jsonDecode(baka)))
          .toList();
      final CountGroup countGroup =
          CountGroup.fromLocalStorage(jsonDecode(aho['json']));
      return GroupInformation(countGroup, countMembers);
    }).toList();
  }

  Future<void> insertGroup(CountGroup countGroup) async {
    final Database db = await database;
    await db.insert(
      'count_group',
      {'id': countGroup.id, 'json': jsonEncode(countGroup.toLocalStorage())},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMember(CountMember countMember) async {
    final Database db = await database;
    await db.insert(
      'count_member',
      {'id': countMember.id, 'json': jsonEncode(countMember.toLocalStorage())},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateGroup(CountGroup countGroup) async {
    final Database db = await database;
    final values = <String, dynamic>{
      'id': countGroup.id,
      'json': jsonEncode(countGroup.toLocalStorage()),
    };
    await db
        .update("count_group", values, where: "id", whereArgs: [countGroup.id]);
  }

  Future<void> updateMember(CountMember member) async {
    final Database db = await database;
    final values = <String, dynamic>{
      'id': member.id,
      'json': jsonEncode(member.toLocalStorage())
    };
    await db
        .update("count_member", values, where: "id", whereArgs: [member.id]);
  }

  Future<void> deleteMember(CountMember member) async {
    final db = await database;
    await db.delete(
      'count_member',
      where: "id = ?",
      whereArgs: [member.id],
    );
  }

  Future<void> deleteCountGroup(CountGroup countGroup) async {
    final db = await database;
    await db.delete(
      'count_group',
      where: "id = ?",
      whereArgs: [countGroup.id],
    );
  }
}
