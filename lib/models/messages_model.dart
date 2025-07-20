class MessagesModel {
  final String message;
  final String id;
  
  MessagesModel(this.message, this.id);

  factory MessagesModel.fromJson(json) {
    return MessagesModel(json['message'], json['id']);
  }
}
