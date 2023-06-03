import 'dart:ffi';
import 'package:contact_app/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DBHelper{

  static const String createTableContact='''
   create table $tableContact(
   $tableContactId integer primary key,
   $tableContactName text,
   $tableContactNumber text,
   $tableContactEmail text,
   $tableContactadress text,
   $tableContactdob text,
   $tableContactgender text,
   $tableContactimage text,
   $tableContactfavourite  integer
   )''';

  static Future<Database> open() async{

    final rootPath = await getDatabasesPath();
    final dbPath = join(rootPath,'contact.db');

    return openDatabase(dbPath,version: 1,onCreate: (db,vesion){

      db.execute(createTableContact);

    });

  }

  static Future<int> insertContact(ContactModel contactModel) async{

    final db = await open();
    return db.insert(tableContact, contactModel.toMap());

  }
  static Future<List<ContactModel>> getAllContacts() async{
    final db = await open();
    final mapList = await db.query(tableContact);
    return List.generate(mapList.length, (index) => ContactModel.fromMap(mapList[index]));
  }

  static Future<ContactModel> getContactById(int id ) async{

    final db = await open();
    
    final mapList = await db.query(tableContact,where: '$tableContactId = ?', whereArgs: [id]);
  return ContactModel.fromMap(mapList.first);
  }

   static Future<int> updateFavorite(int id, int value)async{

    final db = await  open();
    return db.update(tableContact,{tableContactfavourite : value},

     where: '$tableContactId = ?' ,whereArgs: [id]);
   }

}