
const String tableContact = 'tbl_contact';
const String tableContactId= 'id';
const String tableContactName = 'name';
const String tableContactNumber = 'number';
const String tableContactEmail = 'email';
const String tableContactadress = 'address';
const String tableContactdob = 'dob';
const String tableContactgender = 'gender';
const String tableContactimage = 'image';
const String tableContactfavourite = 'favourite';


class ContactModel{

  int? id;
  String name;
  String number;
  String? email;
  String? adress;
  String ? dob;
  String? gender;
  String? image;
  bool favourite;

  ContactModel({this.id, required this.name,required this.number, this.email, this.adress,
      this.dob, this.gender, this.image, this.favourite = false});

  Map<String,dynamic> toMap(){

    var map = <String,dynamic>{

    tableContactName:name,
    tableContactNumber:number,
    tableContactEmail:email,
    tableContactadress:adress,
    tableContactdob:dob,
    tableContactgender:gender,
    tableContactimage:image,
    tableContactfavourite:favourite? 1:0,
    };
    if(id!=null){

      map[tableContactId]=id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String,dynamic> map) => ContactModel(

    id: map[tableContactId],
    name: map[tableContactName],
    number: map[tableContactNumber],
    email: map[tableContactEmail],
    adress: map[tableContactadress],
    dob: map[tableContactdob],
    gender: map[tableContactgender],
    image: map[tableContactimage],
    favourite: map[tableContactfavourite]
  );


  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, number: $number, email: $email, adress: $adress, dob: $dob, gender: $gender, image: $image, isFavorite: $favourite}';
  }
}