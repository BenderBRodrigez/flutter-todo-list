import 'package:http/http.dart';

import '../utils.dart';

enum RequestActionType {
  request,
  success,
  fail,
}

class RequestPayload {
  final String key;
  final Future<Response> Function() request;

  RequestPayload({
    required this.key,
    required this.request,
  });
}

class ResponsePayload {
  final String key;
  final Response result;

  ResponsePayload({
    required this.key,
    required this.result,
  });
}

class ErrorPayload {
  final String key;
  final String error;

  ErrorPayload({
    required this.key,
    required this.error,
  });
}

class RequestAction extends ReduxAction<RequestPayload, RequestActionType> {
  RequestAction(RequestPayload payload)
      : super(payload, RequestActionType.request);
}

class RequestSuccessAction
    extends ReduxAction<ResponsePayload, RequestActionType> {
  RequestSuccessAction(ResponsePayload payload)
      : super(payload, RequestActionType.success);
}

class RequestFailAction extends ReduxAction<ErrorPayload, RequestActionType> {
  RequestFailAction(ErrorPayload payload)
      : super(payload, RequestActionType.fail);
}
