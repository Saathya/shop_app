


import 'package:shop_spp/Services/firebase_service.dart';

class CategoryModel {
  CategoryModel({required this.catName, required this.image});

  CategoryModel.fromJson(Map<String, Object?> json)
    : this(
        catName: json['catName']! as String,
        image: json['image']! as String,
      );

  final String catName;
  final String image;

  Map<String, Object?> toJson() {
    return {
      'catName': catName,
      'image': image,
    };
  }
}


FirebaseService _service = FirebaseService();
final categorysCollection = _service.categories.where('active',isEqualTo: true).withConverter<CategoryModel>(
     fromFirestore: (snapshot, _) => CategoryModel.fromJson(snapshot.data()!),
     toFirestore: (categoryModel, _) => categoryModel.toJson(),
   );