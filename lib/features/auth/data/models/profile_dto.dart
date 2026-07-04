class ProfileDto {
  const ProfileDto({
    required this.id,
    this.email,
    this.nickname,
    this.avatarUrl,
    required this.provider,
    required this.providerSub,
    required this.isPrivateEmail,
    required this.updatedAt,
  });

  final String id;
  final String? email;
  final String? nickname;
  final String? avatarUrl;
  final String provider;
  final String providerSub;
  final bool isPrivateEmail;
  final DateTime updatedAt;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => ProfileDto(
    id: json['id'] as String,
    email: json['email'] as String?,
    nickname: json['nickname'] as String?,
    avatarUrl: json['avatar_url'] as String?,
    provider: json['provider'] as String,
    providerSub: json['provider_sub'] as String,
    isPrivateEmail: json['is_private_email'] as bool? ?? false,
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    if (email != null) 'email': email,
    if (nickname != null) 'nickname': nickname,
    if (avatarUrl != null) 'avatar_url': avatarUrl,
    'provider': provider,
    'provider_sub': providerSub,
    'is_private_email': isPrivateEmail,
    'updated_at': updatedAt.toIso8601String(),
  };
}

bool isApplePrivateRelayEmail(String? email) {
  final normalized = email?.trim().toLowerCase();
  return normalized != null && normalized.endsWith('@privaterelay.appleid.com');
}
