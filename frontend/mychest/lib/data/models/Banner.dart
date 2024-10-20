class BannerOffer {
  String image;
  String category;
  BannerOffer({
    required this.image,
    required this.category,
  });
  factory BannerOffer.empty() => BannerOffer(image: "", category: "");
  bool isEmpty() => (category.isEmpty && image.isEmpty);
  String get getImage => image;
  set setImage(String value) {
    image = value;
  }

  String get setCategory => category;
  set setCategory(String value) {
    category = value;
  }
}