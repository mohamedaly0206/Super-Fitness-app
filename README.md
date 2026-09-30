# Super Fitness

<p align="center">
  A complete fitness and wellness mobile application built with Flutter, combining workouts, nutrition, and an AI-powered Smart Coach in one modern experience.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white"/>
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white"/>
  <img src="https://img.shields.io/badge/Clean%20Architecture-Architecture-4CAF50?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/MVI-State%20Management-FF5722?style=for-the-badge"/>
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black"/>
  <img src="https://img.shields.io/badge/Ollama-AI-black?style=for-the-badge"/>
</p>
<p align="center">
  <img src="shots/cover.png" alt="Super Fitness Cover" width="100%"/>
</p>

## Overview

Super Fitness is a modern fitness and wellness mobile application designed to help users manage their workouts, nutrition, and fitness journey in one place.

The application provides a personalized experience based on user information such as age, height, weight, fitness goal, and activity level.

Super Fitness brings together workout discovery, exercise videos, healthy recipes, nutritional information, and an AI-powered Smart Coach.

The application supports both Arabic and English and uses a modern UI with a dark theme and Glassmorphism-inspired components.

---

## Features

### Authentication & Onboarding

The application provides a complete authentication and onboarding experience.

- Login
- Registration
- Social Authentication
- Forgot Password
- OTP verification
- Password change
- Gender selection
- Age selection
- Weight selection
- Height selection
- Fitness goal selection
- Activity level selection

The collected fitness information is used to provide a more personalized experience throughout the application.

---

### Home

The Home screen provides quick access to the main fitness content and recommendations.

- Personalized greeting
- Fitness categories
- Exercise recommendations
- Muscle group recommendations
- Upcoming workouts
- Healthy food recommendations
- Quick access to different sections of the application

---

### Workouts & Exercises

Super Fitness provides a wide collection of exercises covering different muscle groups and workout categories.

Users can:

- Browse different workout categories
- Explore exercises for different muscle groups
- View exercise details
- Discover different workout levels
- Access recommended exercises
- Watch instructional exercise videos

Each exercise provides relevant information to help users understand the movement and the targeted muscle group.

#### Exercise Videos

Exercise videos are integrated with YouTube and can be watched directly inside the application, allowing users to learn the exercise without leaving the app.

---

### Healthy Recipes & Nutrition

The application also provides a dedicated nutrition section containing a variety of healthy recipes.

Each recipe can include:

- Recipe description
- Ingredients
- Calories
- Protein
- Carbohydrates
- Other nutritional information
- Cooking video

Users can explore different healthy meals while viewing their nutritional information and preparation instructions.

#### Cooking Videos

Recipe videos can be opened and watched directly inside the application.

---

### Smart Coach

Super Fitness includes an AI-powered Smart Coach designed to provide users with conversational assistance throughout their fitness journey.

The Smart Coach is powered using Ollama and uses the user's fitness information and context to provide a more personalized interaction.

#### Chat History

Firebase is used to persist Smart Coach conversations.

Users can:

- Start a new conversation
- View previous conversations
- Continue existing conversations
- Edit conversations
- Delete conversations
- Manage multiple conversations

---

### Profile

The Profile section allows users to manage their personal and fitness information.

Users can:

- View their profile
- Edit personal information
- Update weight
- Update fitness goal
- Update activity level
- Manage account settings
- Close their account

---

### Localization

Super Fitness supports:

- English
- Arabic

The application provides a localized experience for both languages.

---

## Screenshots

### Home, Workouts & Exercise Details

<p align="left">
  <img src="shots/9.png" width="190"/>
  
  <img src="shots/10.png" width="190"/>
  
  <img src="shots/11.png" width="190"/>
  
  <img src="shots/12.png" width="190"/>
  
  <img src="shots/13.png" width="190"/>
  
  <img src="shots/14.png" width="190"/>
  
  <img src="shots/15.png" width="190"/>
  
  <img src="shots/16.png" width="190"/>
  
  <img src="shots/17.png" width="190"/>

</p>

---

### Smart Coach

<p align="left">
  <img src="shots/18.png" width="190"/>
  <img src="shots/19.png" width="190"/>
  <img src="shots/20.png" width="190"/>
  <img src="shots/21.png" width="190"/>
