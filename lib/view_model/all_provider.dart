import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mj_counter/model/display_group.dart';
import 'package:mj_counter/repository/local_storage.dart';

import '../model/count_group.dart';

class CountNotifier extends StateNotifier<GroupInformation> {
  final Ref ref;
  CountNotifier(this.ref)
      : super(GroupInformation(CountGroup(0, 'type', 0, 0), []));
  void initialize(GroupInformation groupInformation) {
    state = groupInformation;
  }

  void addCount(String user, int count) {}
}

final countProvider =
    StateNotifierProvider<CountNotifier, GroupInformation>((ref) {
  return CountNotifier(ref);
});

final groupInformationProvider = FutureProvider<GroupInformation>(
    (ref) async => await LocalStorage().fetchGroupInformation());
