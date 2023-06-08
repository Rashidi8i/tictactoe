// ignore_for_file: file_names, non_constant_identifier_names

class TournmentModel {
  int? t_id;
  String? playerList;
  String? tournamentType;
  int? playerCount;

  TournmentModel({
    this.t_id,
    this.playerList,
    this.tournamentType,
    this.playerCount,
  });

  factory TournmentModel.fromMap(Map<String, dynamic> map) {
    return TournmentModel(
        t_id: map['t_id'],
        playerList: map['playerList'],
        tournamentType: map['tournamentType'],
        playerCount: map['playerCount']);
  }

  Map<String, Object?> toMap() {
    return {
      't_id': t_id,
      'playerList': playerList,
      'tournamentType': tournamentType,
      'playerCount': playerCount
    };
  }
}
