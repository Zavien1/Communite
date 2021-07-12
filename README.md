Communite - README 
===

# Communite

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Communite gives users a geomap interface to explore what their social circles are doing around town. Users have the ability to create events based off setting certain preferences for venue, location, price range, etc.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Geo-Social
- **Mobile:** Uses geo-location, Facebook Events, mobile-first
- **Story:** Allows users to view events and social spots around their geographic location
- **Market:** This app is geared towards millenials who live in urban areas such as Los Angeles or New York who want the ability to view social events going on around them as well as host events for their friends.
- **Habit:** Users can post events they are hosting and other users can view these events and RSVP based on their geographic location. Other features will allow users to view popular spots to visit based on where their friends like to visit. It makes their locaiton more lively and interactive.
- **Scope:** This app will start as a simple Facebook events app with a geo-map interface but can expand to be the way users interact with their city. A proper geo-map interface can make being active in your community and aware of what goes on easier and more comprehensive.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Users should be able to login to their Facebook accounts
* Users should be able to create events and pin them on the map, those pins should be visible to the users friends
* Users should be able to create events based on recommended venues
* Users should be able to tap on those pins and RSVP for said events
* Users should be able to determine who can view pins/events they create
* Users should be able to cancel events they are hosting or cancel their RSVP's for events
* 

**Optional Nice-to-have Stories**

* Users can logout of their Facebook accounts
* Users can customize the look of the app I.E. dark mode.

### 2. Screen Archetypes

* Onboarding
   * Users should learn about what the app does and how they can use it
* Login/Register
   * Users can login to their Facebook account
   * Users can create their own accounts and link their Facebook accounts.
* Map View
   * Users can view events as pins around their city and see where their friends are
   * Users can view the location of their friends around town
   * Users can change their visibility status to either be visible or invisible to their friends on the map
   * Users can drop pins and create events and control the visibility of that event for other users to RSVP.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Map
* Events
* Profile
* Settings

**Flow Navigation** (Screen to Screen)

* Map
   * Events RSVP Modal
* Events
    * Events Details Screen

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="https://i.imgur.com/qsOQsGS.jpg" width=200>
<img src="https://i.imgur.com/c6aDBC3.jpg" width=200>
<img src="https://i.imgur.com/HDMBNCV.jpg" width=200>
<img src="https://i.imgur.com/wKFnuPB.jpg" width=200>
<img src="https://i.imgur.com/Kk0q61g.jpg" width=200>

### [BONUS] Interactive Prototype

## Schema 
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user(default field) |
   | username      | String   | unique name for the user |
   | password      | String   | image that user posts |
   | numberOfEventsJoined  | Number | count of all events joined |
   
#### Event
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the event(default field) |
   | eventName     | String   | unique name for the event
   | creator       | Pointer to user | event creator |
   | location      | LatLng   | location of the event |
   | description   | String   | description of the event |
   | rsvpCount     | Number   | number of rsvps for the event |
   | createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
