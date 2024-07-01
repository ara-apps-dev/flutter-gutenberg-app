import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutenberg_app/env/env.dart';
import 'package:flutter_gutenberg_app/src/domain/usecase/book/get_book_usecase.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/book/book_bloc.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/book/book_event.dart';
import 'package:flutter_gutenberg_app/src/presentation/blocs/book_detail/book_detail_event.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'presentation/blocs/book_detail/book_detail_bloc.dart';
import 'presentation/blocs/filter/filter_cubit.dart';
import 'presentation/blocs/main/navbar_cubit.dart';
import 'core/services/services_locator.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavbarCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<BookBloc>()..add(const GetBooks(FilterBookParams())),
        ),
        BlocProvider(
          create: (context) =>
              di.sl<BookDetailBloc>()..add(const GetBookDetail(0)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
        title: Env.appName,
        theme: AppTheme.lightTheme(context),
      ),
    );
  }
}
