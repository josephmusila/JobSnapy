


import 'package:flutter_bloc/flutter_bloc.dart';


import '../../models/commentsModel.dart';
import '../../services/jobServices.dart';
import 'commentsState.dart';

class CommentsCubit extends Cubit<CommentState>{
  JobService jobService;

  CommentsCubit({required this.jobService}):super(CommentsInitialState());

  List<CommentsModel> comments=[];


  void getComments(String id) async{
      emit(CommentsLoadingState());
      try {
        comments = await jobService.getComments(id);
        if (comments.isEmpty){
          emit(NoCommentsState());
        }else{
          emit(CommentsLoadedState(comments));
        }
      } on Exception catch (e) {
       emit(CommentsLoadingErrorState(e.toString()));
      }
  }
}