import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  Future<Database> createDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        mdp TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE restaurant (
        osm_id INTEGER PRIMARY KEY AUTOINCREMENT,
        longitude INTEGER NOT NULL,
        latitude INTEGER NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        operator TEXT,
        brand TEXT,
        wheelchair BOOLEAN,
        vegetarian BOOLEAN,
        vegan BOOLEAN;
        delivery BOOLEAN,
        takeaway BOOLEAN,
        capacity TEXT,
        drive_through BOOLEAN,
        phone TEXT,
        website TEXT,
        facebook TEXT,
        region TEXT NOT NULL,
        department TEXT NOT NULL,
        commune TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE favori (
        user_id INTEGER,
        osm_id INTEGER,
        PRIMARY KEY(user_id, osm_id),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (osm_id) REFERENCES restaurant (osm_id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE cuisine (
        cuisine_id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE possede (
        cuisine_id INTEGER,
        osm_id INTEGER,
        PRIMARY KEY(cuisine_id, osm_id),
        FOREIGN KEY (cuisine_id) REFERENCES cuisine (cuisine_id) ON DELETE CASCADE,
        FOREIGN KEY (osm_id) REFERENCES restaurant (osm_id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE avis (
        id_avis INTEGER,
        osm_Id INTEGER,
        user_id INTEGER,
        note INTEGER NOT NULL,
        content TEXT NOT NULL,
        PRIMARY KEY(id_avis,osm_Id,user_id),
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
        FOREIGN KEY (osm_id) REFERENCES restaurant (osm_id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE photo (
        id_avis INTEGER,
        path TEXT NOT NULL,
        PRIMARY KEY(id_avis,path),
        FOREIGN KEY (id_avis) REFERENCES avis (id_avis) ON DELETE CASCADE
      )
    ''');
  }
}