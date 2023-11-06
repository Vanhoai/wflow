// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

const double ZOOM = 19;
const double BEARING = 60;
const double TILT = 90;
const String API_KEY = 'AIzaSyCbebDSMbXojb0pQecwGASs9gezw0nHiWY';

class CompanyLocationWidget extends StatefulWidget {
  const CompanyLocationWidget({super.key});

  @override
  State<CompanyLocationWidget> createState() => _CompanyLocationWidgetState();
}

class _CompanyLocationWidgetState extends State<CompanyLocationWidget> {
  late final CompanyEntity _companyEntity;

  late final LocationLib _locationLib;
  late GoogleMapController mapController;
  late final CameraPosition _initialCameraPosition;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    _locationLib = LocationLib();
    _companyEntity = BlocProvider.of<MyCompanyBloc>(context).state.companyEntity;
    _initialCameraPosition = const CameraPosition(
      target: LatLng(10.853535629225869, 106.62804689672772),
      zoom: ZOOM,
      bearing: BEARING,
      tilt: TILT,
    );

    _addMarker(
      const LatLng(10.853535629225869, 106.62804689672772),
      'company',
      BitmapDescriptor.defaultMarker,
    );

    _getPolyline();
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    final Position position = await _locationLib.getCurrentLocation();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY,
      PointLatLng(position.latitude, position.longitude), // starting point
      const PointLatLng(10.853535629225869, 106.62804689672772), // ending point
      travelMode: TravelMode.driving,
    );

    print('===============================================${result.points.length}');

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;
        return Scaffold(
          body: FutureBuilder(
            future: _locationLib.getCurrentLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Feature not available on your device'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                _addMarker(LatLng(snapshot.data!.latitude, snapshot.data!.longitude), 'myLocation',
                    BitmapDescriptor.defaultMarkerWithHue(90));

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: _initialCameraPosition,
                        onMapCreated: _onMapCreated,
                        mapType: MapType.normal,
                        indoorViewEnabled: true,
                        myLocationEnabled: true,
                        mapToolbarEnabled: true,
                        markers: Set<Marker>.of(markers.values),
                        polylines: Set<Polyline>.of(polylines.values),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Header(
                        leadingPhotoUrl: companyEntity.logo,
                        title: Text(companyEntity.name, style: Theme.of(context).textTheme.displayLarge),
                        subtitle: Text(companyEntity.address, style: Theme.of(context).textTheme.displaySmall),
                        actions: const [],
                      ),
                    )
                  ],
                );
              }
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            },
          ),
        );
      },
      bloc: BlocProvider.of<MyCompanyBloc>(context),
      buildWhen: (previous, current) => true,
    );
  }
}
