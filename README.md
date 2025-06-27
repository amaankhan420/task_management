# ✅ Task Management App (Flutter + Firebase + Hive)

A modular, scalable Task Management App built using Flutter. This project is designed to support core task workflows with clean UI, local persistence, and Firebase Authentication. This README outlines the module currently implemented and the path forward.

---

## 📦 Implemented Module

### 📝 Task Management (Core)

This module allows users to manage their tasks with the following capabilities:

#### ✅ Features Completed

- **Task Listing**
    - Displays all tasks with title, description, status, priority, and due date
    - Overdue tasks are highlighted with a red warning icon

- **Create & Edit Tasks**
    - Add new tasks with:
        - Title (required)
        - Description (optional)
        - Priority (`Low`, `Medium`, `High`)
        - Status (`To Do`, `In Progress`, `Completed`)
        - Due date with Date Picker
    - Edit existing tasks with same form and validation

- **UI/UX**
    - Beautiful, clean, and modern design using Material UI
    - Bottom navigation with 3 tabs: Task List, Add Task, Settings
    - Gradient buttons, soft card shadows, and consistent layout styling

- **Authentication**
    - Firebase Email/Password login and registration
    - Auth-protected routes
    - Logout functionality integrated with Firebase Auth

- **Local Storage**
    - Hive used for storing task data locally

---

## 📱 Screens Completed

- Task List Screen
- Task Form Screen (Create/Edit Task)
- Settings Screen (with Logout)
- Login / Register Screen
- Dashboard with Bottom Navigation

---

## 🛠 Tech Stack

- **Frontend**: Flutter
- **Backend/Storage**: Firebase Auth + Hive (Local DB)
- **State Management**: Provider
- **Other Tools**: Firebase Core, Hive Adapter, Material UI

---

## 🔮 Future Roadmap

The app is built in a modular way to easily scale to additional features. Here's what's planned for the next versions:

### 👥 User Management (Planned)
- Role-based access (Admin, Manager, Member)
- User profiles and account status
- Admin can add/edit users and assign roles

### 👨‍👩‍👧‍👦 Teams Module (Planned)
- Team creation and management
- Assign tasks to teams
- View team-level performance and filtered task views

### 📊 Sales & Target Module (Planned)
- Add/view sales entries with date, amount, and client
- Set monthly/quarterly targets per user or team
- Charts and export options (CSV/Excel)

### 🧠 Add-ons (Optional Future Enhancements)
- Push Notifications via Firebase Cloud Messaging
- Calendar View for due dates
- Kanban-style drag & drop board
- Per-task chat/discussion
- Analytics and Reporting Dashboard

---

## 🚀 How to Run

1. Clone the repository
2. Run `flutter pub get`
3. Connect Firebase and set up `google-services.json`
4. Run the app: `flutter run`

---

## 🙌 Contribution & Feedback

This is an ongoing project. Feedback, suggestions, and feature ideas are welcome!

