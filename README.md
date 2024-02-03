# PhotoCraft

Test user: 
 - mail: france@gmail.com
 - password: qpwoeiru

## Overview

### A social networking application for photographers and graphic designers.
 
The app allows you to showcase your portfolio, connect with like-minded creatives, get valuable feedback or share your own opinion.

<img src="https://github.com/DMK37/Social-Media-App/assets/119494305/44b0a07c-676b-4dc2-9923-48620a7a0929" width="400"/>
<img src="https://github.com/DMK37/Social-Media-App/assets/119494305/a1d60af3-7c12-4cb0-a053-4b764a27b598" width="400"/>


<img src="https://github.com/DMK37/Social-Media-App/assets/119494305/e7c0659a-1f83-4b11-b13c-e392966c89d1" width="400"/>
<img src="https://github.com/DMK37/Social-Media-App/assets/119494305/8c32b6a6-a55e-4e34-a466-2b15d1b36d61" width="400"/>

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
   ### Sign in/ Sign up
   - User can sign in using mail, Google or Facebook account
   - User can sign up, he should provide additionaly his name and username
   - When user signing up using Google or Facebook he should provide additionaly his name and username after provider flow
   ### Home Page
   - Home Page displays posts from users we are following
   - We can filter posts by tag
   ### Search Page
   - User can search for specific users by their username. Result of search is usernames which start with provided sequence
   ### Create Post Page
   - Create Post Page allows to create new post. We should add photo from gallery or camera, description and tags. Also, we can cropp image.
   ### Profile/User Page
   - Displays information about user such as his name, username, about section, number of follows and following, posts of that user. We can start following/unfollowing user
   ### Edit Profile Page
   - Allows to edit information about user and also his profile image
   ### Post page
   - Post page displays post information. We can like post and comment.
