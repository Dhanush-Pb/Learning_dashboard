# Learning Dashboard

A Flutter-based Learning Dashboard application built as part of the Senior Mobile App Developer technical assignment.

## Features

- Email and password login with validation
- Login loading and error states
- Persistent login session
- Course dashboard with:
  - Course name
  - Instructor
  - Progress percentage
  - Lesson count
  - Continue Learning
- Course details with lesson list
- Mark lessons as completed
- Automatic course progress calculation
- Loading, empty, and error states
- Offline course data using local caching
- Course progress persists after app restart
- Logout functionality
- Unit testing for course progress calculation

## Demo Credentials

Use the following credentials to access the application:

- **Email:** Test@gmail.com
- **Password:** Test123

## Architecture

The application follows a simple layered architecture:

```text
UI / Pages
    ↓
Controllers
    ↓
Repository
    ↓
Data Sources
    ├── Local JSON
    └── Local Cache