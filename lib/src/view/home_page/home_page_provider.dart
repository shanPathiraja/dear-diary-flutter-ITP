import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_bloc.dart';
import 'home_event.dart';
import 'home_page.dart';

class HomePageProvider extends BlocProvider<HomePageBloc> {
  HomePageProvider({Key? key})
      : super(
          key: key,
          create: (context) => HomePageBloc()..add(GetPosts()),
          child: const HomePage(),
        );
}
