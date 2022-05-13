class inbody {
  double height, weight, BMI, PBF, PBW;
  inbody(this.BMI, this.PBF, this.PBW, this.height, this.weight);
  factory inbody.fromJson(dynamic json) {
    return inbody(json["height"] as double, json["weight"] as double,
        json["BMI"] as double, json["PBF"] as double, json["PBW"] as double
        //json["age"] as int
        );
  }
}
