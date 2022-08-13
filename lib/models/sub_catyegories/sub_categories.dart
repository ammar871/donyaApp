class SubCategoModel{
  String? name,textEnglish,field,image,textFrance;

  SubCategoModel({this.name, this.field, this.image,this.textEnglish});

  SubCategoModel.fromJson(Map<dynamic ,dynamic>map){
    name =map["name"];
    field =map["field"];
    image =map["image"];
    textEnglish =map["textEnglish"];
    textFrance =map["textFrench"];

  }
}