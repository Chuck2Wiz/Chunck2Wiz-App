class FormatDefines {
  static String formOptionFormat({required String option}) {
    final result = switch (option) {
      "TRAFFIC_ACCIDENT" => "교통사고",
      "DEFAMATION" => "명예훼손",
      "RENTAL" => "임대차",
      "DIVORCE" => "이혼",
      "ASSAULT" => "폭행",
      "FRAUD" => "사기",
      "SEX_CRIME" => "성범죄",
      "COPYRIGHT" => "저작권",
      _ => ""
    };

    return result;
  }
}