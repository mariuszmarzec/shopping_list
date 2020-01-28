import 'package:equatable/equatable.dart';

class Resource<T extends Equatable> extends Equatable {
  final bool loading;
  final T data;
  final String error;

  Resource({
    this.loading = false,
    this.data,
    this.error});

  @override
  List<Object> get props => [loading, data, error];

  @override
  String toString() {
    return 'Resource{loading: $loading, data: $data, error: $error}';
  }
}