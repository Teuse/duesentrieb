# duesentrieb
Düsentrieb is a MacOs MenuBar App for quick access to GitHub functionality!

## Build the app

Bevor you build the app, you must setup the github url and your branches. Furthermore, you need to create a access token on github.

### Create Github Access Token

* Go to Github and login
* Click your profile icon (upper left corner) and open Settings
* Developer Settings
* Personal access tokens
* Here, you need to create a access token. Make sure to copy the token because you wont be able to get the token again.
* You will need the token in the next step

### Prepare Xcode

Open the xcode project and go to 'AppDelegate.swift'
Set github url and github token (see previous step)

Next, you need to setup the repositories you want to see in the app.
Go to 'GithubViewModel' and change the 'repos' array for your needs

You might also need to adjust the Team, Certificate and bundle identifier. 

-> Now build the app and enjoy

