class ApiHelper {
  static String getToken() {
    return "Bearer 355|H7pmJxymU0LvRp2r1ylPrqb8KsXVVfR6jZzSUDDH";
  }

  static Map<String, String> getHeaders() {
    return {
      "Authorization": getToken(),
      "Content-Type": "application/json",
    };
  }
}
