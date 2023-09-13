class ModelStateList {
  bool? status;
  String? message;
  List<CountryState>? state;

  ModelStateList({this.status, this.message, this.state});

  ModelStateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['state'] != null) {
      state = <CountryState>[];
      json['state'].forEach((v) {
        state!.add(CountryState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (state != null) {
      data['state'] = state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryState {
  int? stateId;
  String? stateName;
  int? countryId;

  CountryState({this.stateId, this.stateName, this.countryId});

  CountryState.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    data['country_id'] = countryId;
    return data;
  }
}
