import 'package:args/args.dart';
import 'dart:io';
import './context/ExpressionContext.dart';
import './interceptors/InterceptorChain.dart';
import './interceptors/ExpressionExecute.dart';



const String version = '0.0.1';



void main() {
  final chain = InterceptorChain();
  chain.addInterceptor(Expressionexecute());
  while (true) {
    stdout.write("Digite a expressão (ou 's' para sair): \n");
    String? input = stdin.readLineSync();

    if (input == null) continue;
    if (input.toLowerCase() == 's') break;

    var context = ExpressionContext(input);

    try {
      chain.execute(context);
      print("Resultado: ${context.expression}\n");
    } catch (e) {
      print("Erro: $e\n");
    }
  }


}
