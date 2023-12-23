import 'dart:async';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mainform/store/app_logs.dart';
import 'package:mainform/store/app_store.dart';
import 'package:mainform/pages/forms/main_form/main_form_service.dart';
import 'package:mainform/pages/forms/main_form/main_form_reducer.dart';


Stream<dynamic> submitMainFormEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is SubmitMainFormAction)
      .asyncMap((action) => MainFormService.submitMainForm(action.mainFormModel))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            SubmitMainFormSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction(error.toString()),
          ]));
}


Stream<dynamic> getVINsAndDriverNameListEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetVINsAndDriverNameListAction)
      .asyncMap((action) => MainFormService.getVINsTrailerNumAndDriverNameList())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetVINsAndDriverNameListActionSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction(error.toString()),
          ]));
}


Stream<dynamic> submitReportEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is SubmitReportAction)
      .asyncMap((action) => MainFormService.submitReport(action.reportForm))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            SubmitReportActionSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction(error.toString()),
          ]));
}

Stream<dynamic> generateReportEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GenerateReportAction)
      .asyncMap((action) => MainFormService.generateReport(action.mainFormModel))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GenerateReportActionSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction(error.toString()),
          ]));
}


List<Stream<dynamic> Function(Stream<dynamic>, EpicStore<GlobalState>)> mainFormEffects = [
  submitMainFormEpic,
  getVINsAndDriverNameListEpic,
  submitReportEpic,
  generateReportEpic,
];