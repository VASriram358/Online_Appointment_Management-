## 📅 Online Appointment Management System

A Flutter-based mobile application that simplifies appointment booking between customers and businesses. Customers can explore registered businesses, book appointments, and track their appointment status, while businesses can manage incoming appointment requests and approve bookings.

## 📱 Application 

### 1. User Registration

Users can create an account as a customer or a business. Business registration includes additional fields for the business name and address.

### 2. Create Appointment

Customers can browse registered businesses, select a business, choose a date and time, and submit an appointment request.

### 3. Customer Dashboard

Customers can view their appointments and track their status, including pending and approved appointments. A floating action button allows customers to create a new appointment.

### 4. Business Dashboard

Businesses can view appointment statistics, including total, approved, and pending appointments. They can review appointment requests and approve them.


## ✨ Features

### 🔐 User Authentication
- User registration and login.
- Separate customer and business account types.
- Password confirmation during registration.
- Logout functionality.
- Prevention of duplicate usernames.

### 👤 Customer Features
- View available registered businesses.
- Select a business for an appointment.
- Choose an appointment date and time.
- Submit appointment requests.
- View personal appointment details.
- Track appointment approval status.

### 🏢 Business Features
- Register a business with its name and address.
- View appointment requests from customers.
- Approve pending appointments.
- View total, approved, and pending appointment counts.

### 📆 Appointment Management
- Store appointment details, including customer, business, date, and time.
- Maintain appointment approval status.
- Display appointments on the appropriate customer and business dashboards.

### 🎨 User Interface
- Material Design interface.
- Simple navigation between screens.
- Card-based business selection.
- Visual indication of the selected business.
- Status indicators for appointment requests.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | Cross-platform mobile application framework |
| Dart | Application programming language |
| SharedPreferences | Local persistence of user and appointment data |
| Material Design | User interface components |
| Android Studio / Visual Studio Code | Development environment |

## 🏗️ Project Structure

```text
Online_Appointment_Management/
│
├── lib/
│   ├── main.dart
│   │
│   ├── models/
│   │   ├── appointment.dart
│   │   └── user.dart
│   │
│   ├── screens/
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   ├── customer_dashboard.dart
│   │   ├── business_dashboard.dart
│   │   └── create_appointment_screen.dart
│   │
│   └── services/
│       ├── auth_service.dart
│       └── appointment_service.dart
│
├── pubspec.yaml
└── README.md
```

### Folder Description

- **`models/`** — Defines the user and appointment data models.
- **`screens/`** — Contains the registration, login, customer dashboard, business dashboard, and appointment creation screens.
- **`services/`** — Handles authentication, user data, appointment creation, and approval operations.
- **`main.dart`** — Application entry point and navigation setup.
- **`pubspec.yaml`** — Defines project dependencies and Flutter configuration.

## ⚙️ Installation and Setup

### Prerequisites

Install the following tools before running the application:

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Dart SDK](https://dart.dev/get-dart) (included with Flutter)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)
- An Android emulator or a physical Android device

### Step 1: Clone the Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
```

### Step 2: Navigate to the Project Directory

```bash
cd Online_Appointment_Management--main
```

### Step 3: Install Dependencies

```bash
flutter pub get
```

### Step 4: Check the Flutter Environment

```bash
flutter doctor
```

### Step 5: Run the Application

Start an Android emulator or connect your device, then execute:

```bash
flutter run
```

## 🔄 Application Workflow

1. A user registers as a customer or business.
2. The user logs in using their registered credentials.
3. Customers access the customer dashboard and select the option to create an appointment.
4. Customers choose a registered business and select a date and time.
5. The application saves the appointment request with a pending status.
6. The associated business views the request on its dashboard.
7. The business approves the appointment.
8. The customer can view the updated appointment status.

## 💾 Data Storage

- The application uses Supabase, a Backend-as-a-Service (BaaS) platform, with a PostgreSQL database for cloud-based data storage.
- Cloud Database: Stores user profiles, business details, and appointment information.
- Authentication: Manages user registration and login.
- Real-Time Updates: Supports appointment status updates.
- Data Synchronization: Enables access across multiple devices.
- Security: Uses Row Level Security (RLS) to protect data.

Integration: The Flutter application connects to Supabase using the supabase_flutter package.

The current implementation does not use a remote database or cloud backend. Data synchronization between different devices is not provided by this local storage approach.

## 🚀 Future Enhancements

- Integrate Firebase or another cloud database for centralized storage.
- Add push notifications for appointment confirmations and updates.
- Implement appointment cancellation and rescheduling.
- Add business search and filtering.
- Prevent conflicting bookings for the same time slot.
- Improve password security and account management.
- Add customer reviews and business ratings.
- Provide a web-based administration dashboard.

## 🎯 Project Objective

The main objective of this project is to simplify appointment scheduling by providing a convenient platform for customers and businesses. It reduces manual coordination, organizes appointment requests, and makes booking status easier to track.

## 👨‍💻 Output
## Login Page
<img width="300" height="500" alt="image" src="https://github.com/user-attachments/assets/ac3ccb04-6523-4174-be06-4c123dc74c81" />

## Client-side
<img width="300" height="500" alt="1000109303" src="https://github.com/user-attachments/assets/a8bd7266-df0e-4df3-a1e4-c70a555a06ca" />
<img width="300" height="500" alt="1000109305" src="https://github.com/user-attachments/assets/4602df4b-219b-42bf-84d3-929ee2887255" />
<img width="300" height="500" alt="1000109311" src="https://github.com/user-attachments/assets/9e273850-e6e7-4040-a6f8-e37854624144" />
<img width="300" height="500" alt="1000109313" src="https://github.com/user-attachments/assets/e8f2725b-a5da-4dbd-8229-7787df396db6" />
<img width="300" height="500" alt="1000109314" src="https://github.com/user-attachments/assets/fc8a54fc-167d-4b05-8bd2-b1c502da4ea9" />

## Business-side
<img width="300" height="500" alt="1000109304" src="https://github.com/user-attachments/assets/d6708aed-d0f3-4e28-b785-8d2f7f5dc5e9" />
<img width="300" height="500" alt="1000109315" src="https://github.com/user-attachments/assets/f341f4b9-4829-4a11-a2e2-148287dc2c1a" />







---

⭐ If you find this project useful, consider giving the repository a star!
