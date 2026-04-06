class PoojaSummaryResponse {
  bool? status;
  List<PoojaSummaryData>? data;
  Temple? temple;
  var grossTotal;
  Meta? meta;
  Links? links;
  PoojaSummaryResponse(
      {this.status,
      this.data,
      this.meta,
      this.links,
      this.grossTotal,
      this.temple});
  PoojaSummaryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <PoojaSummaryData>[];
      json['data'].forEach((v) {
        data!.add(PoojaSummaryData.fromJson(v));
      });
    }
    temple = json['temple'] != null ? Temple.fromJson(json['temple']) : null;

    grossTotal = json['gross_total'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
  }
}

class PoojaSummaryData {
  String? poojaName;
  int? poojaCount;
  int? totalRate;
  PoojaSummaryData({this.poojaName, this.poojaCount, this.totalRate});
  PoojaSummaryData.fromJson(Map<String, dynamic> json) {
    poojaName = json['pooja_name'];
    poojaCount = json['pooja_count'];
    totalRate = json['total_rate'];
  }
}

class Meta {
  int? total;
  String? perPage;
  int? currentPage;
  int? lastPage;
  String? nextPageUrl;
  String? prevPageUrl;
  int? from;
  int? to;
  Meta(
      {this.total,
      this.perPage,
      this.currentPage,
      this.lastPage,
      this.nextPageUrl,
      this.prevPageUrl,
      this.from,
      this.to});
  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    from = json['from'];
    to = json['to'];
  }
}

class Temple {
  String? name;
  String? nameMal;
  String? addressLine1;
  String? addressLine2;
  String? phone;
  String? email;
  String? website;

  Temple(
      {this.name,
      this.nameMal,
      this.addressLine1,
      this.addressLine2,
      this.phone,
      this.email,
      this.website});

  Temple.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameMal = json['name_mal'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['name_mal'] = nameMal;
    data['address_line_1'] = addressLine1;
    data['address_line_2'] = addressLine2;
    data['phone'] = phone;
    data['email'] = email;
    data['website'] = website;
    return data;
  }
}

class Links {
  String? self;
  String? first;
  String? last;
  var prev;
  String? next;
  Links({this.self, this.first, this.last, this.prev, this.next});
  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'];
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }
}
