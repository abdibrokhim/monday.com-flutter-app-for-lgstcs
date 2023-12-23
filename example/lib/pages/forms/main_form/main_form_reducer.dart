import 'dart:io';

import 'package:redux/redux.dart';
import 'package:mainform/pages/forms/main_form/main_form_model.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';


// ========== Main Form State ========== //

class MainFormState {
  final bool isLoading;
  final bool isItemsListLoading;
  final bool isVINsAndDriverNameListLoading;
  final bool isTrailerNumberListLoading;
  final bool isActiveFleetVINsListLoading;
  final bool isActiveFleetItemsListLoading;
  final bool isSubmittedSuccessfully;
  final bool isReportSubmittedSuccessfully;
  final bool isProcessing;
  final bool isGeneratingReport;
  final bool isClearing;
  final Map<int, String>? errors;
  final String? responseMessage;
  final MainFormModel? mainFormModel;
  final List<int>? itemsIdsList;
  final List<String>? vinsList;
  final List<String>? driverNamesList;
  final List<String>? trailerNumberList;
  final List<String>? activeFleetVINsList;
  final Map<String, Map<String, dynamic>>? activeFleetBoardData;
  final String? reportPath;
  final int? itemId;
  final File? reportFile;
  final String accessToken;
  final int truckFilesBoardId;
  final int myBoard;
  final int itemLimit;

  MainFormState({
    this.isLoading = false,
    this.isItemsListLoading = false,
    this.isVINsAndDriverNameListLoading = false,
    this.isTrailerNumberListLoading = false,
    this.isActiveFleetVINsListLoading = false,
    this.isSubmittedSuccessfully = false,
    this.isReportSubmittedSuccessfully = false,
    this.isGeneratingReport = false,
    this.isActiveFleetItemsListLoading = false,
    this.isProcessing = false,
    this.isClearing = false,
    this.errors = const {},
    this.responseMessage,
    this.mainFormModel,
    this.itemsIdsList,
    this.vinsList,
    this.driverNamesList,
    this.trailerNumberList,
    this.activeFleetVINsList,
    this.activeFleetBoardData,
    this.reportPath,
    this.itemId,
    this.reportFile,
    this.accessToken = '',
    this.truckFilesBoardId = 0,
    this.myBoard = 0,
    this.itemLimit = 0,
  });

  factory MainFormState.initial() {
    return MainFormState(
      isLoading: false,
      isItemsListLoading: false,
      isVINsAndDriverNameListLoading: false,
      isTrailerNumberListLoading: false,
      isActiveFleetVINsListLoading: false,
      isActiveFleetItemsListLoading: false,
      isSubmittedSuccessfully: false,
      isReportSubmittedSuccessfully: false,
      isGeneratingReport: false,
      isProcessing: false,
      isClearing: false,
      errors: {},
      responseMessage: '',
      mainFormModel: MainFormModel.initial(),
      itemsIdsList: [],
      vinsList: [],
      driverNamesList: [],
      trailerNumberList: [],
      activeFleetVINsList: [],
      activeFleetBoardData: {},
      reportPath: '',
      itemId: null,
      reportFile: null,
      accessToken: '',
      truckFilesBoardId: 0,
      myBoard: 0,
      itemLimit: 0,
    );
  }

