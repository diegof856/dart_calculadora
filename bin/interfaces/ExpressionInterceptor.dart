import '../context/ExpressionContext.dart';

abstract class ExpressionInterceptor {
  void intercept(ExpressionContext context);
}