class GetErrorMessage {
  static String fromApiResponse(Map response) {
    response = Map.from(response['errors']);
    var error = response[response.keys.first].first;
    String errorMessage = error['message'];
    if (errorMessage == null)
      errorMessage = error['code'];
    return errorMessage;
  }
}