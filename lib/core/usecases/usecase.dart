import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

abstract class UseCaseNoParams<Type> {
  Future<Type> call();
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