  MainFormState copyWith({
    bool? isLoading,
    bool? isItemsListLoading,
    bool? isVINsAndDriverNameListLoading,
    bool? isTrailerNumberListLoading,
    bool? isActiveFleetVINsListLoading,
    bool? isActiveFleetItemsListLoading,
    bool? isSubmittedSuccessfully,
    bool? isReportSubmittedSuccessfully,
    bool? isGeneratingReport,
    bool? isProcessing,
    bool? isClearing,
    Map<int, String>? errors,
    String? responseMessage,
    String? reportPath,
    MainFormModel? mainFormModel,
    List<int>? itemsIdsList,
    List<String>? vinsList,
    List<String>? driverNamesList,
    List<String>? trailerNumberList,
    List<String>? activeFleetVINsList,
    Map<String, Map<String, dynamic>>? activeFleetBoardData,
    int? itemId,  
    File? reportFile,
    String accessToken = '',
    int truckFilesBoardId = 0,
    int myBoard = 0,
    int itemLimit = 0,
    }) {

    return MainFormState(
      isLoading: isLoading ?? this.isLoading,
      isItemsListLoading: isItemsListLoading ?? this.isItemsListLoading,
      isVINsAndDriverNameListLoading: isVINsAndDriverNameListLoading ?? this.isVINsAndDriverNameListLoading,
      isTrailerNumberListLoading: isTrailerNumberListLoading ?? this.isTrailerNumberListLoading,
      isActiveFleetVINsListLoading: isActiveFleetVINsListLoading ?? this.isActiveFleetVINsListLoading,
      isActiveFleetItemsListLoading: isActiveFleetItemsListLoading ?? this.isActiveFleetItemsListLoading,
      isSubmittedSuccessfully: isSubmittedSuccessfully ?? this.isSubmittedSuccessfully,
      isReportSubmittedSuccessfully: isReportSubmittedSuccessfully ?? this.isReportSubmittedSuccessfully,
      isGeneratingReport: isGeneratingReport ?? this.isGeneratingReport,
      isProcessing: isProcessing ?? this.isProcessing,
      isClearing: isClearing ?? this.isClearing,
      errors: errors ?? this.errors,
      responseMessage: responseMessage ?? this.responseMessage,
      mainFormModel: mainFormModel ?? this.mainFormModel,
      itemsIdsList: itemsIdsList ?? this.itemsIdsList,
      vinsList: vinsList ?? this.vinsList,
      driverNamesList: driverNamesList ?? this.driverNamesList,
      trailerNumberList: trailerNumberList ?? this.trailerNumberList,
      activeFleetVINsList: activeFleetVINsList ?? this.activeFleetVINsList,
      activeFleetBoardData: activeFleetBoardData ?? this.activeFleetBoardData,
      reportPath: reportPath ?? this.reportPath,
      itemId: itemId ?? this.itemId,
      reportFile: reportFile ?? this.reportFile,
      accessToken: accessToken,
      truckFilesBoardId: truckFilesBoardId,
      myBoard: myBoard,
      itemLimit: itemLimit,
    );
  }
}


// ========== ReinitializeFormAction Actions ========== //

class ReinitializeFormAction {
  ReinitializeFormAction();
}

MainFormState reinitializeFormReducer(
    MainFormState state, ReinitializeFormAction action) {
  return state.copyWith(
    mainFormModel: MainFormModel.initial(),
    isSubmittedSuccessfully: false,
    isReportSubmittedSuccessfully: false,
    isProcessing: false,
    isGeneratingReport: false,
    errors: Map<int, String>.from({}),
    responseMessage: '',
    reportPath: '',
    isLoading: false,
    isItemsListLoading: false,
    isVINsAndDriverNameListLoading: false,
    isTrailerNumberListLoading: false,
    isActiveFleetVINsListLoading: false,
    isActiveFleetItemsListLoading: false,
  );
}

// ========== ReinitializeAppAction Actions ========== //

class UpdateSettingsAction {
  String accessToken;
  int truckFilesBoardId;
  int myBoard;
  int itemLimit;
  UpdateSettingsAction(this.accessToken, this.truckFilesBoardId, this.myBoard, this.itemLimit);
}

MainFormState updateSettingsActionReducer(
    MainFormState state, UpdateSettingsAction action) {
  return state.copyWith(
    accessToken: action.accessToken,
    truckFilesBoardId: action.truckFilesBoardId,
    myBoard: action.myBoard,
    itemLimit: action.itemLimit,
  );
}


// ========== ReinitializeAppAction Actions ========== //

class ReinitializeAppAction {
  ReinitializeAppAction();
}

MainFormState reinitializeAppReducer(
    MainFormState state, ReinitializeAppAction action) {
  return MainFormState.initial();
}


// ========== Update Driver name Actions ========== //

class UpdateDriverName {
  final String driverName;
  UpdateDriverName(this.driverName);
}

MainFormState updateDriverNameReducer(
    MainFormState state, UpdateDriverName action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(driverName: action.driverName),
  );
}


// ========== Update Trailer number Actions ========== //

class UpdateTrailerNumber {
  final String trailerNumber;
  UpdateTrailerNumber(this.trailerNumber);
}

MainFormState updateTrailerNumberReducer(
    MainFormState state, UpdateTrailerNumber action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(trailerNumber: action.trailerNumber),
  );
}


// ========== Update VIN number Actions ========== //

class UpdateVINNumber {
  final String vinNumber;
  UpdateVINNumber(this.vinNumber);
}

MainFormState updateVINNumberReducer(
    MainFormState state, UpdateVINNumber action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(truckVin: action.vinNumber),
  );
}


// ========== Update Date check in Actions ========== //

class UpdateDateCheckIn {
  final DateTime dateCheckIn;
  UpdateDateCheckIn(this.dateCheckIn);
}

MainFormState updateDateCheckInReducer(
    MainFormState state, UpdateDateCheckIn action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(dateCheckIn: action.dateCheckIn),
  );
}


// ========== Update Date check out Actions ========== //

class UpdateDateCheckOut {
  final DateTime dateCheckOut;
  UpdateDateCheckOut(this.dateCheckOut);
}

