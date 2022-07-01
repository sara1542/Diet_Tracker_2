class meal {
  String lastFetched = "";
  String lunch, breakfast, dinner, snacks, id;
  meal(this.id, this.breakfast, this.lunch, this.dinner, this.snacks,
      this.lastFetched);
  factory meal.fromJson(dynamic json) {
    return meal(json["id"], json["breakfast"], json["lunch"], json["dinner"],
        json["snacks"], json["lastFetched"]);
  }
}
