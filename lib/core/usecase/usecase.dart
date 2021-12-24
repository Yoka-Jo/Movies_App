import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/error/failure.dart';

abstract class UseCase<T,P>{
  Future<Either<Failure,T>> call(P params);
}

class NoParams {}
class Params extends Equatable{
  final int id;

  const Params(this.id);

  @override
  List<Object?> get props => [id];
}