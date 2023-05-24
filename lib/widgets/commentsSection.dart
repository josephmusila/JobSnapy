import 'package:flutter/material.dart';

import '../config/colors.dart';
import '../models/commentsModel.dart';

class CommentSection extends StatelessWidget {
  List<CommentsModel> comments;

  CommentSection(this.comments);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        comments.length,
        (index) => Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: AppColors.whiteColor1,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: Text(
              "${index + 1}.",
              style: const TextStyle(
                color: AppColors.appTextColor2,
                fontWeight: FontWeight.w500,
              ),
            ),
            title: Text(
              comments[index].comment == null
                  ? "Deleted Comment"
                  : comments[index].comment as String,
              style: const TextStyle(
                color: AppColors.appTextColor2,
              ),
            ),
            subtitle: Text(
              "${comments[index].postedBy.firstName} ${comments[index].postedBy.lastName}",
              style: const TextStyle(
                color: AppColors.appTextColor1,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
      ),
    );
  }
}
