import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutenberg_app/src/presentation/views/main/bookshelf/bookshelf_view.dart';
import 'package:flutter_gutenberg_app/src/presentation/views/main/home/home_view.dart';
import 'package:flutter_gutenberg_app/src/presentation/views/main/liked/liked_view.dart';
import 'package:flutter_gutenberg_app/src/presentation/views/main/settings/settings_view.dart';
import '../../blocs/main/navbar_cubit.dart';
import 'widgets/custom_snake_navigation_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildPageView() {
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state) {
        return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: context.read<NavbarCubit>().controller,
          children: const [
            HomeView(),
            // BookshelfView(),
            LikedView(),
            // SettingsView(),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: BlocBuilder<NavbarCubit, int>(
        builder: (context, state) {
          return CustomSnakeNavigationBar(
            currentIndex: state,
            onTap: (index) {
              FocusScope.of(context).unfocus();
              context.read<NavbarCubit>().controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.linear,
                  );
              context.read<NavbarCubit>().update(index);
            },
          );
        },
      ),
    );
  }
}
