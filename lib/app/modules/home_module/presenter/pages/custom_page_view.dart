import 'package:flutter/material.dart';

class CustomPageView extends StatefulWidget {
  final List<Widget> pages;
  final Color backgroundColor;

  const CustomPageView({
    super.key,
    required this.pages,
    this.backgroundColor = Colors.white,
  });

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Página ${_currentPage.toString()}",
        ),
        backgroundColor: Colors.grey.shade400,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: _currentPage > 0 ? _previousPage : null,
          disabledColor: Colors.white.withOpacity(0.3),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed:
                _currentPage < widget.pages.length - 1 ? _nextPage : null,
            disabledColor: Colors.white.withOpacity(0.3),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: widget.pages,
      ),
    );
  }
}
