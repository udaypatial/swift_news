# Swift News

Swift News aggregator App

## Build Tools & Versions
Xcode : v11.2.1

iOS : 11.0 and above

Dependency Manager : Cocoapods

## Focus Areas

- Use MVVM as a architecture pattern.
- Reusable generic network layer for future API integrations.
- Build UI programatically using a reusable autolayout extension for better readability.
- Use sections based approach to build dynamic UIs. e.g - `GLRow` inside the `NewsListViewModel`
- Behaviour driven testing using quick/nimble frameworks
- Reusable error/loading spinner views.
- Kingfisher library used for image caching

## Copied-in code or copied-in dependencies

- Used a autolayout extension to make it easier to setup constraints programatically
- Few shared views and extensions in the `SharedViews` and `Theme` folder.

## Tablet / phone focus

- Works on both iPhone / iPad

## Time Spent
- Around 4 hours


## Setting up the project

- if you do not have cocoapods on your mac run `sudo gem install cocoapods`, enter your mac password when prompted.
- cd into the project directory from the terminal and run `pod install`. Then open the `.xcworkspace` file in xcode hit run.