MainFormState updateDateCheckOutReducer(
    MainFormState state, UpdateDateCheckOut action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(dateCheckOut: action.dateCheckOut),
  );
}


// ========== Update Mileage in Actions ========== //

class UpdateMileageIn {
  final String mileageIn;
  UpdateMileageIn(this.mileageIn);
}

MainFormState updateMileageInReducer(
    MainFormState state, UpdateMileageIn action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(mileageIn: action.mileageIn),
  );
}


// ========== Update Mileage out Actions ========== //

class UpdateMileageOut {
  final String mileageOut;
  UpdateMileageOut(this.mileageOut);
}

MainFormState updateMileageOutReducer(
    MainFormState state, UpdateMileageOut action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(mileageOut: action.mileageOut),
  );
}

// ========== UpdateChains Actions ========== //

class UpdateChains {
  final String chains;
  UpdateChains(this.chains);
}

MainFormState updateChainsReducer(
    MainFormState state, UpdateChains action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(chains: action.chains),
  );
}

// ========== UpdateScraps Actions ========== //

class UpdateScraps {
  final String scraps;
  UpdateScraps(this.scraps);
}

MainFormState updateScrapsReducer(
    MainFormState state, UpdateScraps action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(scraps: action.scraps),
  );
}



// ========== defLevelMap Actions ========== //

class UpdateDefLevelMap {
  final int defLevel;
  UpdateDefLevelMap(this.defLevel);
}

MainFormState updateDefLevelMapReducer(
    MainFormState state, UpdateDefLevelMap action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(defLevel: action.defLevel),
  );
}


// ========== fuelLevelMap Actions ========== //

class UpdateFuelLevelMap {
  final int fuelLevel;
  UpdateFuelLevelMap(this.fuelLevel);
}

MainFormState updateFuelLevelMapReducer(
    MainFormState state, UpdateFuelLevelMap action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(fuelLevel: action.fuelLevel),
  );
}

// ========== UpdateInverter Actions ========== //

class UpdateInverter {
  final int inverter;
  UpdateInverter(this.inverter);
}

MainFormState updateInverterReducer(
    MainFormState state, UpdateInverter action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(inverter: action.inverter),
  );
}

// ========== UpdateGpsForTruck Actions ========== //

class UpdateGpsForTruck {
  final int gpsForTruck;
  UpdateGpsForTruck(this.gpsForTruck);
}

MainFormState updateGpsForTruckReducer(
    MainFormState state, UpdateGpsForTruck action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(gpsForTruck: action.gpsForTruck),
  );
}

// ========== UpdateGpsForTrailer Actions ========== //

class UpdateGpsForTrailer {
  final int gpsForTrailer;
  UpdateGpsForTrailer(this.gpsForTrailer);
}

MainFormState updateGpsForTrailerReducer(
    MainFormState state, UpdateGpsForTrailer action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(gpsForTrailer: action.gpsForTrailer),
  );
}


// ========== UpdateFridge Actions ========== //

class UpdateFridge {
  final int fridge;
  UpdateFridge(this.fridge);
}

MainFormState updateFridgeReducer(
    MainFormState state, UpdateFridge action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(fridge: action.fridge),
  );
}


// ========== add front side image ========== //

class AddFrontSideImage {
  final List<AssetEntity> image;
  AddFrontSideImage(this.image);
}

MainFormState addFrontSideImageReducer(
    MainFormState state, AddFrontSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(frontSide: action.image),
  );
}

// ========== add back side image ========== //

class AddBackSideImage {
  final List<AssetEntity> image;
  AddBackSideImage(this.image);
}

MainFormState addBackSideImageReducer(
    MainFormState state, AddBackSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(backSide: action.image),
  );
}

// ========== add left side image ========== //

class AddLeftSideImage {
  final List<AssetEntity> image;
  AddLeftSideImage(this.image);
}

MainFormState addLeftSideImageReducer(
    MainFormState state, AddLeftSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftSide: action.image),
  );
}

// ========== add right side image ========== //

class AddRightSideImage {
  final List<AssetEntity> image;
  AddRightSideImage(this.image);
}

MainFormState addRightSideImageReducer(
    MainFormState state, AddRightSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightSide: action.image),
  );
}

// ========== add left front tire image ========== //

class AddLeftFrontTireImage {
  final List<AssetEntity> image;
  AddLeftFrontTireImage(this.image);
}

MainFormState addLeftFrontTireImageReducer(
    MainFormState state, AddLeftFrontTireImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftFrontTire: action.image),
  );
}

// ========== add right front tire image ========== //

class AddRightFrontTireImage {
  final List<AssetEntity> image;
  AddRightFrontTireImage(this.image);
}

