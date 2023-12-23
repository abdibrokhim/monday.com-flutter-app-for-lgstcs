import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:mainform/pages/forms/main_form/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:mainform/pages/forms/main_form/main_form_model.dart';
import 'package:mainform/store/app_logs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mainform/store/env.dart';
import 'dart:io';
import 'package:photo_manager/photo_manager.dart';

class MainFormService {


  static Future<int> submitMainForm(MainFormModel mainFormModel) async {
    try {
      final itemId = await _createItem(mainFormModel);

      final fileRefsMap = await _uploadFiles(mainFormModel, itemId);
      
      AppLog.log().i("fileRefsMap: $fileRefsMap");

      return itemId;
    } catch (e) {
      AppLog.log().e("Error while submitting: $e");
      return Future.error('Failed to submit due to an exception: $e');
    }
  }



  static Future<int> _createItem(MainFormModel mainFormModel) async {
    try {

      print('Creating item...');

      String itemName = mainFormModel.itemName;
      String driverName = mainFormModel.driverName;
      String truckVin = mainFormModel.truckVin;
      String trailerNumber = mainFormModel.trailerNumber;
      String mileageIn = mainFormModel.mileageIn!;
      String mileageOut = mainFormModel.mileageOut!;
      String chains = mainFormModel.chains!;
      String scraps = mainFormModel.scraps!;
      String inverter = options[mainFormModel.inverter]!;
      String gpsForTruck = options[mainFormModel.gpsForTruck]!; 
      String gpsForTrailer = options[mainFormModel.gpsForTrailer]!;
      String fridge = options[mainFormModel.fridge]!;
      int defLevel = mainFormModel.defLevel!+1;
      int fuelLevel = mainFormModel.fuelLevel!+1;
      String dateCheckIn = mainFormModel.dateCheckIn!.toIso8601String().substring(0, 10);
      String dateCheckOut = mainFormModel.dateCheckOut!.toIso8601String().substring(0, 10);

      var headers = {
        'Authorization': 'Bearer $mondayDotComApiKey',
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(backendServiceBaseUrl));
      request.body = '''{"query":"mutation (\$columnValuesJson: JSON!) {\\n  create_item(\\n    board_id: $myBoard\\n    group_id: \\"topics\\"\\n    item_name: \\"$itemName\\"\\n    column_values: \$columnValuesJson\\n  ) {\\n    id\\n  }\\n}","variables":{"columnValuesJson":"{\\"driver_name\\":\\"$driverName\\",\\"truck_vin\\":\\"$truckVin\\",\\"trailer_number\\":\\"$trailerNumber\\",\\"mileage_in\\":\\"$mileageIn\\",\\"mileage_out\\":\\"$mileageOut\\",\\"date_check_in\\":\\"$dateCheckIn\\",\\"date_check_out\\":\\"$dateCheckOut\\",\\"def_level\\":{\\"ids\\":[$defLevel]},\\"fuel_level\\":{\\"ids\\":[$fuelLevel]}, \\"chains\\":\\"$chains\\", \\"scraps\\":\\"$scraps\\", \\"inverter\\":\\"$inverter\\", \\"gps_for_truck\\":\\"$gpsForTruck\\", \\"gps_for_trailer\\":\\"$gpsForTrailer\\", \\"fridge\\":\\"$fridge\\"}"}}''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        
        print('Response body: $responseData');

        
        var decodedResponse = json.decode(responseData);
        AppLog.log().i('responseData: $responseData');

        final int itemId = int.parse(decodedResponse['data']['create_item']['id']);
        AppLog.log().i('Item created with ID: $itemId');
        return itemId;
      } else {
        AppLog.log().e("Failed to submit, Status code: ${response.statusCode}");
        return Future.error('Failed to submit, Status code: ${response.statusCode}');
      }
    } catch (e) {
      AppLog.log().e("Error while submitting: $e");
      return Future.error('Failed to submit due to an exception: $e');
    }
  }


  static Future<Map<String, List<String>>> _uploadFiles(MainFormModel mainFormModel, int itemId) async {
    Map<String, List<String>> fileRefsMap = {};

    var imageSets = {
      'front_side': mainFormModel.frontSide,
      'left_side': mainFormModel.leftSide,
      'right_side': mainFormModel.rightSide,
      'back_side': mainFormModel.backSide,
      'left_front_tire': mainFormModel.leftFrontTire,
      'right_front_tire': mainFormModel.rightFrontTire,
      'side_left_tires': mainFormModel.sideLeftTires,
      'side_right_tires': mainFormModel.sideRightTires,
      'left_rear_outside': mainFormModel.leftRearOutside,
      'left_rear_inside': mainFormModel.leftRearInside,
      'right_rear_outside': mainFormModel.rightRearOutside,
      'right_rear_inside': mainFormModel.rightRearInside,
      'trailer_left_side': mainFormModel.trailerLeftSide,
      'trailer_right_side': mainFormModel.trailerRightSide,
      'bestpass': mainFormModel.bestpass,
      'tablet': mainFormModel.tablet,
      'eld_device_wz_cable': mainFormModel.eldDeviceWithCable,
    };

    for (var entry in imageSets.entries) {
      String columnId = entry.key;
      List<AssetEntity> assets = entry.value;
      List<String> fileRefs = [];

      for (var asset in assets) {
        File file = await _convertAssetToFile(asset);
        AppLog.log().i('Converted asset to file: ${file.path}');
        
        String fileRef = await _uploadFile(file, itemId, columnId);
        AppLog.log().i('Uploaded file ref: $fileRef');
        
        fileRefs.add(fileRef);
      }

      if (fileRefs.isNotEmpty) {
        fileRefsMap[columnId] = fileRefs;
      }
    }

    return fileRefsMap;
  }


  static Future<File> _convertAssetToFile(AssetEntity asset) async {
    // Get the file associated with the AssetEntity
    File? file = await asset.file;

    if (file != null) {
      // Return the file if it exists
      return file;
    } else {
      // Handle the case where the file couldn't be retrieved
      throw Exception('Could not convert AssetEntity to File');
    }
  }


  static Future<String> _uploadFile(File file, int itemId, String columnId) async {
    var url = Uri.parse('$backendServiceBaseUrl/file');
    var request = http.MultipartRequest('POST', url);
    
    // Set up headers
    request.headers.addAll({
      'Authorization': 'Bearer $mondayDotComApiKey',
    });

    request.fields.addAll({
      'query': 'mutation add_file(\$file: File!) {add_file_to_column (item_id: $itemId, column_id: $columnId file: \$file) {id}}\n',
      'map': '{"image":"variables.file"}\n'
    });
    request.files.add(await http.MultipartFile.fromPath('image', file.path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      
      print('Response body: $responseData');

      
      var decodedResponse = json.decode(responseData);
      // Extract file reference from the response
      if (decodedResponse != null && decodedResponse['data'] != null && decodedResponse['data']['add_file_to_column'] != null) {
        String fileRef = decodedResponse['data']?['add_file_to_column']?['id'];
        if (fileRef == null) {
          throw Exception('File reference not found in the response');
        }
        return fileRef;
      } else {
        throw Exception('File reference not found in the response');
      }
    } else {
      var responseBody = await response.stream.bytesToString();
      AppLog.log().e("Failed to upload file: Status code ${response.statusCode}, Response: $responseBody");
      throw Exception('Failed to upload file: Status code ${response.statusCode}');
    }
  }


  static Future<List<int>> getItemsIdsList() async {
    try {

      var headers = {
        'Authorization': 'Bearer $mondayDotComApiKey',
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse(backendServiceBaseUrl));
      request.body = '''{"query":"query {\\n  boards (ids: ${Environments.truckFilesBoardId}) {\\n    items(limit: ${Environments.limit_500}) {\\n        id\\n    }\\n  }\\n}","variables":{}}''';
      
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseData);
        List<int> itemsIdsList = decodedResponse['data']?['boards']?[0]?['items']?.map<int>((item) {
          var idString = item['id'].toString();
          return int.tryParse(idString) ?? 0;
        })?.toList() ?? [];
        print('getItemsIdsList itemsIdsList: $itemsIdsList');
        return itemsIdsList;
      }
      else {
        print(response.reasonPhrase);
        throw Exception('Failed to get items ids list: Status code ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to get items ids list: $e');
      throw Exception('Failed to get items ids list: $e');
    }
  }


  static Future<Map<String, List<String>>> getVINsTrailerNumAndDriverNameList() async {
    try {

      var headers = {
        'Authorization': 'Bearer $mondayDotComApiKey',
        'Content-Type': 'application/json',
      };
      var request = http.Request('POST', Uri.parse(backendServiceBaseUrl));
      request.body = '''{"query":"query {\\n    boards(ids: $truckFilesBoardId) {\\n        items(limit: $limit_500) {\\n            column_values {\\n                id\\n                text\\n            }\\n        }\\n    }\\n}","variables":{}}''';

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var decodedResponse = json.decode(responseData);

        print('decodedResponse: $decodedResponse');

        List<String> vinNumberList = decodedResponse['data']?['boards']?[0]?['items']
          ?.expand<String>((item) {
            var vinText = item['column_values']?[1]?['text']?.toString() ?? '';
            return vinText.split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty);
          })?.toList() ?? [];

        List<String> driverNameList = decodedResponse['data']?['boards']?[0]?['items']
          ?.expand<String>((item) {
            var driverText = item['column_values']?[0]?['text']?.toString() ?? '';
            return driverText.split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty);
          })?.toList() ?? [];

        List<String> trailerNumberList = decodedResponse['data']?['boards']?[0]?['items']
          ?.expand<String>((item) {
            var trailerText = item['column_values']?[4]?['text']?.toString() ?? '';
            return trailerText.split(',')
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty);
          })?.toList() ?? [];

        print('vinNumberList: $vinNumberList');
        print('driverNameList: $driverNameList');
        print('trailerList: $trailerNumberList');

        return {
          'vinNumberList': vinNumberList,
          'driverNameList': driverNameList,
          'trailerNumberList': trailerNumberList
        };
      }
      else {
        print(response.reasonPhrase);
        throw Exception('Failed to get VIN number and driver name list: Status code ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to get VIN number and driver name list: $e');
      throw Exception('Failed to get VIN number and driver name list: $e');
    }
  }


  static Future<Uint8List> getBytesFromAssetEntity(AssetEntity asset) async {
    File? file = await asset.file;

    if (file != null) {
      Uint8List byteData = await file.readAsBytes();
      return byteData;
    } else {
      throw Exception('Failed to load image file from AssetEntity');
    }
  }

  static Future<pw.Widget> _buildImageSection(String title, List<AssetEntity>? images) async {
    if (images == null || images.isEmpty) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.Text('No image', style: pw.TextStyle(fontSize: 12, fontStyle: pw.FontStyle.italic)),
        ],
      );
    }

    List<pw.Widget> imageWidgets = [];
    for (var image in images) {
      var imageData = await getBytesFromAssetEntity(image);
      imageWidgets.add(
        pw.Container(
          margin: const pw.EdgeInsets.only(top: 8),
          child: pw.Image(pw.MemoryImage(imageData), width: 200, height: 200),
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        ...imageWidgets,
      ],
    );
  }


  static Future<List<pw.Widget>> buildImageSections(MainFormModel model) async {
    List<pw.Widget> sections = [];

    sections.add(await _buildImageSection('Front Side', model.frontSide));
    sections.add(await _buildImageSection('Left Side', model.leftSide));
    sections.add(await _buildImageSection('Right Side', model.rightSide));
    sections.add(await _buildImageSection('Back Side', model.backSide));
    sections.add(await _buildImageSection('Left Front Tire', model.leftFrontTire));
    sections.add(await _buildImageSection('Right Front Tire', model.rightFrontTire));
    sections.add(await _buildImageSection('Side Left Tires', model.sideLeftTires));
    sections.add(await _buildImageSection('Side Right Tires', model.sideRightTires));
    sections.add(await _buildImageSection('Left Rear Outside', model.leftRearOutside));
    sections.add(await _buildImageSection('Left Rear Inside', model.leftRearInside));
    sections.add(await _buildImageSection('Right Rear Outside', model.rightRearOutside));
    sections.add(await _buildImageSection('Right Rear Inside', model.rightRearInside));
    sections.add(await _buildImageSection('Trailer Left Side', model.trailerLeftSide));
    sections.add(await _buildImageSection('Trailer Right Side', model.trailerRightSide));
    sections.add(await _buildImageSection('Bestpass', model.bestpass));
    sections.add(await _buildImageSection('Tablet', model.tablet));
    sections.add(await _buildImageSection('ELD Device with Cable', model.eldDeviceWithCable));
    return sections;
  }
  
  static String _formatDate(DateTime date) {
    // 12/12/2023
    return '${date.month}/${date.day}/${date.year}';
  }

  static Future<Map<String, dynamic>> generateReport(MainFormModel mainFormModel) async {
    try {
      List<pw.Widget> imageSections = await buildImageSections(mainFormModel);

      final pdf = pw.Document();

      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Header(
              level: 0,
              child: pw.Text('Vehicle Inspection Report: ${mainFormModel.itemName}', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Text('Driver Name: ${mainFormModel.driverName}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Truck VIN: ${mainFormModel.truckVin}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Trailer Number: ${mainFormModel.trailerNumber}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Check-In Date: ${_formatDate(mainFormModel.dateCheckIn!)}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Check-Out Date: ${_formatDate(mainFormModel.dateCheckOut!)}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Mileage In: ${mainFormModel.mileageIn}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Mileage Out: ${mainFormModel.mileageOut}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('DEF Level: ${defLevelMap[mainFormModel.defLevel!]}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Fuel Level: ${fuelLevelMap[mainFormModel.fuelLevel!]}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Chains: ${mainFormModel.chains}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Scraps: ${mainFormModel.scraps}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Inverter: ${options[mainFormModel.inverter]}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('GPS for Truck: ${options[mainFormModel.gpsForTruck]}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('GPS for Trailer: ${options[mainFormModel.gpsForTrailer]}', style: const pw.TextStyle(fontSize: 14)),
            pw.Text('Fridge: ${options[mainFormModel.fridge]}', style: const pw.TextStyle(fontSize: 14)),
            pw.Header(
              level: 1,
              child: pw.Text('Images', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
            ),
            ...imageSections,

        ],)
      );

      // Get the current date and time
      DateTime now = DateTime.now();

      // Format the date and time into a string (for example, 'yyyy-MM-dd_HH-mm-ss')
      String formattedDateTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);

      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      
      // Create the file path with the date and time appended
      final filePath = '${directory.path}/InspectionReport_$formattedDateTime.pdf';

      // Save the PDF file
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      AppLog.log().e("File path: $filePath");
      AppLog.log().e("File name: $filePath");

      return {
        'filePath': filePath,
        'reportFile': file,
      };
    } catch (e) {
      AppLog.log().e("Error while generating report: $e");
      return Future.error('Failed to generate report due to an exception: $e');
    }
  }


  static Future<String> submitReport(ReportForm reportForm) async {
    try {
      final File reportFile = reportForm.reportFile!;
      final int itemId = reportForm.itemId!;
      final String columnId = reportForm.columnId.toString();

      String fileRef = await _uploadFile(reportFile, itemId, columnId);
      AppLog.log().i('Uploaded file ref: $fileRef');
      
      return fileRef;
    } catch (e) {
      AppLog.log().e("Error while submitting: $e");
      return Future.error('Failed to submit due to an exception: $e');
    }
  }
}
