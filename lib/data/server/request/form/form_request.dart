import 'dart:convert';

import 'package:chuck2wiz/data/http/base_http.dart';
import 'package:chuck2wiz/data/server/response/form/get_form_response.dart';
import 'package:chuck2wiz/data/server/response/form/search_form_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FormRequest {
  static String BASE_URL = "${dotenv.env['API_URL']}/v1/form";

  Future<SearchFormResponse> searchForm(String option) async {
    final url = Uri.parse('$BASE_URL/$option');

    try {
      final response = await BaseHttp().get(url.toString());

      return SearchFormResponse.fromJson(jsonDecode(response));
    } catch(e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<GetFormResponse> getForm() async {
    final url = Uri.parse(BASE_URL);

    try {
      final response = await BaseHttp().get(url.toString());

      return GetFormResponse.fromJson(jsonDecode(response));
    } catch(e) {
      print('Error: $e');
      rethrow;
    }
  }
}