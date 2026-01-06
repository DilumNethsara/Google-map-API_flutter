import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:project2/constant.dart';

class MongoDatabase {
  static var db, collection;
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(await status);
    collection = db.collection(COLLECTION);
    //print(await collection.find().toList());
  }

  static Future<Map<String, dynamic>?> fetchByProfileId(String id) async {
    try {
      final result = await collection.findOne(
        where.eq('profile_id', id)..sortBy('timestamp', descending: true),
      );
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
