import 'package:proyectoMoviles/utils/item_friends.dart';

class FriendRepository {
  static List<itemFriends> loadFriends() {
    return <itemFriends>[
      itemFriends(
        name: "Amigo 1",
        profilePic: "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
      ),
      itemFriends(
        name: "Amigo 2",
        profilePic: "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
      ),
      itemFriends(
        name: "Amigo 3",
        profilePic: "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
      ),
      itemFriends(
        name: "Amigo 4",
        profilePic: "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
      ),
      itemFriends(
        name: "Amigo 5",
        profilePic: "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
      ),
    ];
  }
}