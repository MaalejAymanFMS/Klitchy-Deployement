import '../models/orders.dart';

abstract class RightDrawerInterractor {
  Future<OrdersP1> retrieveTableOrderPart1(Map<String, dynamic> params);
  Future<OrdersP2> retrieveTableOrderPart2(String id);
  Future<dynamic> addOrder(Map<String, dynamic> body);
}