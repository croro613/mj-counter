import 'package:mj_counter/model/count_group.dart';

import 'count_member.dart';

class GroupInformation {
  final CountGroup countGroup;
  final List<CountMember> countMembers;
  GroupInformation(this.countGroup, this.countMembers);
}
