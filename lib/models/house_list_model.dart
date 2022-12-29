class HouseListModel {
  int? id;
  int? agentId;
  String? propertyCategory;
  String? propertyType;
  String? designType;
  String? propertyAddress;
  int? bedroom;
  int? bathroom;
  int? livingRoom;
  int? kitchen;
  String? currency;
  String? rentalFrequncy;
  int? rentalFee;
  bool? otherCharges;
  int? cautionFee;
  int? legalFee;
  int? agencyFee;
  String? state;
  String? totalAreaOfLand;
  String? coveredByProperty;
  String? interiorDesign;
  bool? parkingSpace;
  bool? availabilityOfWater;
  bool? availabilityOfElectricity;
  String? description;
  bool? ageRestriction;
  String? status;
  String? createdAt;
  String? updatedAt;
  List? image;
  int? viewCount;
  int? likeCount;
  bool? isPromoted;
  String? propertyName;

  HouseListModel({
    this.id,
    this.agentId,
    this.propertyCategory,
    this.propertyType,
    this.designType,
    this.propertyAddress,
    this.bedroom,
    this.bathroom,
    this.livingRoom,
    this.kitchen,
    this.currency,
    this.rentalFrequncy,
    this.rentalFee,
    this.otherCharges,
    this.cautionFee,
    this.legalFee,
    this.agencyFee,
    this.state,
    this.totalAreaOfLand,
    this.coveredByProperty,
    this.interiorDesign,
    this.parkingSpace,
    this.availabilityOfWater,
    this.availabilityOfElectricity,
    this.description,
    this.ageRestriction,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.viewCount,
    this.likeCount,
    this.isPromoted,
    this.propertyName,
  });

  factory HouseListModel.fromJson(Map<String, dynamic> json) {
    return HouseListModel(
      id: json['id'],
      agentId: json['userId'],
      propertyCategory: json['property_category'],
      propertyType: json['property_type'],
      designType: json['design_type'],
      propertyAddress: json['property_address'],
      bedroom: json['bedroom'],
      bathroom: json['bathroom'],
      livingRoom: json['living_room'],
      kitchen: json['kitchen'],
      currency: json['currency'],
      rentalFrequncy: json['rental_frequency'],
      rentalFee: json['rental_fee'],
      otherCharges: json['other_charges'],
      cautionFee: json['caution_fee'],
      legalFee: json['legal_fee'],
      agencyFee: json['agency_fee'],
      state: json['state'],
      totalAreaOfLand: json['total_area_of_land'],
      coveredByProperty: json['covered_by_property'],
      interiorDesign: json['interior_design'],
      parkingSpace: json['parking_space'],
      availabilityOfWater: json['availability_of_water'],
      availabilityOfElectricity: json['availability_of_electricity'],
      description: json['description'],
      ageRestriction: json['age_restriction'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      image: json['listingImage'],
      viewCount: json['viewCount'],
      likeCount: json['likeCount'],
      isPromoted: json['isPromoted'],
      propertyName: json['property_name'],
    );
  }
}
