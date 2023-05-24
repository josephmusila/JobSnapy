import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/colors.dart';
import '../cubits/comments/commentsCubits.dart';
import '../cubits/comments/commentsState.dart';
import '../widgets/commentsSection.dart';
import '../widgets/loadingScreen.dart';

class CommentsLogicScreen extends StatefulWidget {
  String id;

  CommentsLogicScreen({required this.id});

  @override
  State<CommentsLogicScreen> createState() => _CommentsLogicScreenState();
}

class _CommentsLogicScreenState extends State<CommentsLogicScreen> {
  @override
  void initState() {
    BlocProvider.of<CommentsCubit>(context).getComments(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<CommentsCubit, CommentState>(
        builder: (context, state) {
          if (state is CommentsInitialState) {
            return Container(
              height: 400,
              width: double.maxFinite,
              decoration: const BoxDecoration(color: AppColors.appMainColor2),
            );
          }
          if (state is CommentsLoadingState) {
            return Container(
              height: 300,
              child: Center(
                child: LoadingScreen(message: "Loading comments"),
              ),
            );
          }
          if (state is CommentsLoadedState) {
            return CommentSection(state.comments);
          }
          if (state is NoCommentsState) {
            return Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: 100,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  // color: AppColors.appMainColor2.withOpacity(0.5),
                ),
                child: const Center(
                  child: Text(
                    "No comments posted yet.",
                    style:
                        TextStyle(color: AppColors.appTextColor1, fontSize: 18),
                  ),
                ),
              ),
            );
          }
          if (state is CommentsLoadingErrorState) {
            return ErrorWidget(state.message);
          } else {
            return Container(
              height: 200,
              width: double.maxFinite,
              decoration: const BoxDecoration(color: AppColors.appMainColor1),
              child: const Center(
                child: Text(
                  "Server is Down",
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
