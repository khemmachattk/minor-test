import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minor_register/src/features/register/register.cubit.dart';
import 'package:minor_register/src/features/register/register_form.page.dart';
import 'package:minor_register/src/network/app_client.dart';
import 'package:minor_register/src/network/minor_api/minor_api.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<MinorApi>(
          create: (context) => MinorApi(client: AppClient()),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) {
            return RegisterCubit(
              minorApi: context.read<MinorApi>(),
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Minor International',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const RegisterFormPage(),
      ),
    );
  }
}
