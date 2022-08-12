import 'package:isar/isar.dart';
import 'package:test/test.dart';

import '../util/common.dart';
import '../util/sync_async_helper.dart';

part 'filter_string_list_test.g.dart';

@Collection()
class StringModel {
  StringModel();

  StringModel.init(this.list);

  Id? id;

  List<String>? list;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is StringModel && listEquals(list, other.list);
}

void main() {
  group('String filter', () {
    late Isar isar;
    late IsarCollection<StringModel> col;
  });

  // TODO
}
