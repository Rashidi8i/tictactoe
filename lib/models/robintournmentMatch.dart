// ignore_for_file: file_names, non_constanm_identifier_names, non_constant_identifier_names

class RobinTournmentMatchModel {
  int? m_id;
  String? playerList;
  String? matchPlayed;
  String? winner;
  String? winnerScore;
  int? tournment_id;

  RobinTournmentMatchModel({
    this.m_id,
    this.playerList,
    this.matchPlayed,
    this.winner,
    this.winnerScore,
    this.tournment_id,
  });

  factory RobinTournmentMatchModel.fromMap(Map<String, dynamic> map) {
    return RobinTournmentMatchModel(
        m_id: map['m_id'],
        playerList: map['playerList'],
        matchPlayed: map['matchPlayed'],
        winner: map['winner'],
        winnerScore: map['winnerScore'],
        tournment_id: map['tournment_id']);
  }

  Map<String, Object?> toMap() {
    return {
      'm_id': m_id,
      'playerList': playerList,
      'matchPlayed': matchPlayed,
      'winner': winner,
      'winnerScore': winnerScore,
      'tournment_id': tournment_id
    };
  }
}
