import 'package:drift/drift.dart';

class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get productId => integer()();
  IntColumn get quantity => integer()();
}

