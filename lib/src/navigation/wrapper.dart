import 'package:dear_diary/src/pages/diary_page_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth/auth_cubit.dart';
import '../pages/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..init(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            return const DiaryPage();
          }
          return const Login();
        },
      ),
    );
  }
}
