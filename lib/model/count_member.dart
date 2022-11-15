class CountMember {
  final int id;
  final String name;
  final int lastCount;
  final int flyAwayCount;
  final int doubleFlyAwayCount;
  final int countGroupId;

  CountMember({
    required this.id,
    required this.name,
    required this.lastCount,
    required this.flyAwayCount,
    required this.doubleFlyAwayCount,
    required this.countGroupId,
  });

  CountMember.fromLocalStorage(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        lastCount = json['last_count'],
        flyAwayCount = json['fly_away_count'],
        doubleFlyAwayCount = json['double_fly_away_count'],
        countGroupId = json['count_group_id'];
}
