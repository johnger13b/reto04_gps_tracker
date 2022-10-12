import 'package:f_gps_tracker/domain/models/location.dart';
import 'package:f_gps_tracker/ui/controllers/gps.dart';
import 'package:f_gps_tracker/ui/controllers/location.dart';
import 'package:f_gps_tracker/ui/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'map_sample.dart';

class ContentPage extends GetView<LocationController> {
  late final GpsController gpsController = Get.find();

  ContentPage({super.key});

  void displayDialogMap(BuildContext context, double lat, double long) {
    // El método showDialog necesita el context del widget padre, por eso se pasa
    // como parámetro. También se pasan las coordenadas
    showDialog(
      barrierDismissible: false, // Cerrar al hacer clic por fuera (true)
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          title: const Text('Su Ubicación'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: MapSample(lat: lat, lon: long),
          actions: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
              label: const Text('Cerrar'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat myDateFormat = DateFormat('dd/MMM/yyyy - h:mm:ss a');

    return Scaffold(
      appBar: AppBar(
        title: const Text("GPS Tracker"),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // TO DO: 1. Obten la ubicacion actual con gpsController.currentLocation
                        final location = await gpsController.currentLocation;
                        // TO DO: 2. Obten la precision de la lectura con gpsController.locationAccuracy.
                        final accuracy = await gpsController.locationAccuracy;
                        // TO DO: 3. Crea un objeto [TrackedLocation] con fecha actual [DateTime.now] y la precisio como texto [accuracy.name]
                        final trackedLocation = TrackedLocation(
                          latitude: location.latitude,
                          longitude: location.longitude,
                          timestamp: DateTime.now(),
                          precision: accuracy.name,
                        );
                        // TO DO: 4. con el [controller] guarda ese objeto [saveLocation]
                        controller.saveLocation(location: trackedLocation);
                      },
                      child: const Text("Registrar Ubicación"),
                    ),
                  ),
                  Expanded(
                    child: Obx(
                      () => ListView.separated(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: controller.locations.length,
                        itemBuilder: (context, index) {
                          final location = controller.locations[index];
                          return Card(
                            child: ListTile(
                              isThreeLine: true,
                              leading: TextButton.icon(
                                // Botón que abre el alert con el mapa y la ubicación
                                icon: const Icon(Icons.gps_fixed_rounded),
                                style: TextButton.styleFrom(
                                  backgroundColor: MyTheme.secondaryColor,
                                  foregroundColor: MyTheme.white,
                                ),
                                onPressed: () {
                                  // Llamo al método que muestra el modal con el mapa, le envío el
                                  // build context, y las coordenadas
                                  return displayDialogMap(
                                    context,
                                    location.latitude,
                                    location.longitude,
                                  );
                                },
                                label: const Text('Ver'),
                              ),
                              title: Text(
                                '${location.latitude}, ${location.longitude}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyTheme.primaryColor),
                              ),
                              subtitle: Text(
                                '${myDateFormat.format(location.timestamp)}\n${location.precision.toUpperCase()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyTheme.darkColor),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  // TO DO: elimina la ubicacion [location] usando el controlador [deleteLocation]
                                  controller.deleteLocation(location: location);
                                },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 8.0),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        // TO DO: elimina todas las ubicaciones usando el controlador [deleteAll]
                        controller.deleteAll();
                      },
                      child: const Text("Eliminar Todos"),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
