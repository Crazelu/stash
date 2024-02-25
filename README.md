# Stash

Stash is an iOS app that makes it possible to save contacts outside your contact list. These contacts are identifiable when they call you so you don't lose contact discovery.
Personally, this is useful to me because saving contacts to my contacts list automatically makes them available to platforms like WhatsApp and this means those users can view my status if they
have my contact saved as well. I love my privacy! If you're reading this, you probably love this level of privacy too.

## How to Use

Currently, Stash is not available on the AppStore. You can clone this project and build for your iPhone.
After you've cloned this project, follow these steps:

- Create an app group for all targets
- Create a `Secrets.plist` file in the root directory
- Add `GROUP_ID` key to the `Secrets.plist` file and set it's value as the id of your app group
- Optionally, add `DATA_KEY` key to the `Secrets.plist` file and provide a string value of your choice
- Run the `CallDirectoryExtension` scheme and choose `Stash` as the app to run on

## Features
- [x] Save contact
- [x] Call contact
- [x] Send SMS
- [x] Copy contact number
- [x] Edit contact
- [x] Block contact
- [x] Unblock contact
- [x] Delete contact
- [ ] Choose country code
