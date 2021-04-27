abstract class Mapper<I, O> {
  Mapper._();

  O call(I input);
}
