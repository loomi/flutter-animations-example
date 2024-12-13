import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/stores/example_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class AnimatedShimmerListScreen extends StatefulWidget {
  const AnimatedShimmerListScreen({super.key});

  @override
  State<AnimatedShimmerListScreen> createState() =>
      _AnimatedShimmerListScreenState();
}

class _AnimatedShimmerListScreenState extends State<AnimatedShimmerListScreen> {
  final ExampleStore _exampleStore = GetIt.I.get<ExampleStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            // Stack com animações combinadas para criar um efeito de entrada
            Stack(
              alignment: Alignment.center,
              children: [
                // Container com animação de deslizamento horizontal e fade
                Container(
                  height: 50,
                  width: 50,
                  color: Colors.black,
                )
                    // Encadeia múltiplas animações usando .animate()
                    .animate()
                    // Desliza horizontalmente com delay de 300ms e duração de 600ms
                    // begin: 0 (posição inicial) até end: -1.5 (1.5x a largura para esquerda)
                    .slideX(
                        begin: 0, end: -1.5, delay: 300.ms, duration: 600.ms)
                    // Animação de fade in com duração de 600ms sem delay
                    .fadeIn(duration: 600.ms, delay: 0.ms),
                
                // Texto com animação de escala horizontal
                const Text('TESTE TESTE')
                    // Inicia a animação após 500ms
                    .animate(delay: 500.ms)
                    // Escala horizontalmente a partir de 0, alinhado à esquerda
                    .scaleX(
                        begin: 0,
                        alignment: Alignment.centerLeft,
                        duration: 400.ms),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Lista de containers com efeito shimmer
            Column(
                children: [
              ..._exampleStore.randomColors.map(
                (e) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    height: 100,
                    width: double.maxFinite,
                    color: e,
                  )
                  // Adiciona efeito shimmer individual a cada container
                  .animate()
                  .shimmer(duration: 1500.ms);
                },
              )
            ]
                    // Animações aplicadas a todo o grupo de containers
                    .animate(
                      // Intervalo entre o início da animação de cada item
                      interval: 300.ms,
                      // Atraso inicial antes de começar as animações
                      delay: 1500.ms,
                    )
                    // Fade in com duração de 750ms
                    .fadeIn(duration: 750.ms)
                    // Efeito shimmer aplicado a toda a lista
                    .shimmer(duration: 1500.ms)),
          ]),
        ),
      );
    });
  }
}