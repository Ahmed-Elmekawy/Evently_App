import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import '../../../../../core/widgets/event_item.dart';
import '../view_model/bloc/favourite_bloc.dart';
import '../view_model/bloc/favourite_event.dart';
import '../view_model/bloc/favourite_state.dart';

class FavouriteTab extends StatefulWidget {
  const FavouriteTab({super.key});

  @override
  State<FavouriteTab> createState() => _FavouriteTabState();
}

class _FavouriteTabState extends State<FavouriteTab> {
  String searchQuery = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<FavouriteBloc>().add(FetchFavourites(authState.user));
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return SafeArea(
      child: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: appLocalizations.search_for_event,
              suffixIcon: const Icon(Icons.search),
              onChanged: (value) {
                setState(() {
                  searchQuery = value!.trim();
                });
              },
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  UserModel? user;
                  if (authState is AuthSuccess) {
                    user = authState.user;
                  }

                  return BlocConsumer<FavouriteBloc, FavouriteState>(
                    listener: (context, state) {
                      if (state is FavouriteError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is FavouriteLoading ||
                          state is FavouriteInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is FavouriteLoaded) {
                        final favouriteEvents = state.events;

                        if (favouriteEvents.isEmpty) {
                          return Center(
                            child: Text(
                              appLocalizations.no_events_found,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
                        }

                        final filteredEvents = favouriteEvents.where((event) {
                          return event.title?.toLowerCase().contains(
                                searchQuery.toLowerCase(),
                              ) ??
                              false;
                        }).toList();

                        if (filteredEvents.isEmpty) {
                          return Center(
                            child: Text(
                              appLocalizations.no_events_found,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
                        }

                        return ListView.separated(
                          itemBuilder: (context, index) => EventItem(
                            event: filteredEvents[index],
                            markAsFavourite:
                                user?.favouriteEventsIds.contains(
                                  filteredEvents[index].id,
                                ) ??
                                true,
                            user: user,
                          ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: filteredEvents.length,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
