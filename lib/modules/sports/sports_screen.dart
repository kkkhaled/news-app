import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:train_project/layout/news_app/cubit/cubit.dart';
import 'package:train_project/layout/news_app/cubit/states.dart';
import 'package:train_project/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        builder: (context, state) {
          var list = NewsCubit.get(context).sports;
          return articleBuilder(list, context);
        },
        listener: (context, state) {});
  }
}
