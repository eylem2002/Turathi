import 'package:flutter/material.dart';
import '../../core/data_layer.dart';
import '../../view/view_layer.dart';

// Class responsible for generating routes in the application
class MyRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        {
          return _route(SplashScreen());
        }

      case eventsAdminRoute:
        {
          return _route(EventsAdmin());
        }

      case placesAdminRoute:
        {
          return _route(PlacesAdmin());
        }

      case aboutUsScreen:
        {
          return _route(AboutUsScreen());
        }

      case signIn:
        {
          return _route(LogIn());
        }

      case deleteUserPage:
        {
          return _route(DeleteUser());
        }

      case personalDetilsScreen:
        {
          return _route(PersonalDetailsScreen());
        }


      case notificationPage:
        {
          return _route(NotificationPage());
        }

      case changeInfo:
        {
          return _route(ChangeInfo());
        }

      case signUp:
        {
          return _route(SingUp());
        }

      case bottomNavRoute:
        {
          return _route(CustomeBottomNavBar());
        }

      case placeDetailsRoute:
        {
          final arg = settings.arguments as PlaceModel;

          return _route(DetailsScreen(
            placeModel: arg,
          ));
        }

      case questionRoute:
        {
          final arg = settings.arguments as QuestionModel;
          return _route(QuestionView(
            question: arg,
          ));
        }

      case addedPlacesRoute:
        {
          return _route(AddedPlaces());
        }

      case eventsRoute:
        {

          return _route(const EventsScreen());
        }
      case eventDetailsRoute:
        {
          final arg = settings.arguments as EventModel;

          return _route(EventDetailsScreen(eventModel: arg));
        }
      case addNewPlaceRoute:
        {
          return _route(const AddNewPlace());
        }
      case editPlaceRoute:
        {
          final arg = settings.arguments as PlaceModel;

          return _route(EditPlace(
            placeModel: arg,
          ));
        }
      case addNewEventRoute:
        {
          return _route(const AddNewEvent());
        }
      case requestToBeExpertRoute:
        {
          return _route(const RequestToBeExpert());
        }
      case addReportRoute:
        {
          final arg = settings.arguments as String;
          return _route(ReportPlace(
            placeId: arg,
          ));
        }
      //admin routes
      case signInAdminRoute:
        {
          return _route(const AdminSignIn());
        }
      case homeAdminRoute:
        {
          return _route(const AdminHomePage());
        }
      case requestsAdminRoute:
        {
          return _route(const RequestScreen());
        }
      case allReportsAdminRoute:
        {
          return _route(const ReportsScreen());
        }
      case placeReportsAdminRoute:
        {
          final arg = settings.arguments as List<ReportModel>;

          return _route(PlaceReportsScreen(
            reportList: arg,
          ));
        }
      case requestPDFViewAdminRoute:
        {
          final arg = settings.arguments as String;

          return _route(PdfViewPage(
            path: arg,
          ));
        }
      case editPlacesAdminRoute:
        {
          final arg = settings.arguments as PlaceModel;

          return _route(EditPlaceAdmin(
          placeModel: arg,
          ));
        }
      default:
        {
          final arg = settings.name as String;
          return _route(UndefineRoute(routeName: arg));
        }
    }
  }

// Helper method to create a MaterialPageRoute
  static MaterialPageRoute _route(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }
}

// Widget to display an undefined route error
class UndefineRoute extends StatelessWidget {
  const UndefineRoute({Key? key, required this.routeName}) : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This $routeName is Undefine Route',
        ),
      ),
    );
  }
}
