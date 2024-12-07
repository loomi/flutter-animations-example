import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/components/placeholder_widget.dart';

/// Um widget que aplica uma animação de escala ao interagir com o usuário.
///
/// Este componente encapsula outro widget e aplica uma animação de redução
/// de escala quando o item é pressionado, criando uma sensação de clique
/// tátil e responsivo.
class AnimatedItem extends StatefulWidget {
  const AnimatedItem({
    super.key,
    this.onTap,
  });

  /// Callback acionado quando o widget é clicado.
  final VoidCallback? onTap;

  @override
  State<AnimatedItem> createState() => _AnimatedItemState();
}

class _AnimatedItemState extends State<AnimatedItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Configura o controlador da animação com duração de 150ms, o que
    // garante que a interação seja rápida e responsiva.
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    // Define a animação de escala. A transformação ocorre entre:
    // - `1.0` (tamanho original)
    // - `0.95` (reduzido em 5%).
    // Utiliza uma curva `easeInOut` para suavizar o movimento no início
    // e no final da animação.
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          // Aplica a transformação de escala ao widget filho.
          scale: _buttonScaleAnimation.value,
          child: PlaceholderWidget(
            onTap: () async {
              // Executa a animação de pressionar e soltar.
              await _animationController.forward(); // Reduz o tamanho.
              await _animationController
                  .reverse(); // Retorna ao tamanho original.
              widget.onTap?.call(); // Executa o callback de interação.
            },
            radius: 20,
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade800,
            ),
            child: PlaceholderWidget(
              radius: 30,
              color: Colors.grey.shade300,
              label: "Imagem",
            ),
          ),
        );
      },
    );
  }
}
