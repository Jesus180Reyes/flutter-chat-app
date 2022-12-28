// To parse this JSON data, do
//
//     final messages = messagesFromJson(jsonString);

import 'dart:convert';

Messages messagesFromJson(String str) => Messages.fromJson(json.decode(str));

String messagesToJson(Messages data) => json.encode(data.toJson());

class Messages {
  Messages({
    required this.message,
    required this.by,
    required this.createdAt,
  });

  final String message;
  final String by;
  final String createdAt;

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        message: json["message"],
        by: json["by"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "by": by,
        "createdAt": createdAt,
      };
}