MainFormState addRightFrontTireImageReducer(
    MainFormState state, AddRightFrontTireImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightFrontTire: action.image),
  );
}

// ========== add side left tires image ========== //

class AddSideLeftTiresImage {
  final List<AssetEntity> image;
  AddSideLeftTiresImage(this.image);
}

MainFormState addSideLeftTiresImageReducer(
    MainFormState state, AddSideLeftTiresImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(sideLeftTires: action.image),
  );
}

// ========== add side right tires image ========== //

class AddSideRightTiresImage {
  final List<AssetEntity> image;
  AddSideRightTiresImage(this.image);
}

MainFormState addSideRightTiresImageReducer(
    MainFormState state, AddSideRightTiresImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(sideRightTires: action.image),
  );
}

// ========== add left rear outside image ========== //

class AddLeftRearOutsideImage {
  final List<AssetEntity> image;
  AddLeftRearOutsideImage(this.image);
}

MainFormState addLeftRearOutsideImageReducer(
    MainFormState state, AddLeftRearOutsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftRearOutside: action.image),
  );
}

// ========== add left rear inside image ========== //

class AddLeftRearInsideImage {
  final List<AssetEntity> image;
  AddLeftRearInsideImage(this.image);
}

MainFormState addLeftRearInsideImageReducer(
    MainFormState state, AddLeftRearInsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftRearInside: action.image),
  );
}

// ========== add right rear outside image ========== //

class AddRightRearOutsideImage {
  final List<AssetEntity> image;
  AddRightRearOutsideImage(this.image);
}

MainFormState addRightRearOutsideImageReducer(
    MainFormState state, AddRightRearOutsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightRearOutside: action.image),
  );
}

// ========== add right rear inside image ========== //

class AddRightRearInsideImage {
  final List<AssetEntity> image;
  AddRightRearInsideImage(this.image);
}

MainFormState addRightRearInsideImageReducer(
    MainFormState state, AddRightRearInsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightRearInside: action.image),
  );
}

// ========== add trailer left side image ========== //

class AddTrailerLeftSideImage {
  final List<AssetEntity> image;
  AddTrailerLeftSideImage(this.image);
}

MainFormState addTrailerLeftSideImageReducer(
    MainFormState state, AddTrailerLeftSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(trailerLeftSide: action.image),
  );
}

// ========== add trailer right side image ========== //

class AddTrailerRightSideImage {
  final List<AssetEntity> image;
  AddTrailerRightSideImage(this.image);
}

MainFormState addTrailerRightSideImageReducer(
    MainFormState state, AddTrailerRightSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(trailerRightSide: action.image),
  );
}

// ========== AddBestpassImage image ========== //

class AddBestpassImage {
  final List<AssetEntity> image;
  AddBestpassImage(this.image);
}

MainFormState addBestpassImageReducer(
    MainFormState state, AddBestpassImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(bestpass: action.image),
  );
}

// ========== AddTabletImage image ========== //

class AddTabletImage {
  final List<AssetEntity> image;
  AddTabletImage(this.image);
}

MainFormState AddTabletImageReducer(
    MainFormState state, AddTabletImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(tablet: action.image),
  );
}

// ========== AddEldDeviceWithCableImage image ========== //

class AddEldDeviceWithCableImage {
  final List<AssetEntity> image;
  AddEldDeviceWithCableImage(this.image);
}

MainFormState addEldDeviceWithCableImageReducer(
    MainFormState state, AddEldDeviceWithCableImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(eldDeviceWithCable: action.image),
  );
}

// ========== add additional images ========== //

// class AddAdditionalImages {
//   final List<AssetEntity> images;
//   AddAdditionalImages(this.images);
// }

// MainFormState addAdditionalImagesReducer(
//     MainFormState state, AddAdditionalImages action) {
//   return state.copyWith(
//     mainFormModel: state.mainFormModel?.copyWith(additionalPhotos: action.images),
//   );
// }



// ========== remove front side image ========== //

class RemoveFrontSideImage {
  RemoveFrontSideImage();
}

MainFormState removeFrontSideImageReducer(
    MainFormState state, RemoveFrontSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(frontSide: []),
  );
}


// ========== remove back side image ========== //

class RemoveBackSideImage {
  RemoveBackSideImage();
}

MainFormState removeBackSideImageReducer(
    MainFormState state, RemoveBackSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(backSide: []),
  );
}


// ========== remove left side image ========== //

class RemoveLeftSideImage {
  RemoveLeftSideImage();
}

MainFormState removeLeftSideImageReducer(
    MainFormState state, RemoveLeftSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftSide: []),
  );
}


// ========== remove right side image ========== //

class RemoveRightSideImage {
  RemoveRightSideImage();
}

