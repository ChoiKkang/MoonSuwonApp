class ProfileDto {
  const ProfileDto({
    required this.id,
    this.email,
    this.nickname,
    this.avatarUrl,
    required this.provider,
    required this.updatedAt,
  });

  final String id;
  final String? email;
  final String? nickname;
  final String? avatarUrl;
  final String provider;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        if (email != null) 'email': email,
        if (nickname != null) 'nickname': nickname,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        'provider': provider,
        'updated_at': updatedAt.toIso8601String(),
      };
}
