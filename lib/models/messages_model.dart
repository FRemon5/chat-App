class MessagesModel {
  final String message;
  final String id;
  final String name;
  MessagesModel(this.message, this.id, this.name);

  factory MessagesModel.fromJson(json) {
    return MessagesModel(json['message'], json['id'], json['name']);
  }
}
