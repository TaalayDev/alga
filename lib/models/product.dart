import 'package:alga/models/app_location.dart';
import 'package:alga/models/category.dart';
import 'package:alga/models/currency.dart';
import 'package:alga/models/media.dart';
import 'package:alga/utils/helper.dart';

class ProductStatus {
  static const int USUAL = 0;
  static const int VIP = 1;

  static final values = [USUAL, VIP];
}

class Product {
  int? id;
  int? status;
  int? categoryId;
  Category? category;
  String? title;
  String? desc;
  String? phone;
  int? price;
  int? currencyId;
  Currency? currency;
  String? createdAt;
  String? whatsapp;
  List<Media>? images;
  int? locationId;
  AppLocation? location;

  String? get priceWCurrency => price != null
      ? '${Helper.numbersWithSpaces(price!)} ${currency?.symbol ?? ''}'
      : null;

  Product({
    this.id,
    this.categoryId,
    this.category,
    this.status,
    this.title,
    this.desc,
    this.phone,
    this.price,
    this.currency,
    this.createdAt,
    this.whatsapp,
    this.images,
    this.location,
    this.locationId,
    this.currencyId,
  });

  Product.fromMap(map) {
    id = map['id'];
    title = map['name'];
    desc = map['description'];
    phone = map['phone'];
    price = map['price'];
    currencyId = map['currency_id'];
    currency =
        map['currency'] != null ? Currency.fromMap(map['currency']) : null;
    categoryId = map['category_id'];
    category =
        map['category'] != null ? Category.fromMap(map['category']) : null;
    createdAt = Helper.parseDate(map['created_at']);
    whatsapp = '${map['whatsapp']}';
    status = map['status'] ?? ProductStatus.USUAL;
    images = map['media'] != null ? Media.fromList(map['media']) : null;
    locationId = map['location_id'];
    location =
        map['location'] != null ? AppLocation.fromMap(map['location']) : null;
  }

  static fromList(List list) => list.map((e) => Product.fromMap(e)).toList();

  Product copyWith({
    int? categoryId,
    Category? category,
    int? status,
    String? title,
    String? desc,
    String? phone,
    int? price,
    Currency? currency,
    int? currencyId,
    String? createdAt,
    String? whatsapp,
    List<Media>? images,
    int? locationId,
    AppLocation? location,
  }) =>
      Product(
        categoryId: categoryId ?? this.categoryId,
        category: category ?? this.category,
        status: status ?? this.status,
        title: title ?? this.title,
        desc: desc ?? this.desc,
        phone: phone ?? this.phone,
        price: price ?? this.price,
        currencyId: currencyId ?? this.categoryId,
        currency: currency ?? this.currency,
        createdAt: createdAt ?? this.createdAt,
        whatsapp: whatsapp ?? this.whatsapp,
        images: images ?? this.images,
        location: location ?? this.location,
        locationId: locationId ?? this.locationId,
      );

  Product copy(Product product) => Product(
        categoryId: product.categoryId ?? this.categoryId,
        category: product.category ?? this.category,
        status: product.status ?? this.status,
        title: product.title ?? this.title,
        desc: product.desc ?? this.desc,
        phone: product.phone ?? this.phone,
        price: product.price ?? this.price,
        currencyId: product.currencyId ?? this.categoryId,
        currency: product.currency ?? this.currency,
        createdAt: product.createdAt ?? this.createdAt,
        whatsapp: product.whatsapp ?? this.whatsapp,
        images: product.images ?? this.images,
        location: product.location ?? this.location,
        locationId: product.locationId ?? this.locationId,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': title,
        'description': desc,
        'phone': phone,
        'whatsapp': whatsapp,
        'price': price,
        'category_id': categoryId,
        'location_id': locationId,
        'currency_id': currencyId,
        'status': status,
      };
}
