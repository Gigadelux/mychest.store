class Event{
  String banner;
  List<String> productCategories;
  double offer;
  Event({
    required this.banner,
    required this.productCategories,
    required this.offer
  });
  factory Event.empty() => Event(banner: "", productCategories: [], offer: 0.0);
  bool isEmpty() => banner.isEmpty & productCategories.isEmpty & (offer == 0);
  factory Event.fromApi() => Event.empty();
}