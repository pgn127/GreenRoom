# CSCI346 Assignment4
The Green Room mobile app provides long range surf forecasts for Australia’s major beaches. Our application fetches forecast data from The Australian Surf Forecast API and displays swell size, swell direction, wind speed, wind direction in 3 hour increments. Users are able to view and bookmark beaches closest to them and seamlessly navigate to their details. Green Room is the most convenient way to find what the surf is doing at locations around you. Making it easier than ever to decide where to surf. Completely Free.

## Team members
Daniel Del Core
Pam Needle



## Get running
* Extract the zipped project file.
* Navigate to the xcode project file "assignment4/assignment4.xcodeproj"
* Open application and hit CMD + R to build and run the application.

## API

http://swellcast.com.au/surf-forecast-api
* /api/v1/states.json?api_key=your_api_key
* /api/v1/states/:state_id.json?api_key=your_api_key
* /api/v1/locations/:location_id.json?api_key=your_api_key

## Server (Personal API)
This server was built to support a POST request as requested in the spec.
It is built on node.js > express.js and hosted on Daniel's personal server.

http://greenroom.danieldelcore.com
* /
* /api/PostStatusUpdate

## Class Desc

### SurfForcastService.swift

Description: This class is an endpoint wrapper that provides functions that abstract the asynchronous tasks away from the view controller logic. Please see the API section above for more information on the endpoints it provides.

Source: Group

### BeachModel.swift

Description: Beach model is used to contain a location's data. Ie data received from the /api/v1/locations/:location_id.json endpoint will be stored in this class to make it easily accessible and transportable.

Source: Group

### LocationModel.swift

Description: This class represents a single location. These are used by many viewcontrollers to access location, names etc. MapViewController will use this class to place annotations.

Source: Group

### StateModel.swift

Description: Describes a single state

Source: Group

### BeachViewController.swift

Description: The beach view controller is an entry point for the ContentViewControllers. It houses a UIPageView which will contain an array of ContentViewController

Source: Group

### ContentViewController.swift

Description: ContentViewController is the most visually detailed classes of the application. It is responsible for displaying data relevant to a specific time step "BeachModel/Forcast". It is contained by the BeachViewController. Users can easily swipe from one ContentViewController instance to another.

Source: Group

### CustomTableViewCell.swift

Description: The comment view controller has a form that submits to the custom build api at "http://greenroom.danieldelcore.com". This is for the POST portion of this assignment

Source: Group

### FavoriteEntityManager.swift

Description: This class is responsible for managing the CoreData entity 'Favorite'. It has functions that wrap the Create, Read, Update and Delete logic. The 'BeachViewController' and the 'FavoritesTableViewController' use it to manage the user's favorite locations.

Source: Group

### FavoriteModel.swift

Description: This class describes a single favorite record.

Source: Group

### FavoritesTableViewController.swift

Description: This class fetches a users favorite beaches from CoreData. The data is then rendered into a table view controller for the user to quickly access.

Source: Group

### ListViewController.swift

Description: The list view controller provides an alternative view to the map view. It simply displays a list of beaches.

Source: Group

### MapViewController.swift

Description: The map view controller is responsible for fetching location data from the API and displaying that information on a MapView. It uses custom annotations with tooltips to allow a user to select and navigate to a beach.

Source: Group

### Reachability.swift

Description: This class will detect if an internet connection is available. This is used in other view controllers for handling the event where internet is unavailable.
The ViewControllers will often just display an AlertController and ask the user to try again.

Source: http://stackoverflow.com/questions/30743408/check-for-internet-conncetion-in-swift-2-ios-9

### CustomTableViewCell.swift

Description: This class is used when a tableview cell is required to store an Id for access on a click event.

Source: Group
