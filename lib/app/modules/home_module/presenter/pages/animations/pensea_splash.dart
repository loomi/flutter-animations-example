import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/shared/utils/assets.dart';
import 'package:flutter_leap_v2/shared/utils/custom_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PenseaSplash extends StatefulWidget {
  const PenseaSplash({super.key});

  @override
  State<PenseaSplash> createState() => _PenseaSplashState();
}

class _PenseaSplashState extends State<PenseaSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#010B3B"),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Primeira sequência de animações com três imagens
            Image.asset(
              getAssetImageUrl('pensea_1.png'),
            )
                .animate(
                  delay: 200.ms, // Aguarda 200ms antes de iniciar
                )
                // Escala uniformemente nos eixos X e Y por 250ms
                .scaleXY(duration: 250.ms)
                // Rotaciona levemente no sentido anti-horário (-0.1 radianos) por 250ms
                .rotate(begin: -.1, duration: 250.ms)
                .then() // Marca o fim da primeira sequência
                // Troca para a segunda imagem (pensea_2)
                .swap(
                  delay: 50.ms,
                  builder: (context, child) {
                    return Image.asset(
                      getAssetImageUrl('pensea_2.png'),
                    )
                        .animate()
                        // Fade in da segunda imagem em 200ms
                        .fadeIn(
                          duration: 200.ms,
                        )
                        // Escala de 0.7 até 1.2 com efeito easeIn
                        .scaleXY(
                            duration: 200.ms,
                            begin: .7,
                            end: 1.2,
                            curve: Curves.easeIn)
                        .then()
                        // Troca para a terceira imagem (pensea_3)
                        .swap(
                          delay: 50.ms,
                          builder: (context, child) {
                            return Image.asset(
                              getAssetImageUrl('pensea_3.png'),
                            )
                                .animate()
                                // Desliza para cima (começa em 0.9 e vai até 0)
                                .slideY(duration: 250.ms, begin: .9)
                                // Desaparece após 250ms em 50ms
                                .fadeOut(delay: 250.ms, duration: 50.ms);
                          },
                        );
                  },
                ),

            // Segunda sequência de animações - Logo e texto
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animação do logo (pensea_4)
                Image.asset(
                  getAssetImageUrl('pensea_4.png'),
                )
                    // Inicia após 1750ms do início da splash
                    .animate(delay: 1750.ms)
                    // Escala uniformemente por 250ms
                    .scaleXY(duration: 250.ms)
                    // Rotação leve anti-horária
                    .rotate(begin: -.1, duration: 250.ms)
                    .then()
                    // Segunda escala após 1000ms, de 0.8 até 1.1
                    .scaleXY(
                      delay: 1000.ms,
                      duration: 150.ms,
                      begin: .8,
                      end: 1.1,
                    )
                    .then()
                    // Desaparece após 150ms
                    .fadeOut(delay: 150.ms),

                const SizedBox(
                  height: 22,
                ),

                // Animação do texto (pensea_5)
                Image.asset(
                  getAssetImageUrl('pensea_5.png'),
                )
                    // Inicia após 2250ms do início da splash
                    .animate(delay: 2250.ms)
                    // Escala inicial de 0 a 0.75 em 250ms
                    .scaleXY(duration: 250.ms, begin: 0, end: .75)
                    // Desliza para cima simultaneamente
                    .slideY(duration: 250.ms, begin: .9)
                    .then()
                    // Segunda escala de 0.75 a 1 após 200ms
                    .scaleXY(
                      delay: 200.ms,
                      duration: 150.ms,
                      begin: .75,
                      end: 1,
                    )
                    .then()
                    // Terceira escala de 1 a 1.2 após 100ms
                    .scaleXY(
                      delay: 100.ms,
                      duration: 150.ms,
                      begin: 1,
                      end: 1.2,
                    )
                    .then()
                    // Desaparece após 150ms
                    .fadeOut(delay: 150.ms),
              ],
            )
          ],
        ),
      ),
    );
  }
}
