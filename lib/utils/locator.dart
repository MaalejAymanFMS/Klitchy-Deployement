import 'package:get_it/get_it.dart';

import '../viewmodels/table_order_interactor.dart';
import '../viewmodels/table_order_vm.dart';

final getIt = GetIt.I;

void setupLocator() {
  getIt.registerSingleton<TableOrderInteractor>(TablOrderPageState());
}