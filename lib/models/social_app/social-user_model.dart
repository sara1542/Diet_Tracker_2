class SocialUserModel
{
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late bool isEmailVerified;
  late String currentCase;
  late int age;
  late int height;
  late int weight;

  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
  required this.isEmailVerified,
    required this.age,
    required this.weight,
    required this.height,
    required this.currentCase,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    isEmailVerified=json['isEmailVerified'];
    age=json['age'];
    weight=json['weight'];
    height=json['height'];
    currentCase=json['currentCase'];
  }
  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId':uId,
      'image':image,
      'isEmailVerified':isEmailVerified,
      'age':age,
      'weight':weight,
      'height':height,
      'currentCase':currentCase,
    };
  }
}