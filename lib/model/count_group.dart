class CountGroup {
  final String id;
  final int type;
  final int lastRate;
  final int flyAwayRate;

  CountGroup(this.id, this.type, this.lastRate, this.flyAwayRate);
  CountGroup.fromLocalStorage(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        lastRate = json['last_rate'],
        flyAwayRate = json['fly_away_rate'];

  Map<String, dynamic> toLocalStorage() {
    return {
      'id': id,
      'type': type,
      'last_rate': lastRate,
      'fly_away_rate': flyAwayRate,
    };
  }
}

//
