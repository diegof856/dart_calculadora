import '../interfaces/ExpressionInterceptor.dart';
import '../context/ExpressionContext.dart';

class Expressionexecute implements ExpressionInterceptor {
  @override
  void intercept(ExpressionContext context) {
    final regex = RegExp(r'(\d+)([+\-*/])(\d+)');

    while (regex.hasMatch(context.expression)) {
      context.expression = context.expression.replaceFirstMapped(regex, (encontrado) {
        final a = int.parse(encontrado.group(1)!);
        final operador = encontrado.group(2)!;
        final b = int.parse(encontrado.group(3)!);

        switch (operador) {
          case '+':
            return (a + b).toString();
          case '-':
            return (a - b).toString();
          case '*':
            return (a * b).toString();
          case '/':
            if (b == 0) {
              throw Exception("Erro: Divisão por zero!");
            }
            return (a ~/ b).toString();
          default:
            throw Exception("Operador desconhecido: $operador");
        }
      });
    }
  }
}