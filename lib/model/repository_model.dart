
import 'dart:convert';

List<RepositoryModel> repositoryModelFromJson(String str) => List<RepositoryModel>.from(json.decode(str).map((x) => RepositoryModel.fromJson(x)));

String repositoryModelToJson(List<RepositoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RepositoryModel {
  int? id;
  String? nodeId;
  String? name;
  String? fullName;
  bool? private;
  String? htmlUrl;
  String? description;
  String? url;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? cloneUrl;
  String? visibility;
  String? language;
  String? stargazerscount;
  String? forks;
  String? watcherscount;

  RepositoryModel({
    this.id,
    this.nodeId,
    this.name,
    this.fullName,
    this.private,
    this.htmlUrl,
    this.description,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.cloneUrl,
    this.visibility,
    this.language

  });

  factory RepositoryModel.fromJson(Map<String, dynamic> json) => RepositoryModel(
    id: json["id"],
    nodeId: json["node_id"],
    name: json["name"],
    fullName: json["full_name"],
    private: json["private"],
    htmlUrl: json["html_url"],
    description: json["description"],
    url: json["url"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    cloneUrl: json["clone_url"],
    visibility: json["visibility"],
    language : json["language"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "node_id": nodeId,
    "name": name,
    "full_name": fullName,
    "private": private,
    "html_url": htmlUrl,
    "description": description,
    "url": url,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "clone_url": cloneUrl,
    "visibility": visibility,
    "language" : language
  };
}