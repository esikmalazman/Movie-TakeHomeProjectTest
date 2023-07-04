# iOS Test Evaluation

### Introduction
-  Creating a simple iOS app that allows users to ```search for movies``` and ```view their details```. The app should make use of the [Movie Database API](https://www.themoviedb.org/documentation/api) to retrieve movie information.

### Demo
-

### Installation

1. Install Xcode version 14.0 and later from [App Store](https://apps.apple.com/us/app/xcode/id497799835?mt=12) 
2. Login or Create an Account on [TMDB](https://www.themoviedb.org/) and Get the API Key from [TMDB API Settings Page](https://www.themoviedb.org/settings/api)
3. Download the project from [here](https://github.com/esikmalazman/Movie-TakeHomeProjectTest/archive/refs/heads/main.zip)
4. Unarchive the Zip and Open ```Secret.swift``` file in``` Movie+ -> App -> Secrets.swift``` and replace the value of ```"API_KEY"``` with  `API Key from TMDB`
5. Open ```Movie+.xcodeproj``` and build the project with ```Command + B ```, upon build success run the project with ```Command + R```.

### Technologies Used :

- `Swift 5`
- `UIKit` for UI Development (UITableView, UIViewController, UIView, UITabBar)
- `URLSession` for fetching data from API (Image & Search Results) 
- `Model-View-Presenter(MVP)` as UI Architecture Pattern
- `Core Data` for Local Cache with Database (Search Results & Bookmarks)
- `XCTest` for Unit Test

### Reflections

1. Decisions

- Utilising MVP, allows us to separate the presentation that UI needs to display in the presenter object, and it also allows us to reuse the existing presenter if we want to change UI technologies in the future like SwiftUI, or AppKit. So the UI, only consumes what the presenter assigns to them.
  
- Create an Interactor as a mediator for the Presenter to interact with Remote(URL Session) or Local Data(Core Data). In interactor also have specific implementation detail of the object we want to get data with i.e. movie, bookmark, recent search.
  
- Make use of the protocol in declaring the type and implementation of the Interactor allowing the consumer of the dependency only to know what available methods in the protocol without knowing the implementation detail. Using this method also allow us to loosen the coupling between dependency and make us easier to test specific object in Unit Test through a method like mock without using the real object which is a hard dependency.
- For Design, I'm using UITabBar to allow users to navigate to a different section easily which is usually in bigger applications inside specific tabs containing sub functionality of the application.
  
- I also make use of displaying the Empty State in each tab to give them a glimpse of information on what action they can do and what is the status of the app-specific functionality i.e bookmarks is empty

2. Challenges

-
-
-

   
