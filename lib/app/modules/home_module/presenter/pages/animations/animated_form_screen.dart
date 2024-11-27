import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/example_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:loomi_ui_flutter/loomi_ui.dart';

class AnimatedFormScreen extends StatefulWidget {
  const AnimatedFormScreen({super.key});

  @override
  State<AnimatedFormScreen> createState() => _AnimatedFormScreenState();
}

class _AnimatedFormScreenState extends State<AnimatedFormScreen> {
  final ExampleStore _exampleStore = GetIt.I.get<ExampleStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              const SizedBox(
                height: 80,
              ),
              // Campo de texto com animação de entrada deslizante
              const CustomTextFormField(
                backgroundColor: Colors.grey,
                filled: true,
              )
                  .animate()
                  // Desliza levemente da esquerda (10% da largura)
                  .slideX(begin: -.1, duration: 300.ms)
                  // Fade in simultâneo com duração maior
                  .fadeIn(duration: 600.ms),
              
              // Coluna de containers coloridos com animação de entrada
              Column(children: [
                ..._exampleStore.randomColors.map(
                  (e) {
                    return Container(
                      margin: const EdgeInsets.only(top: 12),
                      height: 80,
                      width: double.maxFinite,
                      color: e,
                    );
                  },
                )
              ])
                  .animate()
                  // Desliza da esquerda (50% da largura) após 400ms
                  .slideX(begin: -.5, delay: 400.ms, duration: 400.ms)
                  // Fade in com duração maior para suavizar a transição
                  .fadeIn(duration: 800.ms),
              
              const SizedBox(
                height: 20,
              ),
              
              // Botão com animação de escala
              const CustomButton(
                text: 'Teste',
                backgroundColor: Colors.blue,
              )
                  // Inicia a animação após 800ms (quando os elementos anteriores já apareceram)
                  .animate(
                    delay: 800.ms,
                  )
                  // Escala simultaneamente em X e Y, começando do tamanho 0
                  .scaleXY(
                    begin: 0,
                    duration: 400.ms,
                  )
            ]),
          ),
        ),
      );
    });
  }
}