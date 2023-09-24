import '../models/tables.dart';

abstract class StartPageInterractor {
  Future<AddTable> addTable(Map<String, dynamic> body);
  Future<ListTables> retrieveListOfTables(Map<String, dynamic> params);
  Future<DeleteTable> deleteTable(String id);
}