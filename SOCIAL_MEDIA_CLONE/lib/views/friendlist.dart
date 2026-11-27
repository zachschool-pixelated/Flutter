import 'package:material_ui/material_ui.dart';

import '../model/friend.dart';

import '../model/userdata.dart';

// ignore: must_be_immutable
class Friendlist extends StatelessWidget {
  Friendlist({super.key, required this.userdata});

  final Userdata userdata;

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  // Every card has the same photo box: photos are cropped to fill it
  // (BoxFit.cover, face-biased) and names are centred underneath.
  Widget friend(Friend friend) => Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Image.asset(
            friend.img,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            friend.name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );

  // Fix: the grid no longer scrolls on its own inside the page's ListView
  // (it fought the parent for touch gestures on a real device). It is sized
  // by its content instead of a fixed 380px box.
  Widget friendsListGrid() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.symmetric(horizontal: 4),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisExtent: 180,
    ),
    itemCount: userdata.friendList.length,
    itemBuilder: (BuildContext ctx, index) {
      return friend(userdata.friendList[index]);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(children: [Text('Friends', style: followTxtStyle)]),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(children: [Text('${userdata.friendList.length} Friends')]),
        ),
        const SizedBox(height: 10),
        friendsListGrid(),
        SizedBox(height: 10, child: Container(color: Colors.grey)),
      ],
    );
  }
}
