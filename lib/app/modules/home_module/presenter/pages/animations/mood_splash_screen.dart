import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_leap_v2/shared/utils/assets.dart';

class MoodSplashScreen extends StatefulWidget {
  const MoodSplashScreen({super.key});

  @override
  State<MoodSplashScreen> createState() => _MoodSplashScreenState();
}

// Usa TickerProviderStateMixin para suportar múltiplos AnimationController
class _MoodSplashScreenState extends State<MoodSplashScreen>
    with TickerProviderStateMixin {
  // Controllers para controlar diferentes grupos de animações independentemente
  late AnimationController
      _controller; // Controla elementos decorativos (retângulos)
  late AnimationController _logoController; // Controla logo e background

  @override
  void initState() {
    // Inicialização dos controllers sem duração definida
    // Serão controlados manualmente através das animações
    _controller = AnimationController(
      vsync: this,
    );
    _logoController = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Background com imagem de fundo
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  getAssetImageUrl('splash_mood.png'),
                ),
              ),
            ),
          )
              .animate(
                // Desativa autoPlay para controle manual
                autoPlay: false,
                controller: _logoController,
              )
              // Fade in do background em 750ms
              .fade(
                begin: 0,
                end: 1,
                duration: 750.ms,
              ),

          // Logo central
          SizedBox(
            width: constraints.maxWidth / 2,
            child: Image.asset(
              getAssetImageUrl('mood_name_logo.png'),
              fit: BoxFit.fitWidth,
            ),
          )
              .animate(
                controller: _logoController,
                // Sequência de animações após completar
                onComplete: (controller) async {
                  await Future.delayed(1050.ms); // Espera 1050ms
                  await _controller
                      .reverse(); // Reverte animações dos retângulos
                  await Future.delayed(500.ms); // Espera mais 500ms
                  await _logoController.reverse(); // Reverte logo e background
                },
              )
              // Fade in do logo em 1000ms
              .fade(
                begin: 0,
                end: 1,
                duration: 1000.ms,
              )
              // Escala do logo de 0 a 1 em 1000ms
              .scaleXY(
                begin: 0,
                end: 1,
                duration: 1000.ms,
              ),

          // Retângulo superior direito
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: constraints.maxWidth / 1.8,
              child: Image.asset(
                getAssetImageUrl('retangle_top.png'),
                fit: BoxFit.fitWidth,
              ),
            )
                .animate(
                  controller: _controller,
                  delay: 1000.ms, // Espera 1s antes de iniciar
                )
                // Fade in em 750ms
                .fade(
                  begin: 0,
                  end: 1,
                  duration: 750.ms,
                )
                // Move horizontalmente da direita (100px) para posição original
                .moveX(
                  begin: 100,
                  end: 0,
                  duration: 750.ms,
                )
                // Move verticalmente de cima (-100px) para posição original
                .moveY(
                  begin: -100,
                  end: 0,
                  duration: 750.ms,
                ),
          ),
          // Retângulo inferior esquerdo
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: constraints.maxWidth / 1.2,
              child: Image.asset(
                getAssetImageUrl('retangle_bottom.png'),
                fit: BoxFit.fitWidth,
              ),
            )
                .animate(
                  controller: _controller,
                  delay: 1000.ms, // Espera 1s antes de iniciar
                )
                // Fade in em 750ms
                .fade(
                  begin: 0,
                  end: 1,
                  duration: 750.ms,
                )
                // Move horizontalmente da esquerda (-100px) para posição original
                .moveX(
                  begin: -100,
                  end: 0,
                  duration: 750.ms,
                )
                // Move verticalmente de baixo (100px) para posição original
                .moveY(
                  begin: 100,
                  end: 0,
                  duration: 750.ms,
                ),
          ),
        ],
      );
    });
  }
}
