import 'dart:convert';

class SubscriptionModel {
  List<OptionDetail> checklists;
  bool isDeleted;
  bool isDeactivated;
  String id;
  String title;
  int price;
  int offerPrice;
  int validity;
  Currency currencyType;
  int durationType;
  int subscriptionNo;
  DateTime createdAt;
  DateTime updatedAt;
  int referralsCount;
  String subscriptionType;
  int coins;
  SubscriptionModel({
    this.checklists,
    this.isDeleted,
    this.isDeactivated,
    this.id,
    this.title,
    this.price,
    this.offerPrice,
    this.validity,
    this.currencyType,
    this.durationType,
    this.subscriptionNo,
    this.createdAt,
    this.updatedAt,
    this.referralsCount,
    this.subscriptionType,
    this.coins,
  });

  Map<String, dynamic> toMap() {
    return {
      'checklists': checklists?.map((x) => x.toMap())?.toList(),
      'isDeleted': isDeleted,
      'isDeactivated': isDeactivated,
      'id': id,
      'title': title,
      'price': price,
      'offerPrice': offerPrice,
      'validity': validity,
      'currencyType': currencyType.toMap(),
      'durationType': durationType,
      'subscriptionNo': subscriptionNo,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory SubscriptionModel.fromMap(Map<String, dynamic> map) {
    return SubscriptionModel(
        checklists: List<OptionDetail>.from(
            map['checklists']?.map((x) => OptionDetail.fromMap(x))),
        isDeleted: map['is_deleted'],
        isDeactivated: map['is_deactivated'],
        id: map['_id'],
        title: map['plan_name'],
        price: map['price'],
        offerPrice: map['discount_price'],
        validity: map['validity'],
        // currencyType: Currency.fromMap(map['currency_type']),
        durationType: map['duration_type'],
        subscriptionNo: map['subscription_no'],
        createdAt: DateTime.parse(map['createdAt'].toString()).toLocal(),
        updatedAt: DateTime.parse(map['updatedAt'].toString()).toLocal(),
        referralsCount: map["referrals_count"],
        subscriptionType: map["subscription_type"],
        coins: map["payment_by_coins"]);
  }

  String toJson() => json.encode(toMap());

  factory SubscriptionModel.fromJson(String source) =>
      SubscriptionModel.fromMap(json.decode(source));
}

class OptionDetail {
  String id;
  String title;
  OptionDetail({
    this.id,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory OptionDetail.fromMap(Map<String, dynamic> map) {
    return OptionDetail(
      id: map['_id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionDetail.fromJson(String source) =>
      OptionDetail.fromMap(json.decode(source));
}

class Currency {
  String id;
  String title;
  String symbol;
  Currency({
    this.id,
    this.title,
    this.symbol,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'symbol': symbol,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      id: map['_id'].toString(),
      title: map['title'].toString(),
      symbol: map['symbol'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) =>
      Currency.fromMap(json.decode(source));
}

class ChecklistModel {
  String id;
  String title;
  ChecklistModel({
    this.id,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory ChecklistModel.fromMap(Map<String, dynamic> map) {
    return ChecklistModel(
      id: map['subscription_checklist_id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChecklistModel.fromJson(String source) =>
      ChecklistModel.fromMap(json.decode(source));
}
