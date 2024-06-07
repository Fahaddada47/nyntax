class VehicleModel {
  String? status;
  List<Data>? data;
  String? message;

  VehicleModel({this.status, this.data, this.message});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? make;
  String? model;
  int? year;
  String? type;
  int? seats;
  int? bags;
  List<String>? features;
  Rates? rates;
  String? imageURL;

  Data(
      {this.id,
        this.make,
        this.model,
        this.year,
        this.type,
        this.seats,
        this.bags,
        this.features,
        this.rates,
        this.imageURL});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    make = json['make'];
    model = json['model'];
    year = json['year'];
    type = json['type'];
    seats = json['seats'];
    bags = json['bags'];
    features = json['features'].cast<String>();
    rates = json['rates'] != null ? new Rates.fromJson(json['rates']) : null;
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['type'] = this.type;
    data['seats'] = this.seats;
    data['bags'] = this.bags;
    data['features'] = this.features;
    if (this.rates != null) {
      data['rates'] = this.rates!.toJson();
    }
    data['imageURL'] = this.imageURL;
    return data;
  }
}

class Rates {
  int? hourly;
  int? daily;
  int? weekly;

  Rates({this.hourly, this.daily, this.weekly});

  Rates.fromJson(Map<String, dynamic> json) {
    hourly = json['hourly'];
    daily = json['daily'];
    weekly = json['weekly'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hourly'] = this.hourly;
    data['daily'] = this.daily;
    data['weekly'] = this.weekly;
    return data;
  }
}
