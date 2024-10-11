class Banner {
  String image;
  String category;
  Banner({
    required this.image,
    required this.category,
  });
  factory Banner.empty() => Banner(image: "", category: "");
}