import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mj_counter/model/display_group.dart';
import 'package:mj_counter/repository/local_storage.dart';
import 'package:uuid/uuid.dart';

import '../model/count_group.dart';

class CountNotifier extends StateNotifier<Map<String, GroupInformation>> {
  final Ref ref;
  CountNotifier(this.ref)
      : super({'0': GroupInformation(CountGroup('0', 3, 0, 0), [])});
  Future<String> initialize(List<GroupInformation> groupInformation) async {
    if (groupInformation.isEmpty) {
      final id = const Uuid().v4();
      final countGroup = CountGroup(id, 3, 1000, 4000);
      await LocalStorage().insertGroup(countGroup);
      state = {countGroup.id: GroupInformation(countGroup, [])};
    } else {
      state = {for (var item in groupInformation) item.countGroup.id: item};
    }
    return state.keys.first;
  }

  void addCount(String user, int count) {}
}

final countProvider =
    StateNotifierProvider<CountNotifier, Map<String, GroupInformation>>((ref) {
  return CountNotifier(ref);
});

final groupInformationProvider = FutureProvider<List<GroupInformation>>(
    (ref) async => await LocalStorage().fetchGroupInformation());

final selectedKeyProvider = StateProvider<String>((ref) => '0');
