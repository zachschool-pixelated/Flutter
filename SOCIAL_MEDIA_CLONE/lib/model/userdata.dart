import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class Userdata {
  // One shared instance so every screen sees the same posts and comments.
  static final Userdata _instance = Userdata._();
  factory Userdata() => _instance;
  Userdata._();

  static String _key(int postIndex) => 'comments_post_$postIndex';

  /// Loads the comments the user added in earlier sessions.
  Future<void> loadComments() async {
    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < userList.length; i++) {
      final raw = prefs.getString(_key(i));
      if (raw == null) continue;
      userList[i].addedComments
        ..clear()
        ..addAll(
          (jsonDecode(raw) as List).map(
            (e) => Usercomment.fromJson(e as Map<String, dynamic>),
          ),
        );
    }
  }

  /// Adds a comment from the logged-in account and saves it.
  Future<void> addComment(int postIndex, String text) async {
    final content = text.trim();
    if (content.isEmpty) return;
    final post = userList[postIndex];
    post.addedComments.add(
      Usercomment(
        commenterImg: myUserAccount.img,
        commenterName: myUserAccount.name,
        commentTime: '',
        commentContent: content,
        createdAt: DateTime.now(),
      ),
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _key(postIndex),
      jsonEncode(post.addedComments.map((c) => c.toJson()).toList()),
    );
  }

  List<Userpost> userList = [
    Userpost(
      userimg: 'assets/person1.jfif',
      username: 'John Doe',
      time: '2 hrs ago',
      postcontent: 'Had a great day at the beach!',
      postimg: 'assets/pavlova.jpg',
      numcomments: '24',
      numshare: '5',
      isLiked: false,
    ),
    Userpost(
      userimg: 'assets/person2.jfif',
      username: 'Jane Smith',
      time: '3 hrs ago',
      postcontent: 'Loving the new cafe in town.',
      postimg: 'assets/pavlova_main.jfif',
      numcomments: '18',
      numshare: '3',
      isLiked: true,
    ),
    Userpost(
      userimg: 'assets/person3.jfif',
      username: 'Mike Johnson',
      time: '5 hrs ago',
      postcontent: 'Just finished a 10k run!',
      postimg: 'assets/pavlova.jpg',
      numcomments: '30',
      numshare: '7',
      isLiked: false,
    ),
    Userpost(
      userimg: 'assets/person4.jfif',
      username: ' Johnson Stewart',
      time: '5 hrs ago',
      postcontent: 'Just finished a 10k run!',
      postimg: 'assets/pavlova_main.jfif',
      numcomments: '30',
      numshare: '7',
      isLiked: false,
    ),
  ];

  List<Friend> friendList = [
    Friend(img: 'assets/person1.jfif', name: 'Alice'),
    Friend(img: 'assets/person2.jfif', name: 'Bob'),
    Friend(img: 'assets/person3.jfif', name: 'Charlie'),
    Friend(img: 'assets/person4.jfif', name: 'Diana'),
    Friend(img: 'assets/person5.jfif', name: 'Ethan'),
    Friend(img: 'assets/person6.jpg', name: 'Fiona'),
  ];

  List<Usercomment> commentList = [
    Usercomment(
      commenterImg: 'assets/person2.jfif',
      commenterName: 'Jane Smith',
      commentTime: '1 hr ago',
      commentContent: 'Looks fun!',
    ),
    Usercomment(
      commenterImg: 'assets/person3.jfif',
      commenterName: 'Mike Johnson',
      commentTime: '30 mins ago',
      commentContent: 'Wish I was there!',
    ),
    Usercomment(
      commenterImg: 'assets/person4.jfif',
      commenterName: 'Emily Davis',
      commentTime: '15 mins ago',
      commentContent: 'Great photo!',
    ),
  ];

  Account myUserAccount = Account(
    name: 'Zsochary Givera',
    email: 'zsocharypogi@gmail.com',
    img: 'assets/person2.jfif',
    numFollowers: '1 Million',
    numPosts: '350',
    numFollowing: '500',
    numFriends: '400',
  );
}
