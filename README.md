# react-native-share-menu

## MMKV

- Input
  - sendUrl, this is a url where the uploaded file/s or text and the select contact will be sent
  - contacts, each contact will compose of avatarURL, name, and id
  - UploadURL , this is where the files will be uploaded
- Output
  - Selected contact/s id

## Keychain

Keychain will be used to share tokens from app to share extension

## Uploader

This will take the image/s or video/s or file/s and upload it to generate a storedURL.
Uploading should happen in background service. An ios library could help with this

## Share Intent/suggestion - onSend

A native module that gives access to js method onSend which should be called to store the contact info to be displayed in suggestions.

## Tasks:

- [x] Setup react native project with redux

### iOS

#### Example Project:

- [x] Setup ios Share extension
- [x] Setup ios groups
- [x] Setup react native project with redux
- [x] Setup to read data from mmkv
- [] Setup to read encrypted data from mmkv
- [] Setup to uploader to upload any file type and get back url
- [] Setup a different mmkv store that will not use redux-persist
- [] Setup Keychain to share tokens
- [] Add instructions to use keychain
- [] Setup native module methods for suggestions
- [] Store data back in to mmkv store

### Other

- [] Extract files to npm module
- [] Update instructions
- [] Test with whatsapp/telegram

## Reasoning

I used react native share menu for my own project, and i found it lacking and hard to integrate.

The biggest problem was the lack of support for sharing from whatsapp/telegram.

Sharing multiple items.

Sharing some data between the share extension and the main app

Sharing some secrets between the share extension and the main app

New share intent suggestions.

Share extension on ios needs at least needs to be handled natively because it has a 120MB limit and running js using react native
takes about 50MB, leaving about half to work with.

I think share extension should be responsible to store the data using something like mmkv or optionally upload it to the cloud
and if you need access to it, you have to load the data in on startup or synchronize the data in a service.

This should be the default behaviour on ios and android

I also think the uploading part can be integrated to the share extension.

Only after completing the above features, will this project be released on npm

If you would like to help build the above, please contact me

Add your app as a target for sharing from other apps and write iOS Share Extensions in React Native.

## Installation

```bash
npm i --save react-native-share-menu
```

### Automatic Linking (React Native 0.60+)

At the command line, in the ios directory:

```bash
pod install
```

## [Android Instructions](ANDROID_INSTRUCTIONS.md)

## [iOS Instructions](IOS_INSTRUCTIONS.md)

## [Custom iOS Share View (optional)](SHARE_EXTENSION_VIEW.md)

## [API Docs](API_DOCS.md)

## [Example Project](example/)

Sponsored and developed by [Meedan](http://meedan.com).

iOS version maintained by [Gustavo Parreira](https://github.com/Gustash).