MainFormState removeRightSideImageReducer(
    MainFormState state, RemoveRightSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightSide: []),
  );
}


// ========== remove left front tire image ========== //

class RemoveLeftFrontTireImage {
  RemoveLeftFrontTireImage();
}

MainFormState removeLeftFrontTireImageReducer(
    MainFormState state, RemoveLeftFrontTireImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftFrontTire: []),
  );
}


// ========== remove right front tire image ========== //

class RemoveRightFrontTireImage {
  RemoveRightFrontTireImage();
}

MainFormState removeRightFrontTireImageReducer(
    MainFormState state, RemoveRightFrontTireImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightFrontTire: []),
  );
}


// ========== remove side left tires image ========== //

class RemoveSideLeftTiresImage {
  RemoveSideLeftTiresImage();
}

MainFormState removeSideLeftTiresImageReducer(
    MainFormState state, RemoveSideLeftTiresImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(sideLeftTires: []),
  );
}


// ========== remove side right tires image ========== //

class RemoveSideRightTiresImage {
  RemoveSideRightTiresImage();
}

MainFormState removeSideRightTiresImageReducer(
    MainFormState state, RemoveSideRightTiresImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(sideRightTires: []),
  );
}


// ========== remove left rear outside image ========== //

class RemoveLeftRearOutsideImage {
  RemoveLeftRearOutsideImage();
}

MainFormState removeLeftRearOutsideImageReducer(
    MainFormState state, RemoveLeftRearOutsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftRearOutside: []),
  );
}


// ========== remove left rear inside image ========== //

class RemoveLeftRearInsideImage {
  RemoveLeftRearInsideImage();
}

MainFormState removeLeftRearInsideImageReducer(
    MainFormState state, RemoveLeftRearInsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(leftRearInside: []),
  );
}


// ========== remove right rear outside image ========== //

class RemoveRightRearOutsideImage {
  RemoveRightRearOutsideImage();
}

MainFormState removeRightRearOutsideImageReducer(
    MainFormState state, RemoveRightRearOutsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightRearOutside: []),
  );
}


// ========== remove right rear inside image ========== //

class RemoveRightRearInsideImage {
  RemoveRightRearInsideImage();
}

MainFormState removeRightRearInsideImageReducer(
    MainFormState state, RemoveRightRearInsideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(rightRearInside: []),
  );
}


// ========== remove trailer left side image ========== //

class RemoveTrailerLeftSideImage {
  RemoveTrailerLeftSideImage();
}

MainFormState removeTrailerLeftSideImageReducer(
    MainFormState state, RemoveTrailerLeftSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(trailerLeftSide: []),
  );
}


// ========== remove trailer right side image ========== //

class RemoveTrailerRightSideImage {
  RemoveTrailerRightSideImage();
}

MainFormState removeTrailerRightSideImageReducer(
    MainFormState state, RemoveTrailerRightSideImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(trailerRightSide: []),
  );
}

// ========== RemoveBestpassImage image ========== //

class RemoveBestpassImage {
  RemoveBestpassImage();
}

MainFormState removeBestpassImageReducer(
    MainFormState state, RemoveBestpassImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(bestpass: []),
  );
}

// ========== RemoveTabletImage image ========== //

class RemoveTabletImage {
  RemoveTabletImage();
}

MainFormState removeTabletImageReducer(
    MainFormState state, RemoveTabletImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(tablet: []),
  );
}

// ========== RemoveEldDeviceWithCableImage image ========== //

class RemoveEldDeviceWithCableImage {
  RemoveEldDeviceWithCableImage();
}

MainFormState removeEldDeviceWithCableImageReducer(
    MainFormState state, RemoveEldDeviceWithCableImage action) {
  return state.copyWith(
    mainFormModel: state.mainFormModel?.copyWith(eldDeviceWithCable: []),
  );
}


// ========== remove additional images ========== //

// class RemoveAdditionalImages {
//   RemoveAdditionalImages();
// }

// MainFormState removeAdditionalImagesReducer(
//     MainFormState state, RemoveAdditionalImages action) {
//   return state.copyWith(
//     mainFormModel: state.mainFormModel?.copyWith(additionalPhotos: []),
//   );
// }





// ========== Handle Generic Error ========== //

class HandleGenericErrorAction {
  final String message;

  HandleGenericErrorAction(this.message);
}

MainFormState handleGenericErrorReducer(
    MainFormState state, HandleGenericErrorAction action) {
  final newErrors = Map<int, String>.from(state.errors ?? {});
  final int newIndex = newErrors.length;
  newErrors[newIndex] = action.message;

  return state.copyWith(
    isLoading: false,
    isProcessing: false,
    errors: newErrors,
  );
}



// ========== Clear Generic Error ========== //

