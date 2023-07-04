
import 'package:assignment/database/employee_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EmployeeDatabase {
  static final EmployeeDatabase instance = EmployeeDatabase._init();

  static Database? _database;

  EmployeeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('employees.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
      CREATE TABLE $tableEmployee ( 
        ${EmpFields.id} $idType, 
        ${EmpFields.role} $textType,
        ${EmpFields.name} $textType,
        ${EmpFields.fromDate} $textType,
        ${EmpFields.toDate} $textType
        )
''');
  }

  Future<Employee> create(Employee emp) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableEmployee, emp.toJson());
    return emp.copy(id: id);
  }

  Future<Employee> readTask(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEmployee,
      columns: EmpFields.values,
      where: '${EmpFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Employee.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }


  Future<List<Employee>> getEmpList() async {
    final db = await instance.database;

    const orderBy = '${EmpFields.fromDate} DESC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableEmployee, orderBy: orderBy);

    return result.map((json) => Employee.fromJson(json)).toList();
  }

  Future<int> update(Employee task) async {
    final db = await instance.database;

    return db.update(
      tableEmployee,
      task.toJson(),
      where: '${EmpFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEmployee,
      where: '${EmpFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
