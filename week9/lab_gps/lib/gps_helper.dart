import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class GpsHelper {
  static Future<Position> getGps() async {
    //Verificar si la ubicación del dispositivo está habilitada
    bool bGpsHabilitado = await Geolocator.isLocationServiceEnabled();
    if (!bGpsHabilitado) {
      return Future.error('Por favor habilite el servicio de ubicación.');
    }
    //Validar permiso para utilizar los servicios de localización
    LocationPermission bGpsPermiso = await Geolocator.checkPermission();
    if (bGpsPermiso == LocationPermission.denied) {
      bGpsPermiso = await Geolocator.requestPermission();
      if (bGpsPermiso == LocationPermission.denied) {
        return Future.error(
            'Se denegó el permiso para obtener la ubicación, por favor habilite el permiso e inténtelo de nuevo.');
      }
    }
    if (bGpsPermiso == LocationPermission.deniedForever) {
      return Future.error(
          'Se denegó el permiso para obtener la ubicación, por favor habilite el permiso manualmente e inténtelo de nuevo.');
    }
    //En este punto los permisos están habilitados y se puede consultar la ubicación
    return await Geolocator.getCurrentPosition();
  }

  static setUrl(final String lat, final String lon) {
    return 'http://www.google.com/maps/place/$lat,$lon';
  }

  static Future<void> openUrl(final String sUrl) async {
    final Uri oUri = Uri.parse(sUrl);
    try {
      await launchUrl(oUri, mode: LaunchMode.externalApplication);
    } catch (oError) {
      return Future.error('No fue posible abrir la url: $sUrl.');
    }
  }
}
