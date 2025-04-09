import 'package:dartz/dartz.dart';

import '../error/failure.dart';


abstract class BaseUseCase<Input,Output>{
  Future<Either<Failure, Output>> execute(Input input);
}
abstract class StreamUseCase<Input, Output> {
  Stream<Either<Failure, Output>> execute(Input params);
}
class NoParams {}
