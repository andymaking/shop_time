import 'dart:convert';

List<ProductData> getProductDataListFromJson(String str) =>
    List<ProductData>.from(
        json.decode(str).map((x) => ProductData.fromJson(x)));

List<Map<String, dynamic>> getProductDataListToJson(List<ProductData> data) =>
    List<Map<String, dynamic>>.from(data.map((x) => x.toJson()));

class ProductData {
  String? productId;
  int? amount;
  int? quantity;
  int? discount;
  String? currencyCode;

  ProductData(
      {this.productId,
        this.amount,
        this.quantity,
        this.discount,
        this.currencyCode});

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    amount = json['amount'];
    quantity = json['quantity'];
    discount = json['discount'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['currency_code'] = this.currencyCode;
    return data;
  }
}
