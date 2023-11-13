// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wflow/common/libs/libs.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/widgets/custom/custom.dart';
import 'package:wflow/modules/main/domain/company/entities/company_entity.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/bloc.dart';

const double ZOOM = 14;
const String API_KEY = 'AIzaSyCbebDSMbXojb0pQecwGASs9gezw0nHiWY';

class CompanyLocationWidget extends StatefulWidget {
  const CompanyLocationWidget({super.key});

  @override
  State<CompanyLocationWidget> createState() => _CompanyLocationWidgetState();
}

class _CompanyLocationWidgetState extends State<CompanyLocationWidget> {
  late final CompanyEntity companyEntity;

  late final LocationLib locationLib;
  late GoogleMapController mapController;
  late final CameraPosition initialCameraPosition;

  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    super.initState();
    locationLib = LocationLib();
    companyEntity = BlocProvider.of<MyCompanyBloc>(context).state.companyEntity;
    initialCameraPosition = CameraPosition(
      target: LatLng(companyEntity.latitude, companyEntity.longitude),
      zoom: ZOOM,
    );

    addMarker(
      LatLng(companyEntity.latitude, companyEntity.longitude),
      'company',
      BitmapDescriptor.defaultMarker,
    );

    getPolyline();
  }

  addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  addPolyLine() {
    PolylineId id = const PolylineId('poly');
    Polyline polyline = Polyline(polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  getPolyline() async {
    final Position position = await locationLib.getCurrentLocation();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      API_KEY,
      PointLatLng(position.latitude, position.longitude), // starting point
      PointLatLng(companyEntity.latitude, companyEntity.longitude), // ending point
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    addPolyLine();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      builder: (context, state) {
        final CompanyEntity companyEntity = state.companyEntity;
        return Scaffold(
          body: FutureBuilder(
            future: locationLib.getCurrentLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Feature not available on your device'),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                addMarker(
                  LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  'myLocation',
                  BitmapDescriptor.defaultMarkerWithHue(90),
                );

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: initialCameraPosition,
                        onMapCreated: onMapCreated,
                        mapType: MapType.normal,
                        indoorViewEnabled: true,
                        myLocationEnabled: true,
                        mapToolbarEnabled: true,
                        markers: Set<Marker>.of(markers.values),
                        polylines: Set<Polyline>.of(polylines.values),
                      ),
                    ),
                    if (snapshot.data != null)
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Header(
                          leadingPhotoUrl: companyEntity.logo,
                          title: Text(companyEntity.name, style: Theme.of(context).textTheme.displayLarge),
                          subtitle: Text(companyEntity.address, style: Theme.of(context).textTheme.displaySmall),
                          actions: [
                            IconButton(
                              onPressed: () {
                                mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(companyEntity.latitude, companyEntity.longitude),
                                      zoom: ZOOM,
                                    ),
                                  ),
                                );
                              },
                              icon: SvgPicture.asset(
                                AppConstants.more,
                                height: 28.w,
                                width: 28.w,
                              ),
                            ),
                          ],
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
