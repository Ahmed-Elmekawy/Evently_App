import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';

import '../../../../../core/constants/constants_manager.dart';
import '../../../../../core/widgets/event_item.dart';
import '../view_model/bloc/home_bloc.dart';
import '../view_model/bloc/home_event.dart';
import '../view_model/bloc/home_state.dart';
import 'widgets/home_header.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late AppLocalizations appLocalizations;
  late CategoryModel selectedCategory;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLocalizations = AppLocalizations.of(context)!;
    selectedCategory = CategoryModel.getCategoriesWithAll(context)[0];
    context.read<HomeBloc>().add(
      FetchEvents(selectedCategory: selectedCategory),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        UserModel? user;
        if (authState is AuthSuccess) {
          user = authState.user;
        }
        return SafeArea(
          child: Column(
            children: [
              HomeHeader(user: user),
              SizedBox(height: 24.h),
              CustomTabBar(
                categories: CategoryModel.getCategoriesWithAll(context),
                onCategoryItemClicked: (newCategory) {
                  setState(() {
                    selectedCategory = newCategory;
                  });
                  context.read<HomeBloc>().add(
                    FetchEvents(selectedCategory: selectedCategory),
                  );
                },
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading || state is HomeInitial) {
                    return const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is HomeError) {
                    return Expanded(child: Center(child: Text(state.message)));
                  }
                  if (state is HomeLoaded) {
                    if (state.events.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            appLocalizations.no_events_found,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        itemBuilder: (context, index) => EventItem(
                          event: state.events[index],
                          markAsFavourite:
                              user?.favouriteEventsIds.contains(
                                state.events[index].id,
                              ) ??
                              false,
                          user: user,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: state.events.length,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
