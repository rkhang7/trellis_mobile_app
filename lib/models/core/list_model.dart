import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:trellis_mobile_app/models/core/card_model.dart';

class ListModel {
  String id;
  String name;
  List<CardModel> listCard;
  ListModel({
    required this.id,
    required this.name,
    required this.listCard,
  });

  ListModel copyWith({
    String? id,
    String? name,
    List<CardModel>? listCard,
  }) {
    return ListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      listCard: listCard ?? this.listCard,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'listCard': listCard.map((x) => x.toMap()).toList(),
    };
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      listCard: List<CardModel>.from(
          map['listCard']?.map((x) => CardModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModel.fromJson(String source) =>
      ListModel.fromMap(json.decode(source));

  @override
  String toString() => 'ListModel(id: $id, name: $name, listCard: $listCard)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListModel &&
        other.id == id &&
        other.name == name &&
        listEquals(other.listCard, listCard);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ listCard.hashCode;
}
