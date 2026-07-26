import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final T? data;
  final String? errorMessage;

  const BaseState({this.isLoading = false, this.data, this.errorMessage});

  BaseState<T> copyWith({
    bool? isLoadingParam,
    T? dataParam,
    String? errorMessageParam,
  }) {
    return BaseState<T>(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam ?? errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, data, errorMessage];

  Widget when({required Widget Function() isLoading, required Widget Function() isLoadingParam, required Widget Function(T data) isSuccess}) {
    return switch (this) {
      BaseState(isLoading: true, data: var d) when d != null => isLoadingParam(),
      BaseState(isLoading: true) => isLoading(),
      BaseState(data: var d) when d != null => isSuccess(d as T),
      BaseState(errorMessage: var e) when e != null => Center(child: Text(e)),
      _ => const SizedBox.shrink(),
    };
  }
}
