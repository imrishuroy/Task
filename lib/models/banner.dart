import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeBanner extends Equatable {
  final String? image;
  final int? id;
  final String? url;

  const HomeBanner({
    this.image,
    this.id,
    this.url,
  });

  HomeBanner copyWith({
    String? image,
    int? id,
    String? url,
  }) {
    return HomeBanner(
      image: image ?? this.image,
      id: id ?? this.id,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'banner_image': image,
      'banner_id': id,
      'banner_url': url,
    };
  }

  factory HomeBanner.fromMap(Map<String, dynamic> map) {
    return HomeBanner(
      image: map['banner_image'],
      id: map['banner_id'],
      url: map['banner_url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeBanner.fromJson(String source) =>
      HomeBanner.fromMap(json.decode(source));

  @override
  String toString() => 'Banner(image: $image, id: $id, url: $url)';

  @override
  List<Object?> get props => [image, id, url];
}