</p>

---

### Healthy Recipes & Nutrition

<p align="left">
  <img src="shots/22.png" width="190"/>
  <img src="shots/23.png" width="190"/>
  <img src="shots/24.png" width="190"/>
</p>

---

### Account Management & Fitness Information
 
<p align="left">
  <img src="shots/25.png" width="190"/>
  <img src="shots/26.png" width="190"/>
  <img src="shots/30.png" width="190"/>
  <img src="shots/27.png" width="190"/>
  <img src="shots/28.png" width="190"/>
  <img src="shots/29.png" width="190"/>
  <img src="shots/31.png" width="190"/>
  <img src="shots/32.png" width="190"/>
</p>

---

### Onboarding & Login & Registration

<p align="left">
  <img src="shots/o1.jpeg" width="190"/>
  <img src="shots/o2.jpeg" width="190"/>
  <img src="shots/o3.jpeg" width="190"/>
  <img src="shots/1.png" width="190"/>
</p>

<p align="left">
  <img src="shots/2.png" width="190"/>
  <img src="shots/3.png" width="190"/>
  <img src="shots/4.png" width="190"/>
  <img src="shots/5.png" width="190"/>
  <img src="shots/6.png" width="190"/>
  <img src="shots/7.png" width="190"/>
  <img src="shots/8.png" width="190"/>
</p>

---

### Password Management 

<p align="left">
  <img src="shots/f1.png" width="190"/>
  <img src="shots/f2.png" width="190"/>
  <img src="shots/f3.png" width="190"/>
  <img src="shots/f4.png" width="190"/>
  <img src="shots/f5.png" width="190"/>
</p>

## Tech Stack

### Mobile Development

- Flutter
- Dart

### Architecture & State Management

- Clean Architecture
- MVI
- Dependency Injection
- GetIt
- Cubit

### Networking & APIs

- Retrofit
- REST APIs
- Multiple API integrations

### Backend & Cloud

- Firebase

### Artificial Intelligence

- Ollama
- AI-powered Smart Coach

### Testing

- Unit Testing

### Integrations

- YouTube
- Arabic & English Localization

---

## Architecture

Super Fitness follows Clean Architecture principles to keep the application scalable, maintainable, and testable.

The project separates responsibilities between the main application layers:

```text
┌─────────────────────────────┐
│        Presentation         │
│                             │
│       UI / MVI / State      │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│           Domain            │
│                             │
│     Entities / Use Cases    │
│    Repository Contracts     │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│            Data             │
│                             │
│ Models / Repositories       │
│ Remote Data Sources         │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       APIs / Firebase       │
└─────────────────────────────┘
```

This separation keeps presentation logic, business logic, data handling, and external services independent from each other.

---

## MVI State Management

The application uses MVI to manage user interactions and application state.

The general flow is:

```text
User Interaction
       ↓
     Intent
       ↓
   ViewModel
       ↓
    Use Case
       ↓
   Repository
       ↓
 Data Source
       ↓
 API / Firebase
       ↓
     State
       ↓
      UI
```

This approach keeps state transitions predictable and makes application features easier to maintain and test.

---

## Smart Coach Architecture

The Smart Coach combines AI processing with persistent conversation history.

```text
User
 ↓
Smart Coach UI
 ↓
User Message
 ↓
User Fitness Context
 ↓
Ollama
 ↓
AI Response
 ↓
Smart Coach UI
```

Chat persistence is handled through Firebase:

```text
User Conversation
       ↓
  Smart Coach
       ↓
    Firebase
       ↓
  Chat History
       ↓
Previous Conversations
```

This allows users to maintain and manage their previous conversations.

---

## Firebase

Firebase is used for persistent Smart Coach conversations.

The chat system allows users to:

- Save conversations
- Retrieve previous conversations
- Create new chats
- Edit conversations
- Delete conversations
- Continue previous conversations

---

## Testing

The project includes Unit Testing to verify important application logic and maintain reliability across core functionality.

The separation provided by Clean Architecture also helps keep business logic isolated and easier to test.

---

## Main Application Flow

