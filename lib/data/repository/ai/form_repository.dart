
import 'package:chuck2wiz/data/server/request/form/form_request.dart';

import '../../server/response/form/get_form_response.dart';
import '../../server/response/form/search_form_response.dart';

class FormRepository {
  Future<SearchFormResponse> searchForm(String option) async {
    return FormRequest().searchForm(option);
  }

  Future<GetFormResponse> getFormOptions() async {
    return FormRequest().getForm();
  }
}