import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String table = 'contacts';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'contacts.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newVersion) async {
      await db.execute(
          'CREATE TABLE $table(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, image TEXT)');
    });
  }

  Future<Contact> save(Contact contact) async {
    Database database = await db;
    contact.id = await database.insert(table, contact.toMap());
    return contact;
  }

  Future<Contact> getDetail(int id) async {
    Database database = await db;
    List<Map> maps = await database.query(table,
        columns: ['id', 'name', 'email', 'phone', 'image'],
        where: 'id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Contact contact) async {
    Database database = await db;
    return await database.update(table, contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<List> getAll() async {
    Database database = await db;
    List listMap = await database.rawQuery('SELECT * FROM $table');
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }

    return listContact;
  }

  Future<int> getLength() async {
    Database database = await db;
    return Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future close() async {
    Database database = await db;
    await database.close();
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String image;

  Contact();

  Contact.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    email = map['email'];
    phone = map['phone'];
    image = map['image'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, image: $image)";
  }
}
