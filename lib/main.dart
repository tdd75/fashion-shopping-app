import 'package:fashion_shopping_app/modules/home/bloc/cubit/product_cubit.dart';
import 'package:fashion_shopping_app/modules/home/data/repository/product_repository.dart';
import 'package:fashion_shopping_app/modules/home/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fashion_shopping_app/core/widgets/loading/loading_circle.dart';
import 'package:fashion_shopping_app/modules/auth/bloc/cubit/login_cubit.dart';
import 'package:fashion_shopping_app/modules/auth/data/repository/auth_repository.dart';
import 'package:fashion_shopping_app/modules/auth/views/welcome_view.dart';
import 'package:fashion_shopping_app/modules/layout/bloc/cubit/layout_cubit.dart';
import 'package:fashion_shopping_app/core/theme/app_theme.dart';
import 'package:fashion_shopping_app/core/theme/theme_cubit.dart';
import 'package:fashion_shopping_app/modules/auth/bloc/cubit/auth_cubit.dart';
import 'package:fashion_shopping_app/modules/layout/views/layout_view.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repositoryList = [
      RepositoryProvider(create: (context) => AuthRepository()),
      RepositoryProvider(create: (context) => ProductRepository()),
    ];
    final blocList = [
      BlocProvider(create: (context) => ThemeCubit()),
      BlocProvider(create: (context) => AuthCubit()),
      BlocProvider(
        create: (context) => LoginCubit(
          authRepository: context.read<AuthRepository>(),
        ),
      ),
      BlocProvider(create: (context) => LayoutCubit()),
      BlocProvider(
        create: (context) => ProductCubit(
          productRepository: context.read<ProductRepository>(),
        ),
      ),
    ];

    return MultiRepositoryProvider(
      providers: repositoryList,
      child: MultiBlocProvider(
        providers: blocList,
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) => MaterialApp(
            title: 'Fashion Shopping App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            home: FutureBuilder(
                future: context.read<AuthCubit>().tryAutoLogin(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(body: LoadingCircle());
                  } else {
                    final isLogin = snapshot.data;
                    return isLogin == true
                        ? const LayoutView()
                        : const WelcomeView();
                  }
                }),
            routes: {
              LayoutView.routeName: (ctx) => const LayoutView(),
              WelcomeView.routeName: (ctx) => const WelcomeView(),
              SearchView.routeName: (ctx) => const SearchView(),
            },
          ),
        ),
      ),
    );
  }
}
