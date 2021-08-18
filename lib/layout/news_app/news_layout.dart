import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_project/layout/news_app/cubit/cubit.dart';
import 'package:train_project/layout/news_app/cubit/states.dart';
import 'package:train_project/network/remote/dio_helper.dart';
import 'package:train_project/shared/cubit/cubit.dart';

class NewslayOut extends StatelessWidget {
  const NewslayOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getSports()
        ..getScience(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, states) {},
        builder: (context, states) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      ),
    );
  }
}
