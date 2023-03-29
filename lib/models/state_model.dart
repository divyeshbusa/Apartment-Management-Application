class StateModel {
  late int StateID1;
  late String StateName1;

  int get StateID => StateID1;

  set StateID(int StateID) {
    StateID1 = StateID;
  }

  String get StateName => StateName1;

  set StateName(String StateName) {
    StateName1 = StateName;
  }

  StateModel({
    required this.StateID1,
    required this.StateName1,
  });
}
