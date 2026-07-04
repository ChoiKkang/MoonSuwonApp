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
