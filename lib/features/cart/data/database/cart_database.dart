import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'tables/cart_items_table.dart';
import 'tables/products_table.dart';

part 'cart_database.g.dart';

@DriftDatabase(tables: [CartItems, Products])
class CartDatabase extends _$CartDatabase {
  CartDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'cart_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}

