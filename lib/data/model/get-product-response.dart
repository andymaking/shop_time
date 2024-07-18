import 'dart:convert';

class GetProductResponse {
  int? page;
  int? size;
  int? total;
  dynamic debug;
  dynamic previousPage;
  dynamic nextPage;
  List<Items>? items;

  GetProductResponse(
      {this.page,
        this.size,
        this.total,
        this.debug,
        this.previousPage,
        this.nextPage,
        this.items});

  GetProductResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    size = json['size'];
    total = json['total'];
    debug = json['debug'];
    previousPage = json['previous_page'];
    nextPage = json['next_page'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['size'] = this.size;
    data['total'] = this.total;
    data['debug'] = this.debug;
    data['previous_page'] = this.previousPage;
    data['next_page'] = this.nextPage;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

List<Items> getGetItemsDataListFromJson(String str) =>
    List<Items>.from(
        json.decode(str).map((x) => Items.fromJson(x)));

String getItemsDataListToJson(List<Items> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<Map<String, dynamic>> getItemsListToJson(List<Items> data) =>
    List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));

class Items {
  String? name;
  String? description;
  String? uniqueId;
  String? urlSlug;
  bool? isAvailable;
  bool? isService;
  Null? previousUrlSlugs;
  bool? unavailable;
  Null? unavailableStart;
  Null? unavailableEnd;
  String? id;
  Null? parentProductId;
  Null? parent;
  num? quantity;
  String? organizationId;
  List<Null>? productImage;
  List<Categories>? categories;
  String? dateCreated;
  String? lastUpdated;
  String? userId;
  List<Photos>? photos;
  List<CurrentPrice>? currentPrice;
  bool? isDeleted;
  num? availableQuantity;
  Null? sellingPrice;
  Null? discountedPrice;
  Null? buyingPrice;
  Null? extraInfos;

  Items(
      {this.name,
        this.description,
        this.uniqueId,
        this.urlSlug,
        this.isAvailable,
        this.isService,
        this.previousUrlSlugs,
        this.unavailable,
        this.unavailableStart,
        this.unavailableEnd,
        this.id,
        this.quantity,
        this.parentProductId,
        this.parent,
        this.organizationId,
        this.productImage,
        this.categories,
        this.dateCreated,
        this.lastUpdated,
        this.userId,
        this.photos,
        this.currentPrice,
        this.isDeleted,
        this.availableQuantity,
        this.sellingPrice,
        this.discountedPrice,
        this.buyingPrice,
        this.extraInfos});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    uniqueId = json['unique_id'];
    urlSlug = json['url_slug'];
    quantity = json['quantity'];
    isAvailable = json['is_available'];
    isService = json['is_service'];
    previousUrlSlugs = json['previous_url_slugs'];
    unavailable = json['unavailable'];
    unavailableStart = json['unavailable_start'];
    unavailableEnd = json['unavailable_end'];
    id = json['id'];
    parentProductId = json['parent_product_id'];
    parent = json['parent'];
    organizationId = json['organization_id'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    dateCreated = json['date_created'];
    lastUpdated = json['last_updated'];
    userId = json['user_id'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    if (json['current_price'] != null) {
      currentPrice = <CurrentPrice>[];
      json['current_price'].forEach((v) {
        currentPrice!.add(new CurrentPrice.fromJson(v));
      });
    }
    isDeleted = json['is_deleted'];
    availableQuantity = json['available_quantity'];
    sellingPrice = json['selling_price'];
    discountedPrice = json['discounted_price'];
    buyingPrice = json['buying_price'];
    extraInfos = json['extra_infos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['unique_id'] = this.uniqueId;
    data['quantity'] = this.quantity;
    data['url_slug'] = this.urlSlug;
    data['is_available'] = this.isAvailable;
    data['is_service'] = this.isService;
    data['previous_url_slugs'] = this.previousUrlSlugs;
    data['unavailable'] = this.unavailable;
    data['unavailable_start'] = this.unavailableStart;
    data['unavailable_end'] = this.unavailableEnd;
    data['id'] = this.id;
    data['parent_product_id'] = this.parentProductId;
    data['parent'] = this.parent;
    data['organization_id'] = this.organizationId;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['date_created'] = this.dateCreated;
    data['last_updated'] = this.lastUpdated;
    data['user_id'] = this.userId;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    if (this.currentPrice != null) {
      data['current_price'] =
          this.currentPrice!.map((v) => v.toJson()).toList();
    }
    data['is_deleted'] = this.isDeleted;
    data['available_quantity'] = this.availableQuantity;
    data['selling_price'] = this.sellingPrice;
    data['discounted_price'] = this.discountedPrice;
    data['buying_price'] = this.buyingPrice;
    data['extra_infos'] = this.extraInfos;
    return data;
  }

  void updateQuantity(num newQuantity) {
    this.quantity = newQuantity;
  }

}

class Categories {
  String? organizationId;
  String? name;
  Null? position;
  String? categoryType;
  String? description;
  String? lastUpdated;
  String? id;
  Null? parentId;
  Null? urlSlug;
  bool? isDeleted;
  String? dateCreated;
  List<Null>? subcategories;
  List<Null>? parents;

  Categories(
      {this.organizationId,
        this.name,
        this.position,
        this.categoryType,
        this.description,
        this.lastUpdated,
        this.id,
        this.parentId,
        this.urlSlug,
        this.isDeleted,
        this.dateCreated,
        this.subcategories,
        this.parents});

  Categories.fromJson(Map<String, dynamic> json) {
    organizationId = json['organization_id'];
    name = json['name'];
    position = json['position'];
    categoryType = json['category_type'];
    description = json['description'];
    lastUpdated = json['last_updated'];
    id = json['id'];
    parentId = json['parent_id'];
    urlSlug = json['url_slug'];
    isDeleted = json['is_deleted'];
    dateCreated = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['organization_id'] = this.organizationId;
    data['name'] = this.name;
    data['position'] = this.position;
    data['category_type'] = this.categoryType;
    data['description'] = this.description;
    data['last_updated'] = this.lastUpdated;
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['url_slug'] = this.urlSlug;
    data['is_deleted'] = this.isDeleted;
    data['date_created'] = this.dateCreated;
    return data;
  }
}

class Photos {
  String? modelName;
  String? modelId;
  String? organizationId;
  String? filename;
  String? url;
  bool? isFeatured;
  bool? saveAsJpg;
  bool? isPublic;
  bool? fileRename;
  int? position;

  Photos(
      {this.modelName,
        this.modelId,
        this.organizationId,
        this.filename,
        this.url,
        this.isFeatured,
        this.saveAsJpg,
        this.isPublic,
        this.fileRename,
        this.position});

  Photos.fromJson(Map<String, dynamic> json) {
    modelName = json['model_name'];
    modelId = json['model_id'];
    organizationId = json['organization_id'];
    filename = json['filename'];
    url = json['url'];
    isFeatured = json['is_featured'];
    saveAsJpg = json['save_as_jpg'];
    isPublic = json['is_public'];
    fileRename = json['file_rename'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model_name'] = this.modelName;
    data['model_id'] = this.modelId;
    data['organization_id'] = this.organizationId;
    data['filename'] = this.filename;
    data['url'] = this.url;
    data['is_featured'] = this.isFeatured;
    data['save_as_jpg'] = this.saveAsJpg;
    data['is_public'] = this.isPublic;
    data['file_rename'] = this.fileRename;
    data['position'] = this.position;
    return data;
  }
}

class CurrentPrice {
  String? type;
  double? value;

  CurrentPrice({this.type, this.value});

  CurrentPrice.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}