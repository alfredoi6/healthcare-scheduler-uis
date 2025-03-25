# Healthcare Scheduler Demo

A demo project showcasing a Healthcare Scheduler UI built with React and React Native. This app includes basic scheduling functionality, doctor/patient profiles, and notifications, all backed by mocked API calls to demonstrate full-stack development capabilities.

## Features

- **User Authentication:** Login/signup page for users to access the scheduler.
- **Scheduling:** Calendar interface for booking and viewing appointments.
- **Doctor/Patient Profiles:** Simple management of doctor and patient details.
- **Appointments:** Creating, viewing, and managing appointment slots.
- **Notifications:** Send reminders for upcoming appointments.

## Tech Stack

- **Frontend:** React (Web), React Native (Mobile)
- **Backend:** Mocked API calls to simulate data fetching and management
- **Styling:** CSS (for web) / Native styling (for mobile)
  
## Tools & Versions

- **Node.js:** v20.10.0
- **npm:** v10.2.3
- **Yarn:** v1.22.19
- **React (Web):** v19.0.0
- **React Native (Mobile):** v0.76.7

## Initialization Selections

**Next.js web app:**
- TypeScript: Yes
- ESLint: Yes
- Tailwind CSS: Yes
- Code inside a `src/` directory: Yes
- App Router: No
- Turbopack for `next dev`: No
- Import alias `@/*`: No

**React Native mobile app (Expo):**
- Template: tabs (TypeScript) with several example screens and tabs using react-navigation and TypeScript.

## Mobile Development & Testing

We are using **Expo Go** for mobile development and testing. To get started, you can scan the QR code provided by Expo CLI to run the mobile app on your physical device via the Expo Go app (available on both iOS and Android).

## Installation

1. Clone the repository:
   git clone https://github.com/yourusername/healthcare-scheduler-demo.git

2. Install dependencies for both the web and mobile apps:
   cd healthcare-scheduler-demo
   yarn install

3. Run the app:

   - For **web app**:
     yarn dev
   - For **mobile app** (requires Expo Go and Expo environment setup):
     yarn start
     # Then, scan the QR code using Expo Go on your device

## Usage

1. **Web app:** Open in your browser at `http://localhost:3000`
2. **Mobile app:** Launch on your emulator or physical device by scanning the QR code from Expo Go.

## Contributing

Feel free to fork the repository and submit pull requests. If you encounter any issues or have suggestions, please open an issue.

## License

This project is licensed under the MIT License.