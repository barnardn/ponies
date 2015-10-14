## Candidate Demo App

You will implement a simple app that utilizes the [Pony Faces API](http://poneyfac.es/developer). This app will have two primary functions:

- Search for pony faces based on a user supplied tag name
- Allow the user to store their favorite pony faces locally to their device.

You are free to add any additional functionality to the app that you wish. Additionally, you are free to use any freely available third party components in
your implementation. For example:

**iOS**
- AFNetworking
- Magical Record
- Reactive Cocoa

Third party iOS components should be managed using either Cocoapods, carthage, or git submodules.


### Requirements

Download progress should be clearly indicated to the user whenever network activity occurs.

#### API

Use the JSON variant of the API.

#### Appearance & Design

The UI elements you choose to use in your implementation should have a consistent theme. The same typeface should
be used throughout as well as the following colors: Pink, Purple, and White. You are free to choose whichever shade
of pink and purple looks nice to you as well as preferred typeface.

The design of the app should use UI components that are native to the platform and follow that platform's recommended design practices (Human Interface Guidelines for iOS, Material for Android). You are free to choose whichever design pattern you feel is appropriate for your implementation, provided you adhere to your platform guidelines.

#### Search results

The search results must contain at a minimum, the thumbnail of the matching pony face as well as the category name. Selecting a
search results should present the details of the selected record. These details must contain:

- category name
- all associated tags
- large pony image

The details view will also allow the user to save ("Favorite") the selected pony record to the local storage of their device<sup>1</sup> as well as the full size
image of the pony face.

The user should not be allowed to mark the same pony face as a favorite more than once.

<sup>1</sup> If this is an iOS app, you must use core data for storage. You needn't store any image data in core data however.

#### Favorites

The favorites views will contain a list of all the pony faces the user has marked as a favorite. It should show a thumbnail of each pony face as well
as the category name of the face. Selecting a favorite will show the same pony face details as the search results details view. The favorites views must get all of
their data from the local device storage.

### What You Must Submit

You will submit to Maestro, a link to the public source code repository where your app is stored. Your app must build and run with the minimum number of
steps. Ideally, all that should be required is for another developer to clone the repository, build and run it. If additional step are required, those must be
fully documented in a README file that is part of the repository. Likewise, any additional information you bring to Maestro's attention should be documented
there as well.
