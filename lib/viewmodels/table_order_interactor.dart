import '../models/categories.dart';

abstract class TableOrderInteractor {
  Future<Categories> retrieveCategories();
}