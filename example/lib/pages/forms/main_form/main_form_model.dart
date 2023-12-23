
import 'dart:io';

import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MainFormModel {
  final String itemName;
  final String driverName;
  final String truckVin;
  final String trailerNumber;
  final DateTime? dateCheckIn;
  final DateTime? dateCheckOut;
  final String? mileageIn;
  final String? mileageOut;
  final int? defLevel;
  final int? fuelLevel;
  final List<AssetEntity> frontSide;
  final List<AssetEntity> leftSide;
  final List<AssetEntity> rightSide;
  final List<AssetEntity> backSide;
  final List<AssetEntity> leftFrontTire;
  final List<AssetEntity> rightFrontTire;
  final List<AssetEntity> sideLeftTires;
  final List<AssetEntity> sideRightTires;
  final List<AssetEntity> leftRearOutside;
  final List<AssetEntity> leftRearInside;
  final List<AssetEntity> rightRearOutside;
  final List<AssetEntity> rightRearInside;
  final List<AssetEntity> trailerLeftSide;
  final List<AssetEntity> trailerRightSide;
  final List<AssetEntity> bestpass;
  final List<AssetEntity> tablet;
  final List<AssetEntity> eldDeviceWithCable;
  final String? chains;
  final String? scraps;
  final int? inverter;
  final int? gpsForTruck;
  final int? gpsForTrailer;
  final int? fridge;

  MainFormModel({
    this.itemName = '',
    this.driverName = '',
    this.truckVin = '',
    this.trailerNumber = '',
    this.dateCheckIn,
    this.dateCheckOut,
    this.mileageIn,
    this.mileageOut,
    this.defLevel,
    this.fuelLevel,
    this.frontSide = const [],
    this.leftSide = const [],
    this.rightSide = const [],
    this.backSide = const [],
    this.leftFrontTire = const [],
    this.rightFrontTire = const [],
    this.sideLeftTires = const [],
    this.sideRightTires = const [],
    this.leftRearOutside = const [],
    this.leftRearInside = const [],
    this.rightRearOutside = const [],
    this.rightRearInside = const [],
    this.trailerLeftSide = const [],
    this.trailerRightSide = const [],
    this.bestpass = const [],
    this.tablet = const [],
    this.eldDeviceWithCable = const [],
    this.chains,
    this.scraps,
    this.inverter,
    this.gpsForTruck,
    this.gpsForTrailer,
    this.fridge,
  });


  factory MainFormModel.initial() {
    return MainFormModel(
      itemName: '',
      driverName: '',
      truckVin: '',
      trailerNumber: '',
      dateCheckIn: null,
      dateCheckOut: null,
      mileageIn: null,
      mileageOut: null,
      defLevel: null,
      fuelLevel: null,
      frontSide: [],
      leftSide: [],
      rightSide: [],
      backSide: [],
      leftFrontTire: [],
      rightFrontTire: [],
      sideLeftTires: [],
      sideRightTires: [],
      leftRearOutside: [],
      leftRearInside: [],
      rightRearOutside: [],
      rightRearInside: [],
      trailerLeftSide: [],
      trailerRightSide: [],
      bestpass: [],
      tablet: [],
      eldDeviceWithCable: [],
      chains: null,
      scraps: null,
      inverter: null,
      gpsForTruck: null,
      gpsForTrailer: null,
      fridge: null,
    );
  }

  MainFormModel copyWith({
    String? itemName,
    String? driverName,
    String? truckVin,
    String? trailerNumber,
    DateTime? dateCheckIn,
    DateTime? dateCheckOut,
    String? mileageIn,
    String? mileageOut,
    int? defLevel,
    int? fuelLevel,
    List<AssetEntity>? frontSide,
    List<AssetEntity>? leftSide,
    List<AssetEntity>? rightSide,
    List<AssetEntity>? backSide,
    List<AssetEntity>? leftFrontTire,
    List<AssetEntity>? rightFrontTire,
    List<AssetEntity>? sideLeftTires,
    List<AssetEntity>? sideRightTires,
    List<AssetEntity>? leftRearOutside,
    List<AssetEntity>? leftRearInside,
    List<AssetEntity>? rightRearOutside,
    List<AssetEntity>? rightRearInside,
    List<AssetEntity>? trailerLeftSide,
    List<AssetEntity>? trailerRightSide,
    List<AssetEntity>? bestpass,
    List<AssetEntity>? tablet,
    List<AssetEntity>? eldDeviceWithCable,
    String? chains,
    String? scraps,
    int? inverter,
    int? gpsForTruck,
    int? gpsForTrailer,
    int? fridge,
  }) {
    return MainFormModel(
      itemName: itemName ?? this.itemName,
      driverName: driverName ?? this.driverName,
      truckVin: truckVin ?? this.truckVin,
      trailerNumber: trailerNumber ?? this.trailerNumber,
      dateCheckIn: dateCheckIn ?? this.dateCheckIn,
      dateCheckOut: dateCheckOut ?? this.dateCheckOut,
      mileageIn: mileageIn ?? this.mileageIn,
      mileageOut: mileageOut ?? this.mileageOut,
      defLevel: defLevel ?? this.defLevel,
      fuelLevel: fuelLevel ?? this.fuelLevel,
      frontSide: frontSide ?? this.frontSide,
      leftSide: leftSide ?? this.leftSide,
      rightSide: rightSide ?? this.rightSide,
      backSide: backSide ?? this.backSide,
      leftFrontTire: leftFrontTire ?? this.leftFrontTire,
      rightFrontTire: rightFrontTire ?? this.rightFrontTire,
      sideLeftTires: sideLeftTires ?? this.sideLeftTires,
      sideRightTires: sideRightTires ?? this.sideRightTires,
      leftRearOutside: leftRearOutside ?? this.leftRearOutside,
      leftRearInside: leftRearInside ?? this.leftRearInside,
      rightRearOutside: rightRearOutside ?? this.rightRearOutside,
      rightRearInside: rightRearInside ?? this.rightRearInside,
      trailerLeftSide: trailerLeftSide ?? this.trailerLeftSide,
      trailerRightSide: trailerRightSide ?? this.trailerRightSide,
      bestpass: bestpass ?? this.bestpass,
      tablet: tablet ?? this.tablet,
      eldDeviceWithCable: eldDeviceWithCable ?? this.eldDeviceWithCable,
      chains: chains ?? this.chains,
      scraps: scraps ?? this.scraps,
      inverter: inverter ?? this.inverter,
      gpsForTruck: gpsForTruck ?? this.gpsForTruck,
      gpsForTrailer: gpsForTrailer ?? this.gpsForTrailer,
      fridge: fridge ?? this.fridge,
    );
  }


  Map<String, dynamic> toJson() => {
    'driver_name': driverName,
    'truck_vin': truckVin,
    'trailer_number': trailerNumber,
    'date_check_in': dateCheckIn?.toIso8601String(),
    'date_check_out': dateCheckOut?.toIso8601String(),
    'mileage_in': mileageIn,
    'mileage_out': mileageOut,
    'def_level': defLevel,
    'fuel_level': fuelLevel,
    'front_side': frontSide,
    'left_side': leftSide,
    'right_side': rightSide,
    'back_side': backSide,
    'left_front_tire': leftFrontTire,
    'right_front_tire': rightFrontTire,
    'side_left_tires': sideLeftTires,
    'side_right_tires': sideRightTires,
    'left_rear_outside': leftRearOutside,
    'left_rear_inside': leftRearInside,
    'right_rear_outside': rightRearOutside,
    'right_rear_inside': rightRearInside,
    'trailer_left_side': trailerLeftSide,
    'trailer_right_side': trailerRightSide,
    'bestpass': bestpass,
    'tablet': tablet,
    'eld_device_wz_cable': eldDeviceWithCable,
    'chains': chains,
    'scraps': scraps,
    'inverter': inverter,
    'gps_for_truck': gpsForTruck,
    'gps_for_trailer': gpsForTrailer,
    'fridge': fridge,
  };
}


const Map<int, String> defLevelMap = {
  0: 'E',
  1: '1/4',
  2: '1/2',
  3: '3/4',
  4: 'F',
};

const Map<int, String> fuelLevelMap = {
  0: 'E',
  1: '1/8',
  2: '1/4',
  3: '3/8',
  4: '1/2',
  5: '5/8',
  6: '3/4',
  7: '7/8',
  8: 'F',
};

const Map<int, String> options = {
  0: 'No',
  1: 'Yes',
};

class ReportForm {
  File? reportFile;
  String? columnId;
  int? itemId;

  ReportForm({
    this.reportFile,
    this.columnId,
    this.itemId,
  });

  factory ReportForm.initial() {
    return ReportForm(
      reportFile: null,
      columnId: null,
      itemId: null,
    );
  }

  ReportForm copyWith({
    File? reportFile,
    String? columnId,
    int? itemId,
  }) {
    return ReportForm(
      reportFile: reportFile ?? this.reportFile,
      columnId: columnId ?? this.columnId,
      itemId: itemId ?? this.itemId,
    );
  }

}