import 'package:http/http.dart' as http;
import 'package:tour_and_travel/core/variables.dart';
import 'package:tour_and_travel/models/base_error_response.dart';
import 'package:tour_and_travel/models/ticket_response.dart';
import 'package:tour_and_travel/models/transaction_history_response.dart';
import 'package:tour_and_travel/models/transaction_request.dart';
import 'package:tour_and_travel/services/auth_service.dart';
import 'package:http_parser/http_parser.dart';

class TransactionService {
  final authService = AuthService();

  Future<List<Ticket>> getTickets() async {
    final token = await authService.getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/jurusan'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final result = ticketResponseFromJson(response.body);
      return result.data ?? [];
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }

  Future<List<TransactionHistory>> getTransactionHistories() async {
    final token = await authService.getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/transaksi/me'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final result = transactionHistoryResponseFromJson(response.body);
      return result.data ?? [];
    } else {
      final errorModel = baseErrorResponseFromJson(response.body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }

  Future<bool> createTransaction(TransactionRequest requestBody) async {
    final token = await authService.getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variables.baseUrl}/transaksi'),
    );

    const mimeType = 'image/jpeg';
    final file = await http.MultipartFile.fromPath(
      'image',
      requestBody.file.path,
      contentType: MediaType.parse(mimeType),
    );
    request.files.add(file);
    request.headers.addAll(headers);
    request.fields.addAll(requestBody.toJson());

    http.StreamedResponse response = await request.send();
    final body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return true;
    } else {
      final errorModel = baseErrorResponseFromJson(body);
      throw errorModel.message ?? 'Error ${response.statusCode}';
    }
  }
}
