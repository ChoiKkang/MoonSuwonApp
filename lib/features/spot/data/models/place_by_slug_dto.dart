import 'package:dalbit_suwon/features/spot/data/models/accessibility_facts.dart'
    show AccessibilityFacts;

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
    this.petPolicy,
    this.petNote,
    this.accessibility = AccessibilityFacts.empty,
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
      // 아래 필드들은 현재 get_place_by_slug RPC가 아직 반환하지 않는다.
      // 웹의 v_published_places(access_* / pet_*) 컬럼을 RPC에 추가하면
      // 별도 코드 변경 없이 값이 채워지는 전방 호환 매핑이다. 없으면 빈 값.
      petPolicy: json['pet_policy'] as String?,
      petNote: (json['pet_note_short'] ?? json['pet_note']) as String?,
      accessibility: AccessibilityFacts(
        route: json['access_route'] as String?,
        exit: json['access_exit'] as String?,
        elevator: json['access_elevator'] as String?,
        parking: json['access_parking'] as String?,
        publicTransport: json['access_public_transport'] as String?,
        wheelchair: json['access_wheelchair'] as String?,
        brailleBlock: json['access_braille_block'] as String?,
        braillePromotion: json['access_braille_promotion'] as String?,
        audioGuide: json['access_audio_guide'] as String?,
        bigPrint: json['access_big_print'] as String?,
        helpDog: json['access_help_dog'] as String?,
        restroom: json['access_restroom'] as String?,
        lactationRoom: json['access_lactation_room'] as String?,
        stroller: json['access_stroller'] as String?,
        infantsFamily: json['access_infants_family'] as String?,
        etc: json['access_etc'] as String?,
        sourceUpdatedAt: json['access_source_updated_at'] as String?,
      ),
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
  final String? petPolicy;
  final String? petNote;
  final AccessibilityFacts accessibility;

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
