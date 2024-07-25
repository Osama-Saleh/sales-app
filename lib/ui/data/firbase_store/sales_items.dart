import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sales/ui/data/models/item_model.dart';

class Salesitems {
  static CollectionReference salesItem =
      FirebaseFirestore.instance.collection('sales');
  // upload image in fire base storage from gallery
  static Future<String?> uploadImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return '';
      File imageFile = File(image.path);
      String imageName = Uri.file(imageFile.path).pathSegments.last;
      //* path in chail must be unique
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}${imageName}');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print(e.toString());
    }
  }

// save item
  static Future<void> submitItem({
    String? productName,
    double? productPrice,
    String? productImage,
  }) async {
    ItemsModel itemsModel = ItemsModel(
      productName: productName,
      productPrice: productPrice,
      productImage: productImage,
    );
    await salesItem.add(itemsModel.toMap());
    await getItems();
    print(getItems());
  }

  // get items
  static Stream<List<ItemsModel>> getItems() {
        return salesItem.snapshots().map((item){
          return item.docs.map((docs){
            return ItemsModel.fromMap(docs.data() as Map<String, dynamic>);
          }).toList();
        });
  }
}