class ClearGenericErrorAction {
  final int index;

  ClearGenericErrorAction(this.index);
}

MainFormState clearGenericErrorReducer(
    MainFormState state, ClearGenericErrorAction action) {
  final newErrors = Map<int, String>.from(state.errors ?? {});
  newErrors.remove(action.index);

  return state.copyWith(
    isLoading: false,
    isSubmittedSuccessfully: false,
    isProcessing: false,
    errors: newErrors.isEmpty ? null : newErrors,
  );
}


// ========== Clear All Generic Error ========== //

class ClearAllGenericErrorAction {
  ClearAllGenericErrorAction();
}

MainFormState clearAllGenericErrorReducer(
    MainFormState state, ClearAllGenericErrorAction action) {
  return state.copyWith(
    isClearing: true,
  );
}


// ========== Clear All Generic Msg ========== //

class ClearAllGenericMsgAction {
  ClearAllGenericMsgAction();
}

MainFormState clearAllGenericMsgReducer(
    MainFormState state, ClearAllGenericMsgAction action) {
  return state.copyWith(
    isClearing: true,
    errors: Map<int, String>.from({}),
    responseMessage: '',
  );
}


// ========== Clear All Success Msg ========== //

class ClearAllGenericMsgSuccessAction {
  ClearAllGenericMsgSuccessAction();
}

MainFormState clearAllGenericMsgSuccessReducer(
    MainFormState state, ClearAllGenericMsgSuccessAction action) {
  return state.copyWith(
    isClearing: false,
  );
}


// ========== Clear All Generic Error Success ========== //

class ClearAllGenericErrorSuccessAction {
  ClearAllGenericErrorSuccessAction();
}

MainFormState clearAllGenericErrorSuccessReducer(
    MainFormState state, ClearAllGenericErrorSuccessAction action) {
  return state.copyWith(
    isClearing: false,
  );
}



// ========== Main Form Submit Actions ========== //

class SubmitMainFormAction {
  final MainFormModel mainFormModel;

  SubmitMainFormAction({
    required this.mainFormModel,
  });
}

MainFormState submitMainFormActionReducer(
    MainFormState state, SubmitMainFormAction action) {
  return state.copyWith(isProcessing: true);
}


// ========== Main Form Success Actions ========== //

class SubmitMainFormSuccessAction {
  final int itemId;

  SubmitMainFormSuccessAction(this.itemId);
}

MainFormState submitMainFormSuccessActionReducer(
    MainFormState state, SubmitMainFormSuccessAction action) {
  return state.copyWith(
    isSubmittedSuccessfully: true,
    isProcessing: false,
    errors: Map<int, String>.from({}),
    itemId: action.itemId,
  );
}


// ========== Report Form Submit Actions ========== //

class SubmitReportAction {
  final ReportForm reportForm;

  SubmitReportAction({
    required this.reportForm,
  });
}

MainFormState submitReportAction(
    MainFormState state, SubmitReportAction action) {
  return state.copyWith(isProcessing: true);
}


// ========== Report Form Success Actions ========== //

class SubmitReportActionSuccessAction {
  final String message;

  SubmitReportActionSuccessAction(this.message);
}

MainFormState submitReportActionSuccessActionReducer(
    MainFormState state, SubmitReportActionSuccessAction action) {
  return state.copyWith(
    isReportSubmittedSuccessfully: true,
    isProcessing: false,
    errors: Map<int, String>.from({}),
    responseMessage: action.message,
  );
}


// ========== Main Form Fail Actions ========== //

class SubmitMainFormFailAction {
  final String message;

  SubmitMainFormFailAction(this.message);
}

MainFormState submitMainFormFailActionReducer(
    MainFormState state, SubmitMainFormFailAction action) {
  return state.copyWith(
    isLoading: false,
    isSubmittedSuccessfully: false,
    isProcessing: false,
    errors: Map<int, String>.from({}),
    responseMessage: action.message,
  );
}

// ========== GetVINsAndDriverNameListAction Actions/Reducer ========== //

class GetVINsAndDriverNameListAction {
  GetVINsAndDriverNameListAction();
}

MainFormState getVINsAndDriverNameListActionReducer(
    MainFormState state, GetVINsAndDriverNameListAction action) {
  return state.copyWith(isVINsAndDriverNameListLoading: true);
}

// ========== GetVINsAndDriverNameListActionSuccessAction Actions/Reducer ========== //

class GetVINsAndDriverNameListActionSuccessAction {
  final Map<String, List<String>> vinsAndDriverNameList;

  GetVINsAndDriverNameListActionSuccessAction(this.vinsAndDriverNameList);
}

