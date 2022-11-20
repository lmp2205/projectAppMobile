import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final double laisuat;
  final String name;
  final String cmnd;
  final String type;
  final String plate;
  final DateTime date;
  final double kyhan;


  final int phone;


  Product({
    this.id,
    required this.title,
    required this.name,
    required this.cmnd,
    required this.type,
    required this.plate,
    required this.date,
    required this.kyhan,

    required this.phone,
    required this.description,
    required this.price,
    required this.laisuat,
    required this.imageUrl,
  });

  get dateTime => null;


  // set isFavorite(bool newValue) {
  //   _isFavorite.value = newValue;
  // }

  // bool get isFavorite {
  //   return _isFavorite.value;
  // }

  // ValueNotifier<bool> get isFavoriteListenable {
  //   return _isFavorite;
  // }

  Product copyWith(
      {String? id,
      String? title,
      String? description,
      double? price,
      String? imageUrl,
      double? laisuat,
      String? name,
      String? cmnd,
      String? type,
      int? phone,
      String? plate,
      DateTime? date,
      double? kyhan,

      // int? enddate,
      bool? isFavorite}) {
    return Product(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      title: title ?? this.title,
      name: name ?? this.name,
      cmnd: cmnd ?? this.cmnd,
      plate: plate ?? this.plate,
      date: date ?? this.date,
      kyhan: kyhan ?? this.kyhan,

      type: type ?? this.type,
      // enddate: enddate ?? this.enddate,
      description: description ?? this.description,
      price: price ?? this.price,
      laisuat: laisuat ?? this.laisuat,
      imageUrl: imageUrl ?? this.imageUrl,
      // isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'name': name,
      'phone': phone,
      'cmnd': cmnd,
      'plate': plate,
      'date': date.toString(),
      'type': type,
      'kyhan': kyhan,

      // 'enddate': enddate,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'laisuat': laisuat,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product(
      phone: json['phone'],
      id: json['id'],
      name: json['name'],

      kyhan: json['kyhan'],

      plate: json['plate'],
      cmnd: json['cmnd'],
      date: DateTime.parse(json['date']) ,
      type: json['type'],
      // enddate: json['enddate'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      laisuat: json['laisuat'],
      imageUrl: json['imageUrl'],
    );
  }
}
