import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:dalbit_suwon/core/theme/app_colors.dart' show AppColors;
import 'package:dalbit_suwon/features/nearby/data/models/nearby_place.dart'
    show NearbyPlace;

/// '내 주변' 지도 뷰.
///
/// flutter_map(Leaflet 계열) + OpenStreetMap 타일을 사용한다.
/// - 파란 원: 현재(또는 fallback) 위치
/// - 노란 핀: 인근 스팟 마커. 선택된 마커는 크기가 커지고 강조된다.
///
/// 카메라 제어는 부모가 소유한 [mapController]로 이뤄진다. 부모는 이 컨트롤러로
/// "내 위치로 재중심" 버튼 등의 명령형 조작을 실행한다.
class NearbyMapView extends StatefulWidget {
  const NearbyMapView({
    super.key,
    required this.mapController,
    required this.originLat,
    required this.originLng,
    required this.places,
    required this.selectedPlaceId,
    required this.onMarkerTap,
    this.isOriginFallback = false,
  });

  final MapController mapController;
  final double originLat;
  final double originLng;
  final List<NearbyPlace> places;
  final String? selectedPlaceId;
  final ValueChanged<NearbyPlace> onMarkerTap;
  final bool isOriginFallback;

  @override
  State<NearbyMapView> createState() => _NearbyMapViewState();
}

class _NearbyMapViewState extends State<NearbyMapView> {
  @override
  void didUpdateWidget(covariant NearbyMapView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 원점(사용자 위치 / fallback)이 바뀌면 카메라도 그 지점으로 이동한다.
    final originChanged = widget.originLat != oldWidget.originLat ||
        widget.originLng != oldWidget.originLng;
    if (originChanged) {
      widget.mapController.move(
        LatLng(widget.originLat, widget.originLng),
        15,
      );
    }

    // 리스트에서 선택된 스팟이 바뀌면 그 마커로 카메라 이동.
    if (widget.selectedPlaceId != null &&
        widget.selectedPlaceId != oldWidget.selectedPlaceId) {
      final selected = widget.places.firstWhere(
        (place) => place.id == widget.selectedPlaceId,
        orElse: () => widget.places.isEmpty
            ? NearbyPlace(
                id: '',
                slug: '',
                officialName: '',
                displayName: '',
                lat: widget.originLat,
                lng: widget.originLng,
                distanceM: 0,
                forecastStatus: 'forecast_unavailable',
              )
            : widget.places.first,
      );
      if (selected.id.isNotEmpty) {
        widget.mapController.move(LatLng(selected.lat, selected.lng), 16);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final origin = LatLng(widget.originLat, widget.originLng);

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      child: FlutterMap(
        mapController: widget.mapController,
        options: MapOptions(
          initialCenter: origin,
          initialZoom: 15,
          minZoom: 11,
          maxZoom: 18,
          // cameraConstraint는 사용하지 않는다.
          // 시뮬레이터·수원 지역 밖 사용자·`_mapController.move()` 호출 시점의 좌표가
          // 바운드 밖에 놓이면 flutter_map이 `constrain(newCamera) == newCamera`
          // 어써션을 던지기 때문. 대신 검색 반경(3km)으로 리스트를 필터링한다.
          interactionOptions: const InteractionOptions(
            flags: InteractiveFlag.pinchZoom |
                InteractiveFlag.drag |
                InteractiveFlag.doubleTapZoom,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'team.choikkang.dalbitsuwon',
            maxNativeZoom: 19,
          ),
          MarkerLayer(
            markers: [
              _originMarker(origin),
              for (final place in widget.places)
                _placeMarker(
                  place: place,
                  isSelected: place.id == widget.selectedPlaceId,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Marker _originMarker(LatLng center) => Marker(
    point: center,
    width: 24,
    height: 24,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: widget.isOriginFallback
            ? AppColors.onSurfaceVariant
            : AppColors.primary,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
    ),
  );

  Marker _placeMarker({required NearbyPlace place, required bool isSelected}) {
    final markerSize = isSelected ? 44.0 : 32.0;
    return Marker(
      point: LatLng(place.lat, place.lng),
      width: markerSize,
      height: markerSize,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () => widget.onMarkerTap(place),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.moonlightGold
                : AppColors.surfaceContainerHigh,
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Colors.white : AppColors.moonlightGold,
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.place,
            color: isSelected ? Colors.black87 : AppColors.moonlightGold,
            size: isSelected ? 24 : 18,
          ),
        ),
      ),
    );
  }
}
