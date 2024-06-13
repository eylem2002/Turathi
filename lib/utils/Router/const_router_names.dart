// Initial route for the app
const String initRoute = '/';

// Route for the bottom navigation screen
const String bottomNavRoute = '/bottomScreen';

// Routes for different sections under the bottom navigation screen
const String homeRoute = '/bottomScreen/home';
const String eventsRoute = '/bottomScreen/home/EventsScreen';
const String addNewEventRoute = '/bottomScreen/home/AddNewEvent';
const String addNewPlaceRoute = '/bottomScreen/home/AddNewPlace';

// Route for the notifications page
const String notificationPage = '/bottomScreen/home/NotificationPage'; // Route for the notification page

// Route for event details screen under events section
const String eventDetailsRoute =
    '/bottomScreen/home/EventsScreen/EventDetailsScreen';

// Routes for different screens under the bottom navigation screen
const String locationRoute = '/bottomScreen/LocationPage';
const String communityRoute = '/bottomScreen/communityScreen';
const String favoriteRoute = '/bottomScreen/favoriteScreen';
const String profileRoute = '/bottomScreen/profileScreen';

// Routes for place details and adding a report under place details
const String placeDetailsRoute = '/bottomScreen/-/DetailsScreen';
const String addReportRoute = '/bottomScreen/-/DetailsScreen/ReportPlace';

// Route for viewing a specific question under the community section
const String questionRoute = '/bottomScreen/communityScreen/question_view';

// Routes for different screens under the profile section
const String addedPlacesRoute = '/bottomScreen/profileScreen/AddedPlaces';
const String aboutUsScreen = '/bottomScreen/profileScreen/AboutUsScreen';
const String personalDetilsScreen =
    '/bottomScreen/profileScreen/PersdonalDetilsScreen';
const String changeInfo = '/bottomScreen/profileScreen/ChangeInfo';
const String signIn = '/LogIn';
const String signUp = '/SingUp';
const String deleteUserPage = '/bottomScreen/profileScreen/DeleteUser';

// Route for viewing comments under place details
const String commentsPlaceRoute = '/bottomScreen/-/DetailsScreen/CommentsPlace';

// Route for requesting to be an expert under the profile section
const String requestToBeExpertRoute = '/bottomScreen/Profile/RequestToBeExpert';

// Route for editing a place under the profile section
const String editPlaceRoute =
    '/bottomScreen/profileScreen/AddedPlaces/EditPlace';

// Routes for admin screens
const String signInAdminRoute = '/signInAdmin';
const String homeAdminRoute = '/signInAdmin/home';
const String allReportsAdminRoute = '/signInAdmin/home/allReportsAdminRoute';
const String placeReportsAdminRoute =
    '/signInAdmin/home/allReportsAdminRoute/PlaceReportsScreen';
const String requestsAdminRoute = '/signInAdmin/home/requestsAdminRoute';
const String requestPDFViewAdminRoute = '/signInAdmin/home/requestPDFViewAdminRoute';

// Routes for admin managing places and events
const String placesAdminRoute = '/signInAdmin/home/placesAdmin';
const String editPlacesAdminRoute = '/signInAdmin/home/placesAdmin/placeInfo/editPlacesAdminRoute';
const String eventsAdminRoute = '/signInAdmin/home/eventsAdmin';
