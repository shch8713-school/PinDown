library database.globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes.dart';

List<Game> gameslist = [];
List<Field> fields =  [
  createField('Ferrand', 40.005995, -105.269660, 1),
  createField('Norlin Quad', 40.008309, -105.273120, 2),
  createField('Kittridge Fields', 40.002470, -105.259921, 3),
  createField('Engineering Quad', 40.006627, -105.265233, 4),
  createField('Business Field', 40.005221, -105.262992, 5),
  createField('Sewall Field', 40.009507, -105.271183, 6),
  createField('Physics Quad', 40.007350, -105.268030, 7)
];
User myUser;
String userId;
String userEmail;
Map gamemap;
Map fieldmap;
Field curfield;
Set<Marker> mapmarks;