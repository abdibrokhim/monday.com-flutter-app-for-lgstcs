import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mainform/pages/forms/components/custom_dropdown.dart';
import 'package:mainform/store/env.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart'
    show
        AssetEntity,
        DefaultAssetPickerProvider,
        DefaultAssetPickerBuilderDelegate;
import 'package:mainform/constants/picker_method.dart';
import 'package:mainform/pages/forms/components/custom_input_field_decoration.dart';
import 'package:mainform/pages/forms/main_form/constants.dart';
import 'package:mainform/pages/forms/main_form/main_form_model.dart';
import 'package:mainform/pages/forms/main_form/main_form_reducer.dart';
import 'package:mainform/store/app_logs.dart';
import 'package:mainform/store/app_store.dart';
import 'package:mainform/widgets/selected_assets_list_view.dart';


class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with AutomaticKeepAliveClientMixin {
  final ValueNotifier<bool> isDisplayingDetail = ValueNotifier<bool>(true);
  static final _formKey = GlobalKey<FormState>(debugLabel: "mainFormKey");

  final List<String?> errors = [];
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  final TextEditingController _mileageInController = TextEditingController();
  String? mileageIn;
  final TextEditingController _mileageOutController = TextEditingController();
  final TextEditingController _chainsController = TextEditingController();
  final TextEditingController _scrapsController = TextEditingController();
  String? mileageOut;
  int? _selectedDefLevel;
  int? _selectedFuelLevel;
  int? _invertor;
  int? _gpsForTruck;
  int? _gpsForTrailer;
  int? _fridge;

  final TextEditingController itemNameController = TextEditingController();
  
  final String truckFrontKey = 'TruckFront';
  final String truckBackKey = 'TruckBack';
  final String truckLeftKey = 'TruckLeft';
  final String truckRightKey = 'TruckRight';
  final String leftFrontTireKey = 'LeftFrontTire';
  final String rightFrontTireKey = 'RightFrontTire';
  final String sideLeftTiresKey = 'SideLeftTires';
  final String sideRightTiresKey = 'SideRightTires';
  final String leftRearOutsideKey = 'LeftRearOutside';
  final String leftRearInsideKey = 'LeftRearInside';
  final String rightRearOutsideKey = 'RightRearOutside';
  final String rightRearInsideKey = 'RightRearInside';
  final String trailerLeftKey = 'TrailerLeft';
  final String trailerRightKey = 'TrailerRight';
  final String bestpassKey = 'bestpass';
  final String tabletKey = 'tablet';
  final String eldDeviceWithCableKey = 'eldDeviceWithCable';
  


  @override
  void dispose() {
    isDisplayingDetail.dispose();
    _mileageInController.dispose();
    _mileageOutController.dispose();
    _chainsController.dispose();
    _scrapsController.dispose();
    itemNameController.dispose();
    super.dispose();
  }


  List<AssetEntity> assets = <AssetEntity>[];
  int maxAssetsCount = 1;


  late DefaultAssetPickerProvider keepScrollProvider =
      DefaultAssetPickerProvider();
  DefaultAssetPickerBuilderDelegate? keepScrollDelegate;


  Future<void> selectAssets(PickMethod model, String imageKey) async {
    final List<AssetEntity>? result = await model.method(context, assets);
    if (result != null) {
      if (mounted) {
        pickImage(imageKey, result.toList());
      }
    }
  }

  void removeAsset(int index, String imageKey) {
    removeImage(imageKey);
  }

  void onResult(List<AssetEntity>? result, String imageKey) {
    if (result != null) {
      if (mounted) {
        pickImage(imageKey, result.toList());
      }
    }
  }

