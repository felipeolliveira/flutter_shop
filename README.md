[![image](https://img.shields.io/badge/Linkedin-felipeolliveira-blue?style=for-the-badge&logo=linkedin)](https://www.linkedin.com/in/felipeolliveira/)

.

> Este aplicativo está em português do Brasil, você pode experimentá-lo sem problemas 😆

> This app is in Brazilian Portuguese, you can try it without any problems 😆

- [Readme em português](./README.ptBR.md)

.

# Flutter Shop

This is a project developed entirely in Flutter 2.0 for study purposes only.

In this application you can create an account, authenticate your user, manage products, bookmark, add to cart and place orders.

For now, I've created it just for Android.


# Tools, Packages and Techs


- **Provider**: state management.
- **Intl**: internationalizations and localization of date, messages, currencies and others.
- **Http**: HTTP Requests
- **Fluttertoast**: Toast messages what don't need Scaffold Widget.
- **Shared_preferences**: data persistence (local storage).
- **Flutter_dotenv**: resolve environment variables.

# Locally Running

Basically you need the Flutter, Dart and Firebase.
You specifically need two built-in Firebase services:

- [Firebase Authentication](https://firebase.google.com/docs/auth)
- [Firebase Realtime Database](https://firebase.google.com/docs/database?hl=pt_br)

Both services are free and have a usage limit, but for studying apps you are unlikely to reach this limit.

After this, you copy the url Firebase Realtime Database and the Firebase Api Key Web inside of the both services: 

- Firebase Api Key Web
![image](./.readme-images/firebase-api-key-location.png)

- Url Firebase Realtime Databas
![image](./.readme-images/realtime-db-url-location.png)


Then insert it into an `.env` file at the root. To make it easier, duplicate the `.env.sample` file and rename it by removinf the `.sample`.

```
# Firebase credentials
FIREBASE_AUTH_URL='insert your Firebase Api Key Web'
FIREBASE_REALTIME_URL='insert your url Firebase Realtime Database'
```

# My experience

![image](./.readme-images/my-app.gif)

# More for Flutter and Dart

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

[![image](https://img.shields.io/badge/Flutter-blue?style=for-the-badge&logo=flutter)](https://flutter.dev/)

[![image](https://img.shields.io/badge/Dart-blue?style=for-the-badge&logo=dart)](https://dart.dev/)
