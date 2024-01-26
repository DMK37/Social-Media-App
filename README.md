# PhotoCraft

## Overview

### A social networking application for photographers and graphic designers.
 
The app allows you to showcase your portfolio, connect with like-minded creatives, get valuable feedback or share your own opinion.
 
### Screens:
- Home screen: displayed list of recent posts of users you subscribe to.
- User Profile, with a description and all posts by that user.
- Post page, with the ability to like and comment.
- Login and new user registration pages.
- A page with searching for other users.
- A page with creating new posts.

### As a user, I can:
- See my friends' recent posts.
- Create my own posts (from photos or camera).
- Be able to login/register with email and password or Google, Facebook, Apple account.
- Filter posts by type.
- Modify profile description.
- Search for other users.
- Comment and like.
- Follow friends


## Project Structure
### Overview
- Project was built using BLOC pattern (Cubit), routing (Go Router), Firebase services such as Authentication, Firestore Database and Storage, image_picker and image_cropper for taking and cropping photos.
- Almost for each page there is specific Cubit which manages states and fetches data. Some of them are created at main.dart such as AuthCubit and some are created on the page level.
- Router configuration file contains URL routes, redirect rules when user is authenticated or not and StatefulShellRoute with StatefulShellBranch which allow to use bottom navigation bar with routing.
- For better usage and readability Firebase is used with specific model and repository for each entity
- All code which contains logic, for example taking photos, is written inside BLOC to seperate it from view.

### Folder Structure
  - Folders auth/cubit, users/cubit, edit_profile/cubit, home/cubit, search/cubit, post/... contain cubits and their states for specific view or problem
  - Pages folder has files which represent screens of the application, some times they grow too big, so part of them have a file in views folder with similar name
  - Component folder contains some widgets that are being reused in the application
  - Data has two folders: model and repository. Model stands for mapping data from Firebase to objects and Repository is used to communicate with Firebase
  - Theme folder has information about dark and light themes. By default theme  is set to system settings theme using SharedPreferences.
 
  ## Data
  - User:
    - firstName: String
    - lastName: String
    - email: String
    - profileImageUrl: String
    - about: String
    - followers: List<String>
    - following: List<String>
  - Post:
     - userId: String
     - timestamp: timestamp
     - imageUrl: String
     - description: String
     - tags: List<String>
     - likes: List<String>
     - comments: List<Comment>
  - Comment:
     - comment: String
     - timestamp: timestamp
     - userId: String 

  ## User Guide
   ### User Sign in/ Sign up
   - 
