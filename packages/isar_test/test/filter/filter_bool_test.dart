import 'package:isar/isar.dart';
import 'package:test/test.dart';

import '../util/common.dart';
import '../util/sync_async_helper.dart';

part 'filter_bool_test.g.dart';

@Collection()
class BoolModel {
  BoolModel(this.field);

  Id? id;

  bool? field;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    return other is BoolModel && other.id == id && other.field == field;
  }
}

void main() {
  group('Bool filter', () {
    late Isar isar;
    late IsarCollection<BoolModel> col;

    late BoolModel objNull;
    late BoolModel objFalse;
    late BoolModel objTrue;
    late BoolModel objFalse2;

    setUp(() async {
      isar = await openTempIsar([BoolModelSchema]);
      col = isar.boolModels;

      objNull = BoolModel(null);
      objFalse = BoolModel(false);
      objTrue = BoolModel(true);
      objFalse2 = BoolModel(false);

      await isar.writeTxn(() async {
        await col.putAll([objNull, objFalse, objTrue, objFalse2]);
      });
    });

    tearDown(() => isar.close(deleteFromDisk: true));

    isarTest('.equalTo()', () async {
      await qEqual(col.filter().fieldEqualTo(true).tFindAll(), [objTrue]);
      await qEqualSet(
        col.filter().fieldEqualTo(false).tFindAll(),
        [objFalse, objFalse2],
      );
      await qEqual(col.filter().fieldEqualTo(null).tFindAll(), [objNull]);
    });

    isarTest('.isNull()', () async {
      await qEqualSet(col.where().filter().fieldIsNull().tFindAll(), [objNull]);
    });
  });
}
