class Measure{
  String measureQuantity;
  Measure({required this.measureQuantity});

  Map<String,dynamic> toJson () => {
    "measureQuantity" : measureQuantity
  };
}