enum StateStatus { initial, success, error, loading }

extension StateStatusX on StateStatus {
  bool get isInitial => this == StateStatus.initial;
  bool get isSuccess => this == StateStatus.success;
  bool get isError => this == StateStatus.error;
  bool get isLoading => this == StateStatus.loading;
}
