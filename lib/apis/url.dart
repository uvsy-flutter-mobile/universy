class UrlBuilder {
  final String resource;
  final Map<String, String> queryParams;
  static const PATH_START_SYMBOL = "?";
  static const EMPTY_QUERY_PARAMS = "";

  UrlBuilder({this.resource, this.queryParams});

  String build() {
    return _buildBaseURL() + resource + _getQueryParams();
  }

  String _getQueryParams() {
    if (queryParams != null) {
      List<String> queryKey = [];
      queryParams.forEach((key, value) => queryKey.add("$key=$value"));
      return PATH_START_SYMBOL + queryKey.join("&");
    }
    return EMPTY_QUERY_PARAMS;
  }

  String _buildBaseURL() {
    // TODO: Move to config
    var stage = "dev2";
    return "https://student-gw-$stage.universy.app";
  }
}
