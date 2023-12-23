// import 'package:flutter_dotenv/flutter_dotenv.dart';

// abstract class Environments {
//   static String backendServiceBaseUrl = dotenv.env['BACKEND_SERVICE_BASE_URL'] ?? 'https://api.monday.com/v2';
//   static String mondayDotComApiKey = dotenv.env['MONDAY_DOT_COM_API_KEY'] ?? '';
//   static String mondayDotComCookie = dotenv.env['COOKIE'] ?? '';
//   static String appName = dotenv.env['APP_NAME'] ?? 'DemoApp';
//   static String showDebugBanner = dotenv.env['SHOW_DEBUG_BANNER'] ?? 'false';
// }


abstract class Environments {

  static String backendServiceBaseUrl = 'https://api.monday.com/v2';
  static String mondayDotComApiKey =  'eyJhbGciOiJIUzI1NiJ9.eyJ0aWQiOjMwMTA3NDQ2MywiYWFpIjoxMSwidWlkIjoyMjkxNTc4NSwiaWFkIjoiMjAyMy0xMi0wNlQxNTozNTozOS4wMDBaIiwicGVyIjoibWU6d3JpdGUiLCJhY3RpZCI6NTE1ODg2MCwicmduIjoidXNlMSJ9.hoD-OLrYqlT3GhPyipNi2aen69E78gZqoL3RHRfWxhM';
  static String mondayDotComCookie = '';
  static String appName = 'wechat_assets_picker_demo';
  static String showDebugBanner = 'false';
  static int truckFilesBoardId = 468543117;
  static int myBoard = 5662775202;
  static int limit_500 = 500;
  static String reportColumnId = "truck_report";
}