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
- Almost for each page there is specific Cubit for this page which manages states and fetches data. Some of them are created at main.dart such as AuthCubit and some are created on the page level.
- Router configuration file contains ...
