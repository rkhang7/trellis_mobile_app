import 'dart:convert';

class CardModel {
  String id;
  String name;
  String description;
  int position;
  CardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.position,
  });

  CardModel copyWith({
    String? id,
    String? name,
    String? description,
    int? position,
  }) {
    return CardModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      position: position ?? this.position,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'position': position,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      position: map['position']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) =>
      CardModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CardModel(id: $id, name: $name, description: $description, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CardModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.position == position;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        position.hashCode;
  }
}
