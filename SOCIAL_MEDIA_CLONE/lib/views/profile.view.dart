import 'package:material_ui/material_ui.dart';

import '../model/userdata.dart';
import '../model/usercomment.dart';
import '../model/userpost.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.userPost,
    required this.postIndex,
  });

  final Userpost userPost;
  final int postIndex;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final Userdata userData = Userdata();
  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final nametxtStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> submitComment() async {
    final text = commentController.text.trim();
    if (text.isEmpty) return;
    await userData.addComment(widget.postIndex, text); // saved on the device
    commentController.clear();
    setState(() {});
    // Scroll down so the new comment is visible.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget buttons(Userpost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(color: Colors.grey),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                foregroundColor: userPost.isLiked ? Colors.grey : Colors.blue,
              ),
              onPressed: () {},
              icon: const Icon(Icons.thumb_up, size: 20),
              label: const Text('Like'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.chat_bubble, size: 20),
              label: const Text('Comment'),
            ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(Icons.share, size: 20),
              label: const Text('Share'),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.grey),
    ],
  );

  Widget userline(Userpost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CircleAvatar(
          backgroundImage: AssetImage(userPost.userimg),
          radius: 20,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userPost.username, style: nametxtStyle),
          const SizedBox(height: 5),
          Row(
            children: [
              Text(userPost.time),
              const Text(' · '),
              const Icon(Icons.group, size: 15, color: Colors.grey),
            ],
          ),
        ],
      ),
    ],
  );

  Widget postimage(Userpost userPost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(children: [Text(userPost.postcontent)]),
        const SizedBox(height: 15),
        Container(
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(userPost.postimg),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );

  Widget commenters(Userpost userPost) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userPost.numshare),
        const SizedBox(height: 20),
        const Row(
          children: [
            Text(
              'All Comments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ],
    ),
  );

  Widget userpostdetails(Usercomment comment) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(comment.commenterImg),
          radius: 20,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.commenterName, style: nametxtStyle),
                    const SizedBox(height: 5),
                    Text(comment.commentContent),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 4),
                child: Row(
                  children: [
                    Text(comment.timeLabel),
                    const SizedBox(width: 12),
                    const Text('Like'),
                    const SizedBox(width: 12),
                    const Text('Reply'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget commentBar() => SafeArea(
    top: false,
    child: Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(userData.myUserAccount.img),
            radius: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: commentController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => submitComment(),
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Write a comment...',
                isDense: true,
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: submitComment,
            icon: const Icon(Icons.send, color: Colors.blue),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final userPost = widget.userPost;
    // Sample comments first, then the ones the user added.
    final allComments = [...userData.commentList, ...userPost.addedComments];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            // One ListView only (comments are children of it, not a nested
            // ListView), so scrolling is smooth on a device.
            child: ListView(
              controller: scrollController,
              children: [
                userline(userPost),
                postimage(userPost),
                buttons(userPost),
                commenters(userPost),
                ...allComments.map(userpostdetails),
              ],
            ),
          ),
          commentBar(),
        ],
      ),
    );
  }
}