  Future<void> pickImage(String imageKey, List<AssetEntity> assets) async {
        List<AssetEntity> image = assets;
        if (imageKey == 'TruckFront') {
          store.dispatch(AddFrontSideImage(image));
        } else if (imageKey == 'TruckBack') {
          store.dispatch(AddBackSideImage(image));
        } else if (imageKey == 'TruckLeft') {
          store.dispatch(AddLeftSideImage(image));
        } else if (imageKey == 'TruckRight') {
          store.dispatch(AddRightSideImage(image));
        } else if (imageKey == 'LeftFrontTire') {
          store.dispatch(AddLeftFrontTireImage(image));
        } else if (imageKey == 'RightFrontTire') {
          store.dispatch(AddRightFrontTireImage(image));
        } else if (imageKey == 'SideLeftTires') {
          store.dispatch(AddSideLeftTiresImage(image));
        } else if (imageKey == 'SideRightTires') {
          store.dispatch(AddSideRightTiresImage(image));
        } else if (imageKey == 'LeftRearOutside') {
          store.dispatch(AddLeftRearOutsideImage(image));
        } else if (imageKey == 'LeftRearInside') {
          store.dispatch(AddLeftRearInsideImage(image));
        } else if (imageKey == 'RightRearOutside') {
          store.dispatch(AddRightRearOutsideImage(image));
        } else if (imageKey == 'RightRearInside') {
          store.dispatch(AddRightRearInsideImage(image));
        } else if (imageKey == 'TrailerLeft') {
          store.dispatch(AddTrailerLeftSideImage(image));
        } else if (imageKey == 'TrailerRight') {
          store.dispatch(AddTrailerRightSideImage(image));
        } else if (imageKey == 'bestpass') {
          store.dispatch(AddBestpassImage(image));
        } else if (imageKey == 'tablet') {
          store.dispatch(AddTabletImage(image));
        } else if (imageKey == 'eldDeviceWithCable') {
          store.dispatch(AddEldDeviceWithCableImage(image));
        }
      }

