class HouseDetailModel {
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
  int? serviceCharge;
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
  String? createdAt;
  String? updatedAt;
  List? images;
  // Map? agentInfo;
  String? agentBusinessName;
  String? agentCategory;
  String? agentFirstName;
  String? agentLastName;
  String? agentPhoneNUmber;
  String? profilePic;
  bool? managedBy;
  bool? hasDocument;
  bool? negotiable;
  String? availability;
  String? propertyCondition;
  String? facilities; 
  String? propertyName;

  HouseDetailModel({
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
    this.serviceCharge,
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
    this.createdAt,
    this.updatedAt,
    this.images,
    // this.agentInfo,
    this.agentBusinessName,
    this.agentPhoneNUmber,
    this.agentFirstName,
    this.agentLastName,
    this.agentCategory,
    this.profilePic,
    this.managedBy,     
    this.hasDocument,
    this.negotiable,
    this.availability,
    this.propertyCondition,
    this.facilities, 
    this.propertyName,
  });

  factory HouseDetailModel.fromJson(Map<String, dynamic> json) {
    return HouseDetailModel(
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
      serviceCharge: json['serviceCharge'],
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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      images: json['listingImage'],
      // agentInfo: json['user'],
      agentBusinessName: json['agent']['business_name'],
      agentCategory: json['agent']['category'],
      agentFirstName: json['agent']['user']['first_name'],
      agentLastName: json['agent']['user']['last_name'],
      agentPhoneNUmber: json['agent']['phone_number'],
      profilePic: json['agent']['user']['profile_pic'],
      managedBy: json['agent']['systemManaged'],
      hasDocument: json['hasDocuments'],
      negotiable: json['negotiable'],
      availability: json['agent']['availability'],
      propertyCondition: json['property_condition'],
      facilities: json['facilities'],                     
      propertyName: json['property_name'],
    );
  }
}
