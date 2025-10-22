import 'dart:convert';

class HouseListModel {
  int? id;
  int? userId;
  int? agentUserId;
  String? propertyCategory;
  String? propertyType;
  String? designType;
  String? propertyAddress;
  int? bedroom;
  int? bathroom;
  int? livingRoom;
  int? kitchen;
  String? currency;
  String? rentalFrequency;
  String? rentalFee; // Changed to String? to match JSON
  bool? otherCharges;
  int? cautionFee;
  int? serviceCharge;
  int? legalFee;
  int? agencyFee;
  String? state;
  String? lga; // Added to match JSON
  String? country; // Added to match JSON
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
  List<Map<String, dynamic>>? image; // Specified type for listingImage
  int? viewCount;
  int? likeCount;
  bool? isPromoted;
  String? promotionExpires; // Added to match JSON
  String? agentBusinessName;
  String? agentCategory;
  String? agentFirstName;
  String? agentLastName;
  String? agentPhoneNumber; // Corrected spelling
  String? profilePic;
  bool? managedBy;
  bool? hasDocument;
  bool? negotiable;
  List<String>? availability; // Changed to List<String>? for parsed JSON array
  String? propertyCondition;
  List<String>? facilities; // Changed to List<String>? for parsed JSON array
  String? propertyName;

  HouseListModel({
    this.id,
    this.userId,
    this.agentUserId,
    this.propertyCategory,
    this.propertyType,
    this.designType,
    this.propertyAddress,
    this.bedroom,
    this.bathroom,
    this.livingRoom,
    this.kitchen,
    this.currency,
    this.rentalFrequency,
    this.rentalFee,
    this.otherCharges,
    this.cautionFee,
    this.serviceCharge,
    this.legalFee,
    this.agencyFee,
    this.state,
    this.lga,
    this.country,
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
    this.promotionExpires,
    this.agentBusinessName,
    this.agentCategory,
    this.agentFirstName,
    this.agentLastName,
    this.agentPhoneNumber,
    this.profilePic,
    this.managedBy,
    this.hasDocument,
    this.negotiable,
    this.availability,
    this.propertyCondition,
    this.facilities,
    this.propertyName,
  });

  factory HouseListModel.fromJson(Map<String, dynamic> json) {
    // Parse JSON-encoded strings for facilities and availability
    List<String>? parseJsonString(String? jsonString) {
      if (jsonString == null) return null;
      try {
        final decoded = jsonDecode(jsonString) as List<dynamic>;
        return decoded.cast<String>();
      } catch (e) {
        return null;
      }
    }

    return HouseListModel(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      agentUserId: json['agentUserId'] as int?,
      propertyCategory: json['property_category'] as String?,
      propertyType: json['property_type'] as String?,
      designType: json['design_type'] as String?,
      propertyAddress: json['property_address'] as String?,
      bedroom: json['bedroom'] as int?,
      bathroom: json['bathroom'] as int?,
      livingRoom: json['living_room'] as int?,
      kitchen: json['kitchen'] as int?,
      currency: json['currency'] as String?,
      rentalFrequency: json['rental_frequency'] as String?,
      rentalFee: json['rental_fee'].toString()
          as String?, // Kept as String to match JSON
      otherCharges: json['other_charges'] as bool?,
      cautionFee: json['caution_fee'] as int?,
      serviceCharge: json['serviceCharge'] as int?,
      legalFee: json['legal_fee'] as int?,
      agencyFee: json['agency_fee'] as int?,
      state: json['state'] as String?,
      lga: json['lga'] as String?, // Added
      country: json['country'] as String?, // Added
      totalAreaOfLand: json['total_area_of_land'] as String?,
      coveredByProperty: json['covered_by_property'] as String?,
      interiorDesign: json['interior_design'] as String?,
      parkingSpace: json['parking_space'] as bool?,
      availabilityOfWater: json['availability_of_water'] as bool?,
      availabilityOfElectricity: json['availability_of_electricity'] as bool?,
      description: json['description'] as String?,
      ageRestriction: json['age_restriction'] as bool?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      image: json['listingImage'] != null
          ? List<Map<String, dynamic>>.from(json['listingImage'] as List)
          : null,
      viewCount: json['viewCount'] as int?,
      likeCount: json['likeCount'] as int?,
      isPromoted: json['isPromoted'] as bool?,
      promotionExpires: json['promotionExpires'] as String?,
      agentBusinessName: json['agent']?['business_name'] as String?,
      agentCategory: json['agent']?['category'] as String?,
      agentFirstName: json['user']?['first_name'] as String?,
      agentLastName: json['user']?['last_name'] as String?,
      agentPhoneNumber: json['agent']?['phone_number'] as String?,
      profilePic: json['user']?['profile_pic'] as String?,
      managedBy: json['agent']?['systemManaged'] as bool?,
      hasDocument: json['hasDocuments'] as bool?,
      negotiable: json['negotiable'] as bool?,
      availability: parseJsonString(json['agent']?['availability'] as String?),
      propertyCondition: json['property_condition'] as String?,
      facilities: parseJsonString(json['facilities'] as String?),
      propertyName: json['property_name'] as String?,
    );
  }
}
