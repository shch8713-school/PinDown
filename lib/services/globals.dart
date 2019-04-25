library database.globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'classes.dart';

List<Game> gameslist = [];
List<Field> fields =  [createField('Ferrand', 40.006009, -105.267693, 1), createField('Norlin Quad', 40.008729, -105.271468, 2), createField('Kittridge Fields', 40.002974, -105.259576, 3), createField('Engineering Quad', 40.006813, -105.264942, 4)];
User myUser;
String userId;
String userEmail;
Map gamemap;
Map fieldmap;
Field curfield;
Set<Marker> mapmarks;