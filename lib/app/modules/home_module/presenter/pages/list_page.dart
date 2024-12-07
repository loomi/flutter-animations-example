import 'package:flutter/material.dart';

import 'components/animated_item.dart';
import 'components/placeholder_widget.dart';
import 'item_page.dart';

/// Uma página que exibe uma lista animada com menus e itens interativos.
///
/// Este componente aplica animações a várias partes da interface,
/// como menus deslizantes e uma lista de itens interativos.
/// As animações utilizam o `AnimationController` para coordenar
/// as transições de forma fluida.
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  int _selectedItemIndex = 0;

  late AnimationController _animationController;
  late Animation<Offset> _topMenuOffsetAnimation;
  late Animation<Offset> _filterBarOffsetAnimation;
  late Animation<Offset> _listOffsetAnimation;

  @override
  void initState() {
    super.initState();

    // Configura o controlador para gerenciar as animações.
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Animação do menu superior: desliza da direita (fora da tela) para o centro.
    // - Início: posição `Offset(1, 0)` (fora da tela à direita).
    // - Fim: posição `Offset(0, 0)` (posição original).
    // A curva da animação cobre 30% da duração total.
    _topMenuOffsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeInOut),
      ),
    );

    // Animação da barra de filtros: desliza com atraso, criando uma sequência.
    // - Início: posição `Offset(2, 0)` (fora da tela à direita).
    // - Fim: posição `Offset(0, 0)` (posição original).
    // A curva cobre 70% da duração total (começando após o menu superior).
    _filterBarOffsetAnimation = Tween<Offset>(
      begin: const Offset(2, 0),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Animação da lista de itens: desliza de baixo para cima.
    // - Início: posição `Offset(0, 2)` (fora da tela abaixo).
    // - Fim: posição `Offset(0, 0)` (posição original).
    // A curva cobre 70% da duração total, sincronizada com a barra de filtros.
    _listOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Inicia as animações ao carregar a página.
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _topMenu(), // Menu superior animado.
              const SizedBox(height: 10),
              _filterBar(), // Barra de filtros animada.
              const SizedBox(height: 10),
              Expanded(
                child: _list(), // Lista animada.
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Menu superior com animação de deslizamento lateral.
  Widget _topMenu() => SlideTransition(
        position: _topMenuOffsetAnimation,
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: PlaceholderWidget(
                color: Colors.grey.shade300,
                label: "Buscar",
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: PlaceholderWidget(
                color: Colors.grey.shade300,
                label: "Filtrar",
              ),
            ),
          ],
        ),
      );

  /// Barra de filtros com animação de deslizamento lateral.
  Widget _filterBar() => SlideTransition(
        position: _filterBarOffsetAnimation,
        child: SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemBuilder: (context, index) {
              bool isSelected = index == _selectedItemIndex;

              return PlaceholderWidget(
                onTap: () {
                  setState(() {
                    _selectedItemIndex = index; // Atualiza o item selecionado.
                  });
                },
                color: isSelected ? Colors.brown : Colors.white,
                border: Border.all(color: Colors.grey.shade800),
                label: "Item $index",
              );
            },
          ),
        ),
      );

  /// Lista de itens com animação de deslizamento vertical e hero transitions.
  Widget _list() => SlideTransition(
        position: _listOffsetAnimation,
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 5,
          children: List.generate(
            20,
            (index) => Hero(
              tag: index,
              child: AnimatedItem(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemPage(index: index),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
}