```text
Application Launch
        ↓
      Splash
        ↓
 Authentication
        ↓
     Register
        ↓
 Personalized Onboarding
        ↓
 User Fitness Information
        ↓
      Home
        ↓
 ┌──────┼──────────┬──────────┐
 ↓      ↓          ↓          ↓
Home  Workouts  Smart Coach  Profile
        │           │
        ↓           ↓
   Exercises      AI Chat
        │           │
        ↓           ↓
    YouTube      Firebase
        │
        ↓
 Exercise Details
```

---

## Project Goals

Super Fitness brings together three main areas of a user's fitness journey.

### Training

Explore exercises and workouts for different muscle groups with instructional videos and exercise details.

### Nutrition

Discover healthy recipes with ingredients, nutritional information, calories, protein, carbohydrates, and cooking videos.

### Personalized Assistance

Interact with an AI-powered Smart Coach using the user's fitness information and conversation history.


# Team

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=26&duration=3000&pause=1000&color=36BCF7&center=true&vCenter=true&width=500&lines=Team+Members;Flutter+Developers" alt="Team Animation"/>
</p>

<table width="100%">

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/omarameen77.png" width="110" alt="Omar Ameen"/>

</td>

<td width="80%" valign="middle">

### Omar Ameen

**Mobile Developer**

<a href="https://github.com/omarameen77">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>

<a href="https://www.linkedin.com/in/omar-amin-083645344">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>

<a href="https://wa.me/201031430691">
<img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/>
</a>

📧 **Email:** [omar.amin.saad1@gmail.com](mailto:omar.amin.saad1@gmail.com)

📱 **Phone:** +20 103 143 0691

</td>
</tr>

<tr>
<td colspan="2" align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&height=3&color=36BCF7" width="92%"/>

</td>
</tr>

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/YassmenaAbdullah.png" width="110" alt="Yasmeen Abdallah"/>

</td>

<td width="80%" valign="middle">

### Yasmeen Abdallah

**Mobile Developer**

<a href="https://github.com/YassmenaAbdullah">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>

<a href="https://www.linkedin.com/in/yasmena-abdallah">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>

<a href="https://wa.me/20155188312">
<img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/>
</a>

📧 **Email:** [yassmenabdallah76@gmail.com](mailto:yassmenabdallah76@gmail.com)

📱 **Phone:** +20 155 188 312

</td>
</tr>

<tr>
<td colspan="2" align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&height=3&color=36BCF7" width="92%"/>

</td>
</tr>

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/ziad-sleem.png" width="110" alt="Ziad Sleem"/>

</td>

<td width="80%" valign="middle">

### Ziad Sleem

**Mobile Developer**

<a href="https://github.com/ziad-sleem">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>

<a href="https://www.linkedin.com/in/ziad-selim-26a153427/">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>

<a href="https://wa.me/201202728355">
<img src="https://img.shields.io/badge/WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white"/>
</a>

📧 **Email:** [ziadselim03@gmail.com](mailto:ziadselim03@gmail.com)

📱 **Phone:** +20 120 272 8355

</td>
</tr>

<tr>
<td colspan="2" align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&height=3&color=36BCF7" width="92%"/>

</td>
</tr>

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/mohamedaly0206.png" width="110" alt="Mohamed Aly"/>

</td>

<td width="80%" valign="middle">

### Mohamed Aly

**Mobile Developer**

<a href="https://github.com/mohamedaly0206">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>

<a href="https://www.linkedin.com/in/mohamed-aly-0877792b6/">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>

📧 **Email:** [mo7amed3ly77@gmail.com](mailto:mo7amed3ly77@gmail.com)

📱 **Phone:** +20 102 345 6789

</td>
</tr>

<tr>
<td colspan="2" align="center">

<img src="https://capsule-render.vercel.app/api?type=rect&height=3&color=36BCF7" width="92%"/>

</td>
</tr>

<tr>
<td width="20%" align="center" valign="middle">

<img src="https://github.com/khalidadel365.png" width="110" alt="Khaled Adel"/>

</td>

<td width="80%" valign="middle">

### Khaled Adel

**Mobile Developer**

<a href="https://github.com/khalidadel365">
<img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"/>
</a>

<a href="https://www.linkedin.com/in/khalid-adel44">
<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"/>
</a>

</td>
</tr>

</table>
