

import 'package:equatable/equatable.dart';

import '../../models/commentsModel.dart';

abstract class CommentState extends Equatable{

}

class CommentsInitialState extends CommentState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class CommentsLoadingState extends CommentState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class CommentsLoadedState extends CommentState{

List<CommentsModel> comments;
CommentsLoadedState(this.comments);
  @override
  // TODO: implement props
  List<Object?> get props => [comments];

}

class NoCommentsState extends CommentState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class CommentsLoadingErrorState extends CommentState{

  String message;
  CommentsLoadingErrorState(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];

}