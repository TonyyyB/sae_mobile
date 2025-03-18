class Restaurant {
  String osmId;
  double longitude;
  double latitude;
  String type;
  String name;
  String? operator;
  String? brand;
  List<String>? openingHours;
  bool? wheelchair;
  List<String> cuisine;
  bool? vegetarian;
  bool? vegan;
  bool? delivery;
  bool? takeaway;
  String? capacity;
  bool? driveThrough;
  String? phone;
  String? website;
  String? facebook;
  String region;
  String departement;
  String commune;
  List<String>? avis;

  Restaurant({required this.osmId,required this.longitude,required this.latitude,required
  this.type,required this.name , this.operator, this.brand, this.openingHours, this.wheelchair,
  required this.cuisine, this.vegetarian, this.vegan, this.delivery, this.takeaway, this.capacity,
  this.driveThrough, this.phone, this.website, this.facebook, required this.region, required this.departement,
  required this.commune, this.avis});

  //static List<Task> generateTask(int i){
   // List<Task> tasks=[];
   // for(int n=0;n<i;n++){
   //   tasks.add(Task(id: n, title: "title $n", tags: ['tag $n','tag${n+1}'], nbhours: n, difficulty: n, description: '$n'));
   // }
   // return tasks;
  //}
}