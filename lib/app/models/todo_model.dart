// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
    TodoModel({
        this.id,
        this.userId,
        this.description,
        this.completedAt,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int userId;
    String description;
    dynamic completedAt;
    DateTime createdAt;
    DateTime updatedAt;

    TodoModel copyWith({
        int id,
        int userId,
        String description,
        dynamic completedAt,
        DateTime createdAt,
        DateTime updatedAt,
    }) => 
        TodoModel(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            description: description ?? this.description,
            completedAt: completedAt ?? this.completedAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        description: json["description"] == null ? null : json["description"],
        completedAt: json["completed_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "description": description == null ? null : description,
        "completed_at": completedAt,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
