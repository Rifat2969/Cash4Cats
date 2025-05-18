class ApiHelper {
  static String getToken() {
    return "Bearer 333|ifaPVXyesok9Iu2rJEiaOtlhgwtUQLuDQiCE4l8m";
  }

  static Map<String, String> getHeaders() {
    return {
      "Authorization": getToken(),
      "Content-Type": "application/json",
    };
  }
}
