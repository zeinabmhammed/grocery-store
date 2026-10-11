class SliderModel {
  final int id;
  final String img;
  final String? link;

  const SliderModel({
    required this.id,
    required this.img,
    this.link,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json['id'],
    img: json['img'] ?? '',
    link: json['url_l'],
  );

}
