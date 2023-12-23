import 'package:redux/redux.dart' as redux;
import 'package:redux_epics/redux_epics.dart';
import 'app_state.dart';
import 'package:mainform/pages/forms/main_form/main_form_reducer.dart';
import 'package:mainform/pages/forms/main_form/main_form_epics.dart';


GlobalState appStateReducer(GlobalState state, action) => GlobalState(
  appState: AppState(
    mainFormState: mainFormReducer(state.appState.mainFormState, action),
  ));

class GlobalState {
  AppState appState;

  GlobalState({required this.appState});
}

final epic = combineEpics<GlobalState>([
  ...mainFormEffects,

]);

final epicMiddleware = EpicMiddleware<GlobalState>(epic);

final initialState = GlobalState(
  appState: AppState(
    mainFormState: MainFormState.initial(),

));

var store = redux.Store<GlobalState>(appStateReducer,
  middleware: [epicMiddleware], initialState: initialState);