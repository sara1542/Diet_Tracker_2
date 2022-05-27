class MessageModel
{
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String text;
  late String imageOfSender;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
  {
    senderId=json['senderId'];
    receiverId=json['receiverId'];
    dateTime=json['dateTime'];
    text=json['text'];
    imageOfSender=json['imageOfSender'];
  }
  Map<String, dynamic> toMap(){
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text':text,
      'imageOfSender':imageOfSender,
    };
  }
}