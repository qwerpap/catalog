import 'package:drift/drift.dart';

class Products extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  RealColumn get price => real()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  TextColumn get image => text()();
  RealColumn get ratingRate => real().nullable()();
  IntColumn get ratingCount => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

