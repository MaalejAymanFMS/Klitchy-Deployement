import '../models/tables.dart';

abstract class StartPageInterractor {
  Future<Table> addTable(Map<String, dynamic> body);
}