class Usercomment {
  final String commenterImg;
  final String commenterName;
  final String commentTime;
  final String commentContent;

  /// Set only for comments the user adds; used to show "x mins ago".
  final DateTime? createdAt;

  Usercomment({
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
    this.createdAt,
  });

  String get timeLabel {
    final t = createdAt;
    if (t == null) return commentTime;
    final d = DateTime.now().difference(t);
    if (d.inMinutes < 1) return 'Just now';
    if (d.inMinutes < 60) return '${d.inMinutes} mins ago';
    if (d.inHours < 24) return '${d.inHours} hr${d.inHours == 1 ? '' : 's'} ago';
    return '${d.inDays} day${d.inDays == 1 ? '' : 's'} ago';
  }

  Map<String, dynamic> toJson() => {
        'img': commenterImg,
        'name': commenterName,
        'content': commentContent,
        'createdAt': createdAt?.toIso8601String(),
      };

  factory Usercomment.fromJson(Map<String, dynamic> j) => Usercomment(
        commenterImg: j['img'] as String,
        commenterName: j['name'] as String,
        commentTime: '',
        commentContent: j['content'] as String,
        createdAt: DateTime.tryParse(j['createdAt'] as String? ?? ''),
      );
}
