class PlaceBySlugQueryDto {
  const PlaceBySlugQueryDto(this.slug);

  final String slug;

  Map<String, dynamic> toJson() => {'p_slug': slug};
}

class PlaceImageDto {
  const PlaceImageDto({
    required this.imageUrl,
    required this.isHero,
    required this.displayOrder,
  });

  factory PlaceImageDto.fromJson(Map<String, dynamic> json) {
    return PlaceImageDto(
      imageUrl: json['image_url'] as String? ?? '',
      isHero: json['is_hero'] as bool?,
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 0,
    );
  }

  final String imageUrl;
  final bool? isHero;
  final int displayOrder;
}

class PlaceBySlugDto {
  const PlaceBySlugDto({
    required this.id,
    required this.slug,
    required this.officialName,
    required this.addressFull,
    required this.lat,
    required this.lng,
    required this.contactPhone,
    required this.shortDescription,
    required this.recommendedStayMin,
    required this.category,
    required this.displayName,
    required this.missionRadiusM,
    required this.nightHighlight,
    required this.photoTip,
    required this.missionType,
    required this.missionPrompt,
    required this.coupleQuestion,
    required this.shortStory,
    required this.ogTitle,
    required this.ogDescription,
    required this.ogImageUrl,
    required this.images,
  });

  factory PlaceBySlugDto.fromJson(Map<String, dynamic> json) {
    final imageRows = json['images'] as List<dynamic>? ?? const [];
    return PlaceBySlugDto(
      id: json['id'] as String,
      slug: json['slug'] as String,
      officialName: json['official_name'] as String,
      addressFull: json['address_full'] as String?,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      contactPhone: json['contact_phone'] as String?,
      shortDescription: json['short_description'] as String?,
      recommendedStayMin: (json['recommended_stay_min'] as num?)?.toInt(),
      category: json['category'] as String?,
      displayName: json['display_name'] as String,
      missionRadiusM: (json['mission_radius_m'] as num?)?.toInt() ?? 80,
      nightHighlight: json['night_highlight'] as String?,
      photoTip: json['photo_tip'] as String?,
      missionType: json['mission_type'] as String?,
      missionPrompt: json['mission_prompt'] as String?,
      coupleQuestion: json['couple_question'] as String?,
      shortStory: json['short_story'] as String?,
      ogTitle: json['og_title'] as String?,
      ogDescription: json['og_description'] as String?,
      ogImageUrl: json['og_image_url'] as String?,
      images: imageRows
          .map(
            (row) =>
                PlaceImageDto.fromJson(Map<String, dynamic>.from(row as Map)),
          )
          .toList(),
    );
  }

  final String id;
  final String slug;
  final String officialName;
  final String? addressFull;
  final double lat;
  final double lng;
  final String? contactPhone;
  final String? shortDescription;
  final int? recommendedStayMin;
  final String? category;
  final String displayName;
  final int missionRadiusM;
  final String? nightHighlight;
  final String? photoTip;
  final String? missionType;
  final String? missionPrompt;
  final String? coupleQuestion;
  final String? shortStory;
  final String? ogTitle;
  final String? ogDescription;
  final String? ogImageUrl;
  final List<PlaceImageDto> images;

  String get heroImageUrl {
    for (final image in images) {
      if (image.isHero == true && image.imageUrl.isNotEmpty) {
        return image.imageUrl;
      }
    }
    if (images.every((image) => image.isHero == null)) {
      for (final image in images) {
        if (image.imageUrl.isNotEmpty) return image.imageUrl;
      }
    }
    return '';
  }
}
