import 'package:proyectoMoviles/utils/item_leaderboard.dart';

class LeaderboardRepository {
  static List<itemLeaderboard> loadLeaderboard() {
    return <itemLeaderboard>[
      itemLeaderboard(
        nombre: "Lugar #1",
        profilePic:
            "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
        houseImage: "assets/PropShieldRavenclaw.png",
        score: 20000,
      ),
      itemLeaderboard(
        nombre: "Lugar #2",
        profilePic:
            "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
        houseImage: "assets/PropShieldSlytherin.png",
        score: 19000,
      ),
      itemLeaderboard(
        nombre: "Lugar #3",
        profilePic:
            "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
        houseImage: "assets/PropShieldGryffindor.png",
        score: 18000,
      ),
      itemLeaderboard(
        nombre: "Lugar #4",
        profilePic:
            "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
        houseImage: "assets/PropShieldRavenclaw.png",
        score: 17000,
      ),
      itemLeaderboard(
        nombre: "Lugar #5",
        profilePic:
            "https://mastodon.sdf.org/system/accounts/avatars/000/108/313/original/035ab20c290d3722.png",
        houseImage: "assets/PropShieldSlytherin.png",
        score: 16000,
      ),
    ];
  }
}
