import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutenberg_app/env/env.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/main/navbar_cubit.dart';
import 'package:flutter_gutenberg_app/src/presentation/views/main/main_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Navigation', () {
    testWidgets('Initial page is HomeView', (WidgetTester tester) async {
      // arrange
      final mockNavbarCubit = NavbarCubit();

      // find
      final homeText = find.text('Home');
      final bookshelfText = find.text('Bookshelf');
      final likedText = find.text('Liked');
      final settingsText = find.text('Settings');

      // test
      await tester.pumpWidget(BlocProvider<NavbarCubit>(
        create: (context) => mockNavbarCubit,
        child: MaterialApp(
          title: Env.appName,
          home: const MainView(),
        ),
      ));
      await tester.pumpAndSettle();

      // expect
      expect(homeText, findsAny);
      expect(bookshelfText, findsOneWidget);
      expect(likedText, findsOneWidget);
      expect(settingsText, findsOneWidget);
    });
  });
}
