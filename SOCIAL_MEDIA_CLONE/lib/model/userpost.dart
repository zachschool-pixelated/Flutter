import 'usercomment.dart';

class Userpost {
  final String userimg;
  final String username;
  final String time;
  final String postcontent;
  final String postimg;
  final String numcomments;
  final String numshare;
  bool isLiked;

  /// Comments added by the user (saved on the device).
  final List<Usercomment> addedComments = [];

  /// Sample count plus the comments the user added.
  String get commentCount =>
      '${(int.tryParse(numcomments) ?? 0) + addedComments.length}';

  Userpost({
    required this.userimg,
    required this.username,
    required this.time,
    required this.postcontent,
    required this.postimg,
    required this.numcomments,
    required this.numshare,
    required this.isLiked,
  });
}
