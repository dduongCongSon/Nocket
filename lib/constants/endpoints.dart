
import 'package:flutter_dotenv/flutter_dotenv.dart';

var apiUrl = 'http://10.0.2.2:8080/api/v1';
var ngrokUrl = 'https://c039-14-169-88-248.ngrok-free.app/api/v1';
var loginEndpoint = '$ngrokUrl/auth/login';
var loginEndpointMock = 'http://localhost:3002/users/login';
var userEndpoint = '$ngrokUrl/users';
var memberEndpoint = '$ngrokUrl/members';
var breederEndpoint = '$ngrokUrl/breeders';
var staffEndpoint = '$ngrokUrl/staffs';
var koiEndpoint = '$ngrokUrl/kois';
var auctionEndpoint = '$ngrokUrl/auctions';
var auctionKoiEndpoint = '$ngrokUrl/auctionkois';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? 'http://localhost:8080';
}