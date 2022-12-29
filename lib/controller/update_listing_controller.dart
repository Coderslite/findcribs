// import 'package:get/get.dart';

// import '../models/house_detail_model.dart';
// import '../service/property_details_service.dart';

// class UpdateListingController extends GetxController {
//   late Future<HouseDetailModel> singleProperty;

//   var propertyCategory = ''.obs;
//   var houseType = ''.obs;
//   var propertyAddress = ''.obs;
//   var bedroom = 0.obs;
//   var bathrooom = 0.obs;
//   var livingroom = 0.obs;
//   var kitchen = 0.obs;
//   var currency = ''.obs;
//   var rentFrequency = ''.obs;
//   var rentalFee = 0.obs;
//   var charge = false.obs;
//   var negotiable= false.obs;
//   var location = ''.obs;
//   var area = ''.obs;
//   var covered = ''.obs;
//   var interiorDesign = ''.obs;
//   var space= false.obs;
//   var water= false.obs;
//   var electricity= false.obs;
//   var cautionFee = 0.obs;
//   var serviceCharge = ''.obs;
//   var legalFee = 0.obs;
//   var agencyFee = 0.obs;

//   handleGetPropertyInfo(int id) {
//     singleProperty = getSingleProperty(id);
//     singleProperty.then((value) {
//         propertyCategory.value = value.propertyCategory.toString();
//         houseType.value = value.designType.toString();
//         propertyAddress.value = value.propertyAddress.toString();
//         bedroom.value = value.bedroom!.toInt();
//         livingroom.value = value.livingRoom!.toInt();
//         kitchen.value = value.kitchen!.toInt();
//         currency.value = value.currency.toString();
//         rentFrequency.value = value.rentalFrequncy.toString();
//         rentalFee.value = value.rentalFee!.toInt();
//         charge.value = value.otherCharges;
//         negotiable.value = value.negotiable;
//         location.value = value.location;
//         area.value = value.totalAreaOfLand;
//         covered.value = value.coveredByProperty;
//         interiorDesign.value = value.interiorDesign;
//         space = value.parkingSpace;
//         water = value.availabilityOfWater;
//         electricity = value.availabilityOfElectricity;
//         cautionFee = value.cautionFee;
//         // serviceCharge = value.se
//         legalFee = value.legalFee;
//         agencyFee = value.agencyFee;
//       });
//   }
// }