MainFormState getVINsAndDriverNameListActionSuccessActionReducer(
    MainFormState state, GetVINsAndDriverNameListActionSuccessAction action) {
  print('action.vinsAndDriverNameList: ${action.vinsAndDriverNameList}');
  print("action.vinsAndDriverNameList['vinNumberList']: ${action.vinsAndDriverNameList['vinNumberList']}");
  print("action.vinsAndDriverNameList['driverNameList']: ${action.vinsAndDriverNameList['driverNameList']}");
  print("action.vinsAndDriverNameList['trailerNumberList']: ${action.vinsAndDriverNameList['trailerNumberList']}");

  return state.copyWith(
    isVINsAndDriverNameListLoading: false,
    vinsList: action.vinsAndDriverNameList['vinNumberList'],
    driverNamesList: action.vinsAndDriverNameList['driverNameList'],
    trailerNumberList: action.vinsAndDriverNameList['trailerNumberList'],
  );
}

// ========== GenerateReportAction Actions/Reducer ========== //

class GenerateReportAction {
  final MainFormModel mainFormModel;

  GenerateReportAction({
    required this.mainFormModel,
  });
}

MainFormState generateReportAction(
    MainFormState state, GenerateReportAction action) {
  return state.copyWith(isGeneratingReport: true);
}


// ========== GenerateReportActionSuccessAction Actions/Reducer ========== //

class GenerateReportActionSuccessAction {
  final Map<String, dynamic> reportData;

  GenerateReportActionSuccessAction(this.reportData);
}

MainFormState generateReportActionSuccessActionReducer(
    MainFormState state, GenerateReportActionSuccessAction action) {
  return state.copyWith(
    isGeneratingReport: false,
    reportPath: action.reportData['filePath'],
    reportFile: action.reportData['reportFile'],
  );
}



