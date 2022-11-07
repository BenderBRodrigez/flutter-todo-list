class RequestNestedState {
  final bool loading;
  final bool loaded;
  final String? error;
  final dynamic data;

  RequestNestedState({
    required this.loading,
    required this.loaded,
    this.error,
    this.data,
  });
}

class RequestState {
  final Map<String, RequestNestedState> requests;

  RequestState(this.requests);

  RequestState update({
    required String key,
    required RequestNestedState request,
  }) {
    Map<String, RequestNestedState> newRequests = {};
    requests.forEach((key, value) => newRequests[key] = value);
    newRequests[key] = request;
    return RequestState(newRequests);
  }
}
