
import 'package:uuid/uuid.dart';

import '../core/data_layer.dart';

//shared Variables
bool checkUser=false;//this is to check the user if is null or not when he sign in
double selectedNearestLat = 0;//this latitude choosen by the user to selected point
double selectedNearestLog = 0;//this longitude choosen by the user to selected point



double addPlaceLocatonLat=0;//this is the latitude where the user add his place

double addPlaceLocatonLong=0;//this is the longitude where the user add his place


double addEventLocatonLat=0;//this is the latitude where the user add his Event

double addEventLocatonLog=0;//this is the longitude where the user add his Event
enum ImageType {
  placesImages,
  questionImages,
  eventImages,
}

Uuid uuid = const Uuid();//// this used to Generate a unique ID

UserModel sharedUser = UserModel.empty() ;

String oldemail="";//store the user's old email

bool AdminCheck=false;//this to check if the user is admin or not to chose which card to display




