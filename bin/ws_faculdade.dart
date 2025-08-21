import 'dart:io';
import 'package:expressions/expressions.dart';

const String version = '0.0.1';

void main() {

  try {

    stdout.write("Digite a expressão (ou 's' para sair): \n");
    while (true) {
      String? expressao = stdin.readLineSync();
      if (expressao == null) continue;
      ValidarEntradaExpressao.validar(expressao);
      if (expressao.toLowerCase() == 's') break;
      stdout.write(
          "Escolha uma das duas estrategias de calculo:\n1 - Estrategia de calculo interno\n2 - Biblioteca externa\nEscolha: ");
      String? escolha = stdin.readLineSync();
      if (escolha == null) continue;
        ValidarEntradaUmOuDois.validar(escolha);

      if (escolha == "1") {
        var context = ExpressionContext(StrategyPrimarioInterno());
        print("Resultado usando uma estrategia de calculo propria: ${context
            .execute(expressao)}");
      } else {
        var context = ExpressionContext(StrategyExternoSegundario());
        print(
            "Resultado usando uma estrategia de execução atravez de uma biblioteca: ${context
                .execute(expressao)}");
      }
    }
  }catch (e) {
    print("$e");
  }
}
abstract class ExpressionStrategy {
  double avaliar(String expression);
}

class ValidarEntradaExpressao {
  static void validar(String obj) {
    if (obj.toLowerCase() == 's') return;
    RegExp validChars = RegExp(r'^[0-9+\-*/\s]+$');
    if (!validChars.hasMatch(obj)) {
      throw Exception(
          "Expressão inválida! Apenas números e operadores + - * / são permitidos.");
    }
  }
}
class ValidarEntradaUmOuDois {
  static void validar(String obj) {
    if (obj != "1" && obj != "2") {
      throw Exception("Só é permitido 1 ou 2");
    }
  }

}


class ExpressionContext {
  ExpressionStrategy _strategy;
  ExpressionContext(this._strategy);

  void setStrategy(ExpressionStrategy strategy) {
    _strategy = strategy;
  }

  double execute(String expression) {
    return _strategy.avaliar(expression);
  }
}
class StrategyPrimarioInterno implements ExpressionStrategy {
  @override
  double avaliar(String expression) {
      final result = _calculate(expression);
      return result;
  }

}
class StrategyExternoSegundario implements ExpressionStrategy {
  @override
  double avaliar(String expression) {
    final parsed = Expression.parse(expression);
    final evaluator = const ExpressionEvaluator();
    final result = evaluator.eval(parsed, {});
    if (result is num) {
      return result.toDouble();
    }
    throw Exception("Não foi possível avaliar a expressão: $expression");
  }
}
double _calculate(String expr) {
  List<String> operators = [];
  List<double> values = [];
  RegExp opRegex = RegExp(r'[\+\-\*\/]');

  for (var part in expr.split('')) {
    if (opRegex.hasMatch(part)) {
      operators.add(part);
    }
  }
  values = expr.split(opRegex)
      .map((e) => double.parse(e.trim()))
      .toList();

  for (int i = 0; i < operators.length; i++) {
    if (operators[i] == '*' || operators[i] == '/') {
      double valor_A= values[i];
      double valor_B = values[i + 1];
      if (operators[i] == '/' && valor_B == 0) {
        throw Exception("Erro: divisão por zero não é permitida!");
      }
      double resultado = operators[i] == '*' ? valor_A * valor_B : valor_A / valor_B;
      values[i] = resultado;
      values.removeAt(i + 1);
      operators.removeAt(i);
      i--;
    }
  }
  double result = values[0];
  for (int i = 0; i < operators.length; i++) {
    if (operators[i] == '+') {
      result += values[i + 1];
    } else if (operators[i] == '-') {
      result -= values[i + 1];
    }
  }
  return result;
}

