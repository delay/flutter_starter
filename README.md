## Flutter Firebase Auth Starter Project

![Screenshots](https://cdn-images-1.medium.com/max/4776/1*wOmpyN5Poy2Y7u4NMmpj9g.png)

So why do another Auth project for flutter? There are dozens of projects already. Including [this one](https://medium.com/@jeffmcmorris/flutter-auth-with-firebase-example-96b64375fff3) I did last year when I was starting with flutter. I made this project for myself because none of the other projects had all of the features I needed. I wanted light and dark mode theming but also the ability to detect and switch themes automatically. I also wanted the ability to switch between languages easily and automatically detect the user’s language. I wanted a simple way to handle translating from english (the only language I know unfortunately). This is accomplished through the excellent package [flutter_sheet_localization](https://github.com/aloisdeniel/flutter_sheet_localization) which allows you to put your translation into a [google sheet](https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit#gid=0) and easily translate into other languages. Also I needed a way to [do simple user roles](https://medium.com/firebase-developers/patterns-for-security-with-firebase-group-based-permissions-for-cloud-firestore-72859cdec8f6) and it needed to be secure. I see a lot of auth packages including roles in the user’s collection in firestore which is usually editable by that same user. This would make it trivial for the user to assign himself admin privileges. I also wanted to show how to put some basic rules in firestore to secure it. Finally I wanted to have a way the user could alter their profile and change their email or password.

There are some really good projects and tutorials that I made use of in making this project. I highly recommend reviewing these other projects as they are much better at explaining things than I am and are far more knowledgeable. Fireship.io [quiz app](https://github.com/fireship-io/flutter-firebase-quizapp-course) and [courses](http://fireship.io) on flutter, [Code with Andrea](https://codewithandrea.com/), and this [starter project](https://github.com/KenAragorn/create_flutter_provider_app) by Ken Aragorn which was my starting point for my own stab at a starter project.

To handle the language translation I used this [package](https://github.com/aloisdeniel/flutter_sheet_localization) which has excellent instructions on how to setup and use it. You need to create a translation for your app in google sheets.

![Google Sheets translation file](https://cdn-images-1.medium.com/max/2000/1*7ltKsU-Tmn418km0gGDftA.png)

You can copy my [sheet](https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit#gid=0) as a starting point for your own app. The cool thing about using a google sheet is you can have google translate a field with a simple google formula: `=GOOGLETRANSLATE(B4,en,fr)` This says translate the phrase in field B4 from english to french. Once you set this package up every time you make changes to your translation in google sheets, you delete your old localizations.g.dart then run the command: flutter packages pub run build_runner build This creates the localizations generated file again.

To handle user roles I created a separate admin collection and added a document with the same document id as the uid of my user. The reason to do this is to make it secure as explained in this [medium article](https://medium.com/firebase-developers/patterns-for-security-with-firebase-group-based-permissions-for-cloud-firestore-72859cdec8f6). I went with the second method explained in that article. If we had just put the roles as a field in the users collection any user could have upgraded themselves to an admin user. So by moving the admin role to a separate collection we can create some rules in firestore that allow the user to update fields about themselves without giving them access to change the role they were assigned. You can also generate other roles for the user by simply adding additional collections for the other roles..

The rules I have setup in firestore for this project are fairly simple. Here are the rules I have created.

![firestore rules](https://cdn-images-1.medium.com/max/2000/1*fug6buAigKDnzzXXxvAgMg.png)

The first rule matches any user in the admin collection and allows you to read that document only. No one is allowed to write to this collection. I manually add my admin users through the firebase console. The second rule allows the user to read and write only if the user matches the currently logged in user. So a user can only change information about themselves. Here is how my collections are setup in firestore.

![firestore collections](https://cdn-images-1.medium.com/max/2060/1*7xKVCWZggfwr7Y8KLs6z6g.png)

Finally I wanted to explain a little bit about my ui. I try to control as much as possible with the theme. You can change a lot about the look with the user interface by changing the theme. I am still learning about what all can be changed with just the theme. I also break out small ui components into a separate components folder. Then I make a custom widget instead of using the standard widget directly. This allows me to make changes in one spot if I decide to make ui changes to say a form field in my form_input_field.dart instead of changing a bunch of TextFormField widgets spread through a dozen files.

## **Overview of project**

**main.dart **— contains provider info for maintaining the state of the app for the theme, language and user. It initializes language and theme settings. Sets up routing and monitors the user for changes.

**localizations.dart **— controls the language for the app.

**localizations.g.dar**t — this file is generated from our google sheet by the [flutter_sheet_localization](https://github.com/aloisdeniel/flutter_sheet_localization) package (do not manually edit this file).

## **/constants/**

**app_themes.dart **— contains info related to our light and dark themes.

**globals.dart** — contains some global app settings

**routes.dart **— contains the app routes.

## /helpers/

**validator.dart **— contains some validation functions for our form fields.

## /models/

**user_model.dart **— contains the model for our user saved in firestore.

**menu_option_model.dart** — contains our model for our language options and theme options in settings.

## /services/

**auth_service.dart** — our user and authentication functions for creating, logging in and out our user and saving our user data.

**language_provider.dart** — saves and loads our language.

**theme_provider.dart **— saves and loads our theme.

## /store/

**db_firestore.dart** — generic functions for working with firestore.

**shared_preferences_helper.dart **— saves our theme and language locally.

## /ui/

**home_ui.dart** — contains the ui for the home which shows info about the user.

**settings_ui.dart** — contains the settings screen for setting the theme and language and some user settings.

## /ui/auth/

**reset_password_ui.dart **— sends a password reset email to the user.

**sign_in_options_ui.dart** — (not currently in use) but provides other login options.

**sign_in_ui.dart **— allows user to login with email and password.

**sign_up_ui.dart **— allows user to create a new account.

**update_profile_ui.dart **— allows user to change his email or name.

## /ui/components/

**avatar.dart** — displays a user avatar on the home_ui.

**dropdown_picker.dart** — shows a dropdown list.

**dropdown_picker_with_icon.dart** — shows a dropdown list with icons.

**form_input_field.dart** — handles our form field elements.

**form_input_field_with_icon.dart** — handles our form field elements but has an icon too.

**form_vertical_spacing.dart** — just a space in the ui.

**label_button.dart** — one type of button in ui.

**logo_graphic_header.dart**— a graphic displayed in our ui.

**primary_button.dart** — another button in the ui.

**segmented_selector.dart** — a control used to select the theme.

**sliding_segmented_control.dart** — some modifications of the Cupertino control which is used by segmented_selector.dart.
