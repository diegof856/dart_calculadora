import '../interfaces/ExpressionInterceptor.dart';
import '../context/ExpressionContext.dart';
class InterceptorChain {
  final List<ExpressionInterceptor> _interceptors = [];

  void addInterceptor(ExpressionInterceptor interceptor) {
    _interceptors.add(interceptor);
  }

  void execute(ExpressionContext context) {
    for (var interceptor in _interceptors) {
      interceptor.intercept(context);
    }
  }
}