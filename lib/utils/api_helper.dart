class ApiHelper {
  static String getToken() {
    return "Bearer 351|OK9sWSdiXx8HIe2aBDLsr7WRvx7eenJrjtP9iCq8";
  }

  static Map<String, String> getHeaders() {
    return {
      "Authorization": getToken(),
      "Content-Type": "application/json",
    };
  }
}
