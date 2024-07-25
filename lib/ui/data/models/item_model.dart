class ItemsModel {
  String? productName;
  double? productPrice;
  String? productImage;
  ItemsModel({
    this.productName,
    this.productPrice,
    this.productImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'productImage': productImage,
    };
  }

  factory ItemsModel.fromMap(Map<String, dynamic> map) {
    return ItemsModel(
      productName: map['productName'],
      productPrice: map['productPrice'],
      productImage: map['productImage'],
    );
  }

  }
