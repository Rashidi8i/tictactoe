// ignore_for_file: file_names, non_constanm_identifier_names, non_constant_identifier_names

class TournmentMatchModel {
  int? m_id;
  String? playerList;
  String? matchPlayed;
  String? winner;
  int? tournment_id;

  TournmentMatchModel({
    this.m_id,
    this.playerList,
    this.matchPlayed,
    this.winner,
    this.tournment_id,
  });

  factory TournmentMatchModel.fromMap(Map<String, dynamic> map) {
    return TournmentMatchModel(
        m_id: map['m_id'],
        playerList: map['playerList'],
        matchPlayed: map['matchPlayed'],
        winner: map['winner'],
        tournment_id: map['tournment_id']);
  }

  Map<String, Object?> toMap() {
    return {
      'm_id': m_id,
      'playerList': playerList,
      'matchPlayed': matchPlayed,
      'winner': winner,
      'tournment_id': tournment_id
    };
  }
}