    void removeImage(String imageKey) {
      if (imageKey == 'TruckFront') {
        store.dispatch(RemoveFrontSideImage());
      } else if (imageKey == 'TruckBack') {
        store.dispatch(RemoveBackSideImage());
      } else if (imageKey == 'TruckLeft') {
        store.dispatch(RemoveLeftSideImage());
      } else if (imageKey == 'TruckRight') {
        store.dispatch(RemoveRightSideImage());
      } else if (imageKey == 'LeftFrontTire') {
        store.dispatch(RemoveLeftFrontTireImage());
      } else if (imageKey == 'RightFrontTire') {
        store.dispatch(RemoveRightFrontTireImage());
      } else if (imageKey == 'SideLeftTires') {
        store.dispatch(RemoveSideLeftTiresImage());
      } else if (imageKey == 'SideRightTires') {
        store.dispatch(RemoveSideRightTiresImage());
      } else if (imageKey == 'LeftRearOutside') {
        store.dispatch(RemoveLeftRearOutsideImage());
      } else if (imageKey == 'LeftRearInside') {
        store.dispatch(RemoveLeftRearInsideImage());
      } else if (imageKey == 'RightRearOutside') {
        store.dispatch(RemoveRightRearOutsideImage());
      } else if (imageKey == 'RightRearInside') {
        store.dispatch(RemoveRightRearInsideImage());
      } else if (imageKey == 'TrailerLeft') {
        store.dispatch(RemoveTrailerLeftSideImage());
      } else if (imageKey == 'TrailerRight') {
        store.dispatch(RemoveTrailerRightSideImage());
      } else if (imageKey == 'bestpass') {
        store.dispatch(RemoveBestpassImage());
      } else if (imageKey == 'tablet') {
        store.dispatch(RemoveTabletImage());
      } else if (imageKey == 'eldDeviceWithCable') {
        store.dispatch(RemoveEldDeviceWithCableImage());
      }
    }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MAIN FORM'),
      ),
      body: StoreConnector<GlobalState, MainFormState>(
      converter: (appState) => appState.state.appState.mainFormState,
      onInit: (store) => {
        store.dispatch(ClearAllGenericErrorAction()),
          
        Future.delayed(const Duration(seconds: 2), () {
          store.dispatch(ClearAllGenericErrorSuccessAction());
          store.dispatch(GetVINsAndDriverNameListAction());
          AppLog.log().i('fetching vins and driver names triler number list');
          AppLog.log().i('fetched  vins list: ${store.state.appState.mainFormState.vinsList}');
          AppLog.log().i('fetched  driver names list: ${store.state.appState.mainFormState.driverNamesList}');
          AppLog.log().i('fetched  trailer numbers list: ${store.state.appState.mainFormState.trailerNumberList}');
        }),
        
      },
      builder: (context, mainFormState) {
        return SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if (mainFormState.isClearing)
                        const Column(
                          children: [
                            LinearProgressIndicator(),
                                                Padding(padding: EdgeInsets.only(left:16.0, right:16.0),
                    child: 

                            Text('Clearing the Workspace. Please wait...'),
                    ),
                          ],
                        ),
                      if (mainFormState.isLoading)
                        const Column(
                          children: [
                            LinearProgressIndicator(),
                                                Padding(padding: EdgeInsets.only(left:16.0, right:16.0),
                    child: 

                            Text('Initializing form. Please wait...'),
                    ),
                          ],
                        ),
                      if (mainFormState.isProcessing)
                        const Column(
                          children: [
                            LinearProgressIndicator(),
                            Padding(padding: EdgeInsets.only(left:16.0, right:16.0),
                              child: 
                                Text('Processing form. Please wait...'),
                            ),
                          ],
                        ),
                      if (mainFormState.isVINsAndDriverNameListLoading)
                        const Column(
                          children: [
                            LinearProgressIndicator(),
                            Padding(padding: EdgeInsets.only(left:16.0, right:16.0),
                              child: 
                            Text('Fetching VINs, Driver Names and Trailer Numbers list. Please wait...'),
                            ),
                          ],
                        ),
                      if (mainFormState.isSubmittedSuccessfully) Padding(padding: const EdgeInsets.only(left:16.0, right:16.0),
                              child: Text('Form submitted successfully itemId: ${mainFormState.itemId ?? 'Could not find the item id.'}'),),
                      if (mainFormState.isReportSubmittedSuccessfully) Padding(padding: const EdgeInsets.only(left:16.0, right:16.0),
                              child: Text('Report submitted successfully file ref: ${mainFormState.responseMessage ?? 'Could not find the file ref.'}'),),
                      if (mainFormState.reportPath!.isNotEmpty) Padding(padding: const EdgeInsets.only(left:16.0, right:16.0),
                              child: Text(mainFormState.reportPath ?? 'Report was generated successfully. We could not find the path to the report. Check your folders.'), ),
                      if (mainFormState.errors != null && mainFormState.errors!.isNotEmpty)
                        Column(
                          children: [
                            for (var error in mainFormState.errors!.values)
                              Padding(padding: const EdgeInsets.only(left:16.0, right:16.0),
                                child: 
                              Text(error),
                              ),
                          ],
                        ),

        Form(
          key: _formKey,
          child: SingleChildScrollView(
                  child: 
    Column(
      children: <Widget>[
        const Divider(height: 1.0),
        Padding(padding: const EdgeInsets.only(left:16.0, right:16.0),
                    child: 
                                TextField(
                          controller: itemNameController,
                          decoration: const InputDecoration(
                            labelText: "Item Name",
                          ),
                          // controller: Your board ID controller
                        ),
                        ),
        const SizedBox(height: 20),
        CustomDropdownWithSearch(
          items: mainFormState.driverNamesList!,
          itemName: 'Driver Name',
          dState: 0
        ),
        const SizedBox(height: 20),
        CustomDropdownWithSearch(
          items: mainFormState.vinsList!,
          itemName: 'Truck VIN',
          dState: 1
        ),
        const SizedBox(height: 20),
        CustomDropdownWithSearch(
          items: mainFormState.trailerNumberList!,
          itemName: 'Trailer Number',
          dState: 2
        ),
        const SizedBox(height: 20),
        buildMileageInFormField(),
        const SizedBox(height: 20),
        buildMileageOutFormField(),
        const SizedBox(height: 20),
        buildDefLevelDropdown(),
        const SizedBox(height: 20),
        buildFuelLevelDropdown(),
        const SizedBox(height: 20),
        buildChainsFormField(),
        const SizedBox(height: 20),
        buildScrapsFormField(),
        const SizedBox(height: 20),
        buildInvertorDropdown(),
        const SizedBox(height: 20),
        buildGpsForTruckDropdown(),
        const SizedBox(height: 20),
        buildGpsForTrailerDropdown(),
        const SizedBox(height: 20),
        buildFridgeDropdown(),
        const SizedBox(height: 20),


        const Divider(height: 1.0),
        
        const Text('Truck Front'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'TruckFront',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'TruckFront',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.frontSide.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.frontSide,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'TruckFront',
          ),

          const Divider(height: 1.0),

        const Text('Truck Back'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'TruckBack',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'TruckBack',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.backSide.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.backSide,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'TruckBack',
          ),

          const Divider(height: 1.0),


        const Text('Truck Left'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'TruckLeft',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'TruckLeft',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.leftSide.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.leftSide,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'TruckLeft',
          ),

          const Divider(height: 1.0),

        const Text('Truck Right'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'TruckRight',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'TruckRight',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.rightSide.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.rightSide,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'TruckRight',
          ),

          const Divider(height: 1.0),
          
        const Text('Left Front Tire'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'LeftFrontTire',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'LeftFrontTire',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.leftFrontTire.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.leftFrontTire,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'LeftFrontTire',
          ),

          const Divider(height: 1.0),

        const Text('Right Front Tire'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'RightFrontTire',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'RightFrontTire',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.rightFrontTire.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.rightFrontTire,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'RightFrontTire',
          ),

          const Divider(height: 1.0),


        const Text('Side Left Tires'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'SideLeftTires',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'SideLeftTires',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.sideLeftTires.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.sideLeftTires,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'SideLeftTires',
          ),

          const Divider(height: 1.0),

        const Text('Side Right Tires'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                'SideRightTires',
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    'SideRightTires',
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.sideRightTires.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.sideRightTires,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: 'SideRightTires',
          ),

          const Divider(height: 1.0),
        
        
        const Text('Left Rear Outside'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                leftRearOutsideKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    leftRearOutsideKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.leftRearOutside.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.leftRearOutside,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: leftRearOutsideKey,
          ),

          const Divider(height: 1.0),

        const Text('Left Rear Inside'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                leftRearInsideKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    leftRearInsideKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.leftRearInside.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.leftRearInside,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: leftRearInsideKey,
          ),

          const Divider(height: 1.0),


        const Text('Right Rear Outside'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                rightRearOutsideKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    rightRearOutsideKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.rightRearOutside.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.rightRearOutside,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: rightRearOutsideKey,
          ),

          const Divider(height: 1.0),

        const Text('Right Rear Inside'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                rightRearInsideKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    rightRearInsideKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.rightRearInside.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.rightRearInside,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: rightRearInsideKey,
          ),

          const Divider(height: 1.0),
          
        const Text('Trailer Left Side'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                trailerLeftKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    trailerLeftKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.trailerLeftSide.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.trailerLeftSide,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: trailerLeftKey,
          ),

          const Divider(height: 1.0),

        const Text('Trailer Right Side'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                trailerRightKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    trailerRightKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.trailerRightSide.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.trailerRightSide,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: trailerRightKey,
          ),

          const Divider(height: 1.0),

        const Text('Bestpass'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                bestpassKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    bestpassKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.bestpass.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.bestpass,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: bestpassKey,
          ),

          const Divider(height: 1.0),
        
        const Text('Tablet'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                tabletKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    tabletKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.tablet.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.tablet,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: tabletKey,
          ),

          const Divider(height: 1.0),
        
        const Text('ELD Device With Cable'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          
          TextButton(
            onPressed: () => selectAssets(
                                        PickMethod.camera(
                  context: context,
                  maxAssetsCount: maxAssetsCount,
                  handleResult: (BuildContext context, AssetEntity result) =>
                      Navigator.of(context).pop(<AssetEntity>[result]),
                ),
                eldDeviceWithCableKey,
            ),
            child: const Text('Take Photo'),
          ),
          TextButton(
            onPressed: () => selectAssets(
                    PickMethod.image(context, maxAssetsCount),
                    eldDeviceWithCableKey,
            ),
            child: const Text('Select Photo'),
          ),
        ]),
        if (mainFormState.mainFormModel!.eldDeviceWithCable.isNotEmpty)
          SelectedAssetsListView(
            assets: mainFormState.mainFormModel!.eldDeviceWithCable,
            isDisplayingDetail: isDisplayingDetail,
            onResult: onResult,
            onRemoveAsset: removeAsset,
            imageKey: eldDeviceWithCableKey,
          ),

          const Divider(height: 1.0),



          const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: 
                    ElevatedButton(
                      onPressed: () => _selectCheckInDate(context),
                      child: Text(_checkInDate == null ? 'Select Check-In Date' : 'Check-In: ${_formatDate(_checkInDate!)}'),
                    ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(child: 
                    ElevatedButton(
                      onPressed: () => _selectCheckOutDate(context),
                      child: Text(_checkOutDate == null ? 'Select Check-Out Date' : 'Check-Out: ${_formatDate(_checkOutDate!)}'),
                    ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      store.dispatch(ClearAllGenericMsgAction());
                      Future.delayed(const Duration(seconds: 2), () {
                        store.dispatch(ClearAllGenericMsgSuccessAction());
                      });
                    },
                    child:
                      const Text('Clear Msg')
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        itemNameController.clear();
                        _mileageInController.clear();
                        _mileageOutController.clear();
                        _chainsController.clear();
                        _scrapsController.clear();
                        _formKey.currentState!.reset();
                        _checkInDate = null;
                        _checkOutDate = null;
                        _selectedDefLevel = null;
                        _selectedFuelLevel = null;
                        _invertor = null;
                        _gpsForTruck = null;
                        _gpsForTrailer = null;
                        _fridge = null;
                      });
                      store.dispatch(ClearAllGenericErrorAction());
                      store.dispatch(MainFormState.initial());
                      Future.delayed(const Duration(seconds: 2), () {
                        store.dispatch(ClearAllGenericErrorSuccessAction());
                      });
                    },
                    child:
                      const Text('Clear Form')
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_checkInDate == null) {
                          store.dispatch(HandleGenericErrorAction('Check-In Date is required'));
                          return;
                        }
                        if (_checkOutDate == null) {
                          store.dispatch(HandleGenericErrorAction('Check-Out Date is required'));
                          return;
                        }
                        AppLog.log().i('Form is valid');
                        AppLog.log().i('Form Info start');

                        AppLog.log().i('Driver Name: ${mainFormState.mainFormModel!.driverName}');
                        AppLog.log().i('Truck VIN: ${mainFormState.mainFormModel!.truckVin}');
                        AppLog.log().i('Trailer Number: ${mainFormState.mainFormModel!.trailerNumber}');
                        AppLog.log().i('Check-In Date: ${mainFormState.mainFormModel!.dateCheckIn}');
                        AppLog.log().i('Check-Out Date: ${mainFormState.mainFormModel!.dateCheckOut}');
                        AppLog.log().i('Mileage In: ${mainFormState.mainFormModel!.mileageIn}');
                        AppLog.log().i('Mileage Out: ${mainFormState.mainFormModel!.mileageOut}');
                        AppLog.log().i('DEF Level: ${mainFormState.mainFormModel!.defLevel}');
                        AppLog.log().i('Fuel Level: ${mainFormState.mainFormModel!.fuelLevel}');
                        AppLog.log().i('Chains: ${mainFormState.mainFormModel!.chains}');
                        AppLog.log().i('Scraps: ${mainFormState.mainFormModel!.scraps}');
                        AppLog.log().i('Invertor: ${mainFormState.mainFormModel!.inverter}');
                        AppLog.log().i('GPS For Truck: ${mainFormState.mainFormModel!.gpsForTruck}');
                        AppLog.log().i('GPS For Trailer: ${mainFormState.mainFormModel!.gpsForTrailer}');
                        AppLog.log().i('Fridge: ${mainFormState.mainFormModel!.fridge}');
                        
                        AppLog.log().i('Form Info end');

                        store.dispatch(SubmitMainFormAction(
                          mainFormModel: MainFormModel(
                            itemName: itemNameController.text,
                            driverName: mainFormState.mainFormModel!.driverName,
                            truckVin: mainFormState.mainFormModel!.truckVin,
                            trailerNumber: mainFormState.mainFormModel!.trailerNumber,
                            dateCheckIn: mainFormState.mainFormModel!.dateCheckIn,
                            dateCheckOut: mainFormState.mainFormModel!.dateCheckOut,
                            mileageIn: mainFormState.mainFormModel!.mileageIn,
                            mileageOut: mainFormState.mainFormModel!.mileageOut,
                            chains: mainFormState.mainFormModel!.chains,
                            scraps: mainFormState.mainFormModel!.scraps,
                            defLevel: mainFormState.mainFormModel!.defLevel,
                            fuelLevel: mainFormState.mainFormModel!.fuelLevel,
                            inverter: mainFormState.mainFormModel!.inverter,
                            gpsForTruck: mainFormState.mainFormModel!.gpsForTruck,
                            gpsForTrailer: mainFormState.mainFormModel!.gpsForTrailer,
                            fridge: mainFormState.mainFormModel!.fridge,
                            frontSide: mainFormState.mainFormModel!.frontSide,
                            backSide: mainFormState.mainFormModel!.backSide,
                            leftSide: mainFormState.mainFormModel!.leftSide,
                            rightSide: mainFormState.mainFormModel!.rightSide,
                            leftFrontTire: mainFormState.mainFormModel!.leftFrontTire,
                            rightFrontTire: mainFormState.mainFormModel!.rightFrontTire,
                            sideLeftTires: mainFormState.mainFormModel!.sideLeftTires,
                            sideRightTires: mainFormState.mainFormModel!.sideRightTires,
                            leftRearOutside: mainFormState.mainFormModel!.leftRearOutside,
                            leftRearInside: mainFormState.mainFormModel!.leftRearInside,
                            rightRearOutside: mainFormState.mainFormModel!.rightRearOutside,
                            rightRearInside: mainFormState.mainFormModel!.rightRearInside,
                            trailerLeftSide: mainFormState.mainFormModel!.trailerLeftSide,
                            trailerRightSide: mainFormState.mainFormModel!.trailerRightSide,
                            bestpass: mainFormState.mainFormModel!.bestpass,
                            tablet: mainFormState.mainFormModel!.tablet,
                            eldDeviceWithCable: mainFormState.mainFormModel!.eldDeviceWithCable,
                          )
                        ));
                      }
                    },
                    child:
                      const Text('Submit')
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (mainFormState.isSubmittedSuccessfully && !mainFormState.isActiveFleetVINsListLoading)
                Column(
                  children: [
                      const Divider(height: 1.0),
                    const SizedBox(height: 20),

                    const Padding(padding: EdgeInsets.only(left:16.0, right:16.0),
                    child: Column(
                      children: [

                    Text('If see this message. You\'ve successfully submitted the Main Form.'),
                    Text('Now, you can generate and submit the Report Form.'),
                    Text('Make sure you have not CLEARED the Main Form.'),
                      ],
                    ),
                    ),
                    
                    const SizedBox(height: 20),

                      const Divider(height: 1.0),
                    const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                        onPressed: () {
                          if (mainFormState.mainFormModel != null) {
                            store.dispatch(GenerateReportAction(mainFormModel: mainFormState.mainFormModel!));
                          } else {
                            store.dispatch(HandleGenericErrorAction('It seems you have cleared the form. Please fill the form again!'));
                          }
                        },
                        child: const Text('Generate Report')
                      ),
                  ElevatedButton(
                        onPressed: () {
                          if (mainFormState.reportFile != null && mainFormState.itemId != null) {
                              store.dispatch(SubmitReportAction(reportForm: ReportForm(reportFile: mainFormState.reportFile, itemId: mainFormState.itemId, columnId: Environments.reportColumnId)));
                          } else {
                            store.dispatch(HandleGenericErrorAction('Please generate the report first! Or try to RESUBMIT the Main Form!'));
                          }
                        },

                        child: const Text('Submit Report')
                      ),
                ],),
                  ],
                ),
                                    const Divider(height: 1.0),
                                    const SizedBox(height: 20),
                                    const Divider(height: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                        onPressed: () {
                          setState(() {
                            itemNameController.clear();
                            _mileageInController.clear();
                            _mileageOutController.clear();
                            _chainsController.clear();
                            _scrapsController.clear();
                            _formKey.currentState!.reset();
                            _checkInDate = null;
                            _checkOutDate = null;
                            _selectedDefLevel = null;
                            _selectedFuelLevel = null;
                            _invertor = null;
                            _gpsForTruck = null;
                            _gpsForTrailer = null;
                            _fridge = null;
                          });
                          store.dispatch(ReinitializeFormAction());
                        },
                        child: const Text('Reinitialize Form')
                      ),
                  ElevatedButton(
                        onPressed: () {
                          store.dispatch(ReinitializeAppAction());

                          store.dispatch(ClearAllGenericErrorAction());
        
                          Future.delayed(const Duration(seconds: 2), () {
                            store.dispatch(ClearAllGenericErrorSuccessAction());
                          });
                          

                          AppLog.log().i('fetching vins and driver names list');
                          store.dispatch(GetVINsAndDriverNameListAction());
                          AppLog.log().i('fetched vins and vins list: ${store.state.appState.mainFormState.vinsList}');
                          AppLog.log().i('fetched vins and driver names list: ${store.state.appState.mainFormState.driverNamesList}');
                        },
                        child: const Text('Reinitialize App')
                      ),
                ],),

      ],
    ),
    ),
    ),
    
    const SizedBox(height: 20),


                        ],
                  ),
                ),
              ),
            ),
          );
      },
    ),
    );
  }
  

  Future<void> _selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _checkInDate) {
      store.dispatch(UpdateDateCheckIn(picked));
      setState(() {
        _checkInDate = picked;
      });
    }
  }

  Future<void> _selectCheckOutDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkOutDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _checkOutDate) {
      store.dispatch(UpdateDateCheckOut(picked));
      setState(() {
        _checkOutDate = picked;
      });
    }
  }

  TextFormField buildMileageInFormField() {
    var state = StoreProvider.of<GlobalState>(context);
    return TextFormField(
      controller: _mileageInController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        if (newValue != null) {
          print('_mileageIn: $newValue');
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          print('_mileageIn: $value');
          store.dispatch(UpdateMileageIn(value));
          state.dispatch(ClearGenericErrorAction(2));
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          state.dispatch(HandleGenericErrorAction('Mileage In is required'));
          return "";
        }
        return null;
      },
      decoration: inputDecoration(
        hintText: 'Mileage In', 
        context:context
      )
    );
  }

  TextFormField buildMileageOutFormField() {
    var state = StoreProvider.of<GlobalState>(context);
    return TextFormField(
      controller: _mileageOutController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        if (newValue != null) {
          print('_mileageOut: $newValue');
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          print('_mileageOut: $value');
          store.dispatch(UpdateMileageOut(value));
          state.dispatch(ClearGenericErrorAction(3));
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          state.dispatch(HandleGenericErrorAction('Mileage Out is required'));
          return "";
        }
        return null;
      },
      decoration: inputDecoration(
        hintText: 'Mileage Out', 
        context:context
      )
    );
  }

  TextFormField buildChainsFormField() {
    var state = StoreProvider.of<GlobalState>(context);
    return TextFormField(
      controller: _chainsController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        if (newValue != null) {
          print('chains: $newValue');
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          print('chains: $value');
          store.dispatch(UpdateChains(value));
          state.dispatch(ClearGenericErrorAction(4));
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          print('scraps: $value');
          state.dispatch(HandleGenericErrorAction('Chains is required'));
          return "";
        }
        return null;
      },
      decoration: inputDecoration(
        hintText: 'Chains', 
        context:context
      )
    );
  }

  TextFormField buildScrapsFormField() {
    var state = StoreProvider.of<GlobalState>(context);
    return TextFormField(
      controller: _scrapsController,
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        if (newValue != null) {
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          print('scraps: $value');
          store.dispatch(UpdateScraps(value));
          state.dispatch(ClearGenericErrorAction(5));
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          state.dispatch(HandleGenericErrorAction('Scraps is required'));
          return "";
        }
        return null;
      },
      decoration: inputDecoration(
        hintText: 'Scraps', 
        context:context
      )
    );
  }



  DropdownButtonFormField<int> buildDefLevelDropdown() {
    return DropdownButtonFormField<int>(
      value: _selectedDefLevel,
      onChanged: (int? newValue) {
        if (newValue != null) {
          store.dispatch(UpdateDefLevelMap(newValue));
          print('_selectedDefLevel: ${store.state.appState.mainFormState.mainFormModel!.defLevel}');
          setState(() {
            _selectedDefLevel = newValue;
          });
        }
      },
      items: defLevelMap.entries.map<DropdownMenuItem<int>>((entry) {
        return DropdownMenuItem<int>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      decoration: inputDecoration(
        hintText: 'Select DEF Level',
        context: context,
      ),
    );
  }

  DropdownButtonFormField<int> buildFuelLevelDropdown() {
    return DropdownButtonFormField<int>(
      value: _selectedFuelLevel,
      onChanged: (int? newValue) {
        if (newValue != null) {
          store.dispatch(UpdateFuelLevelMap(newValue));
          print('_selectedFuelLevel: ${store.state.appState.mainFormState.mainFormModel!.fuelLevel}');
          setState(() {
            _selectedFuelLevel = newValue;
          });
        }
      },
      items: fuelLevelMap.map((key, value) => MapEntry(
        key, DropdownMenuItem<int>(
          value: key,
          child: Text(value),
        )
      )).values.toList(),
      decoration: inputDecoration(
        hintText: 'Select Fuel Level',
        context: context,
      ),
    );
  }

  DropdownButtonFormField<int> buildInvertorDropdown() {
    return DropdownButtonFormField<int>(
      value: _invertor,
      onChanged: (int? newValue) {
        if (newValue != null) {
          store.dispatch(UpdateInverter(newValue));
          print('invertor: ${store.state.appState.mainFormState.mainFormModel!.inverter}');
          setState(() {
            _invertor = newValue;
          });
        }
      },
      items: options.map((key, value) => MapEntry(
        key, DropdownMenuItem<int>(
          value: key,
          child: Text(value),
        )
      )).values.toList(),
      decoration: inputDecoration(
        hintText: 'Invertor',
        context: context,
      ),
    );
  }

  DropdownButtonFormField<int> buildGpsForTruckDropdown() {
    return DropdownButtonFormField<int>(
      value: _gpsForTruck,
      onChanged: (int? newValue) {
        if (newValue != null) {
          store.dispatch(UpdateGpsForTruck(newValue));
          print('GPS For Truck: ${store.state.appState.mainFormState.mainFormModel!.gpsForTruck}');
          setState(() {
            _gpsForTruck = newValue;
          });
        }
      },
      items: options.map((key, value) => MapEntry(
        key, DropdownMenuItem<int>(
          value: key,
          child: Text(value),
        )
      )).values.toList(),
      decoration: inputDecoration(
        hintText: 'GPS For Truck',
        context: context,
      ),
    );
  }

  DropdownButtonFormField<int> buildGpsForTrailerDropdown() {
    return DropdownButtonFormField<int>(
      value: _gpsForTrailer,
      onChanged: (int? newValue) {
        if (newValue != null) {
          store.dispatch(UpdateGpsForTrailer(newValue));
          print('GPS For Trailer: ${store.state.appState.mainFormState.mainFormModel!.gpsForTrailer}');
          setState(() {
            _gpsForTrailer = newValue;
          });
        }
      },
      items: options.map((key, value) => MapEntry(
        key, DropdownMenuItem<int>(
          value: key,
          child: Text(value),
        )
      )).values.toList(),
      decoration: inputDecoration(
        hintText: 'GPS For Trailer',
        context: context,
      ),
    );
  }

  DropdownButtonFormField<int> buildFridgeDropdown() {
    return DropdownButtonFormField<int>(
      value: _fridge,
      onChanged: (int? newValue) {
        if (newValue != null) {
          store.dispatch(UpdateFridge(newValue));
          print('Fridge: ${store.state.appState.mainFormState.mainFormModel!.fridge}');
          setState(() {
            _fridge = newValue;
          });
        }
      },
      items: options.map((key, value) => MapEntry(
        key, DropdownMenuItem<int>(
          value: key,
          child: Text(value),
        )
      )).values.toList(),
      decoration: inputDecoration(
        hintText: 'Fridge',
        context: context,
      ),
    );
  }



  String _formatDate(DateTime date) {
    // 12/12/2023
    return '${date.month}/${date.day}/${date.year}';
  }

  
  @override
  bool get wantKeepAlive => true;
}