Reducer<MainFormState> mainFormReducer = combineReducers<MainFormState>([
  TypedReducer<MainFormState, HandleGenericErrorAction>(handleGenericErrorReducer).call,
  TypedReducer<MainFormState, ClearGenericErrorAction>(clearGenericErrorReducer).call,
  TypedReducer<MainFormState, SubmitMainFormAction>(submitMainFormActionReducer).call,
  TypedReducer<MainFormState, SubmitMainFormSuccessAction>(submitMainFormSuccessActionReducer).call,
  TypedReducer<MainFormState, SubmitMainFormFailAction>(submitMainFormFailActionReducer).call,
  TypedReducer<MainFormState, AddFrontSideImage>(addFrontSideImageReducer).call,
  TypedReducer<MainFormState, AddBackSideImage>(addBackSideImageReducer).call,
  TypedReducer<MainFormState, AddLeftSideImage>(addLeftSideImageReducer).call,
  TypedReducer<MainFormState, AddRightSideImage>(addRightSideImageReducer).call,
  TypedReducer<MainFormState, AddLeftFrontTireImage>(addLeftFrontTireImageReducer).call,
  TypedReducer<MainFormState, AddRightFrontTireImage>(addRightFrontTireImageReducer).call,
  TypedReducer<MainFormState, AddSideLeftTiresImage>(addSideLeftTiresImageReducer).call,
  TypedReducer<MainFormState, AddSideRightTiresImage>(addSideRightTiresImageReducer).call,
  TypedReducer<MainFormState, AddLeftRearOutsideImage>(addLeftRearOutsideImageReducer).call,
  TypedReducer<MainFormState, AddLeftRearInsideImage>(addLeftRearInsideImageReducer).call,
  TypedReducer<MainFormState, AddRightRearOutsideImage>(addRightRearOutsideImageReducer).call,
  TypedReducer<MainFormState, AddRightRearInsideImage>(addRightRearInsideImageReducer).call,
  TypedReducer<MainFormState, AddTrailerLeftSideImage>(addTrailerLeftSideImageReducer).call,
  TypedReducer<MainFormState, AddTrailerRightSideImage>(addTrailerRightSideImageReducer).call,
  TypedReducer<MainFormState, AddBestpassImage>(addBestpassImageReducer).call,
  TypedReducer<MainFormState, AddTabletImage>(AddTabletImageReducer).call,
  TypedReducer<MainFormState, AddEldDeviceWithCableImage>(addEldDeviceWithCableImageReducer).call,
  // TypedReducer<MainFormState, AddAdditionalImages>(addAdditionalImagesReducer).call,
  TypedReducer<MainFormState, RemoveFrontSideImage>(removeFrontSideImageReducer).call,
  TypedReducer<MainFormState, RemoveBackSideImage>(removeBackSideImageReducer).call,
  TypedReducer<MainFormState, RemoveLeftSideImage>(removeLeftSideImageReducer).call,
  TypedReducer<MainFormState, RemoveRightSideImage>(removeRightSideImageReducer).call,
  TypedReducer<MainFormState, RemoveLeftFrontTireImage>(removeLeftFrontTireImageReducer).call,
  TypedReducer<MainFormState, RemoveRightFrontTireImage>(removeRightFrontTireImageReducer).call,
  TypedReducer<MainFormState, RemoveSideLeftTiresImage>(removeSideLeftTiresImageReducer).call,
  TypedReducer<MainFormState, RemoveSideRightTiresImage>(removeSideRightTiresImageReducer).call,
  TypedReducer<MainFormState, RemoveLeftRearOutsideImage>(removeLeftRearOutsideImageReducer).call,
  TypedReducer<MainFormState, RemoveLeftRearInsideImage>(removeLeftRearInsideImageReducer).call,
  TypedReducer<MainFormState, RemoveRightRearOutsideImage>(removeRightRearOutsideImageReducer).call,
  TypedReducer<MainFormState, RemoveRightRearInsideImage>(removeRightRearInsideImageReducer).call,
  TypedReducer<MainFormState, RemoveTrailerLeftSideImage>(removeTrailerLeftSideImageReducer).call,
  TypedReducer<MainFormState, RemoveTrailerRightSideImage>(removeTrailerRightSideImageReducer).call,
  TypedReducer<MainFormState, RemoveBestpassImage>(removeBestpassImageReducer).call,
  TypedReducer<MainFormState, RemoveTabletImage>(removeTabletImageReducer).call,
  TypedReducer<MainFormState, RemoveEldDeviceWithCableImage>(removeEldDeviceWithCableImageReducer).call,
  // TypedReducer<MainFormState, RemoveAdditionalImages>(removeAdditionalImagesReducer).call,
  TypedReducer<MainFormState, ClearAllGenericErrorAction>(clearAllGenericErrorReducer).call,
  TypedReducer<MainFormState, UpdateDefLevelMap>(updateDefLevelMapReducer).call,
  TypedReducer<MainFormState, UpdateFuelLevelMap>(updateFuelLevelMapReducer).call,
  TypedReducer<MainFormState, GetVINsAndDriverNameListAction>(getVINsAndDriverNameListActionReducer).call,
  TypedReducer<MainFormState, GetVINsAndDriverNameListActionSuccessAction>(getVINsAndDriverNameListActionSuccessActionReducer).call,
  TypedReducer<MainFormState, ClearAllGenericErrorSuccessAction>(clearAllGenericErrorSuccessReducer).call,
  TypedReducer<MainFormState, GenerateReportAction>(generateReportAction).call,
  TypedReducer<MainFormState, GenerateReportActionSuccessAction>(generateReportActionSuccessActionReducer).call,
  TypedReducer<MainFormState, SubmitReportAction>(submitReportAction).call,
  TypedReducer<MainFormState, SubmitReportActionSuccessAction>(submitReportActionSuccessActionReducer).call,
  TypedReducer<MainFormState, ReinitializeFormAction>(reinitializeFormReducer).call,
  TypedReducer<MainFormState, ReinitializeAppAction>(reinitializeAppReducer).call,
  TypedReducer<MainFormState, UpdateDriverName>(updateDriverNameReducer).call,
  TypedReducer<MainFormState, UpdateTrailerNumber>(updateTrailerNumberReducer).call,
  TypedReducer<MainFormState, UpdateVINNumber>(updateVINNumberReducer).call,
  TypedReducer<MainFormState, UpdateDateCheckIn>(updateDateCheckInReducer).call,
  TypedReducer<MainFormState, UpdateDateCheckOut>(updateDateCheckOutReducer).call,
  TypedReducer<MainFormState, UpdateMileageIn>(updateMileageInReducer).call,
  TypedReducer<MainFormState, UpdateMileageOut>(updateMileageOutReducer).call,
  TypedReducer<MainFormState, UpdateChains>(updateChainsReducer).call,
  TypedReducer<MainFormState, UpdateScraps>(updateScrapsReducer).call,
  TypedReducer<MainFormState, UpdateInverter>(updateInverterReducer).call,
  TypedReducer<MainFormState, UpdateGpsForTruck>(updateGpsForTruckReducer).call,
  TypedReducer<MainFormState, UpdateGpsForTrailer>(updateGpsForTrailerReducer).call,
  TypedReducer<MainFormState, UpdateFridge>(updateFridgeReducer).call,
  TypedReducer<MainFormState, UpdateSettingsAction>(updateSettingsActionReducer).call,
  TypedReducer<MainFormState, ClearAllGenericMsgAction>(clearAllGenericMsgReducer).call,
  TypedReducer<MainFormState, ClearAllGenericMsgSuccessAction>(clearAllGenericMsgSuccessReducer).call,
]);

