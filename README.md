# RingCentral Swift SDK ( Beta )

[![Build Status](https://travis-ci.org/anilkumarbp/RingCentralSwift.svg?branch=master)](https://travis-ci.org/anilkumarbp/RingCentralSwift)
[![codecov.io](https://codecov.io/github/anilkumarbp/RingCentralSwift/coverage.svg?branch=master)](anilkumarbp/RingCentralSwift.svg?branch=master)

***

1. [Getting Started](#getting-started)
2. [Initialization](#initialization)
3. [Authorization](#authorization)
4. [Performing API Call](#performing-api-call)
5. [Performing RingOut](#performing-ringout)
6. [Sending SMS](#sending-sms)
7. [Subscription](#subscription)
8. [SDK Demos](#sdk-demos)

***

## Requirements

- iOS 8.0+
- Xcode 6.3+


# Getting Started


### CocoaPods **(recommended)**

The RingCentral Swift SDK is a CocoaPod written in Swift. [CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate RingCentral Swift SDK into your Xcode project, navigate to the directory that contains your project and create a new **Podfile** with `pod init` or open an existing one, then add the following line:

```ruby
platform :ios, '8.0'
use_frameworks!

pod 'ringcentral'
```

Then, run the following command to install the dependency:

```bash
$ pod install
```


### If you do not Use CocoaPods, manually Add Subprojects

You can integrate RingCentral Swift SDK into your project manually without using a dependency manager.

Drag the `src` project into your own and add the resource as an **Embedded Binary**, as well as a **Target Dependency** and **Linked Framework** (under Build Phases) in order to build on the simulator and on a device.

<p align="center">
  <img src="https://github.com/anilkumarbp/RingCentralSwift/blob/master/img/Add_SubProject.png" alt="Manually Install Framework"/>
</p>


# Initialization

The RingCentral SDK is initiated in the following ways.

**Sandbox:**

    var rcsdk = SDK(appKey: app_key, appSecret: app_secret, server: SDK.RC_SERVER_SANDBOX)

**Production:**

    var rcsdk = SDK(appKey: app_key, appSecret: app_secret, server: SDK.RC_SERVER_PRODUCTION)

The 'app_key' and 'app_secret' should be read from a configuration file.

Depending on the stage of production, either                                        
**SDK.RC_SERVER_SANDBOX** or **SDK.RC_SERVER_PRODUCTION**                                   
will be used as the 'server' parameter.

# Authorization

To authorize the platform, extract the 'Platform' object:

    var platform = rcsdk.platform()

Once the platform is extracted, call:

    platform.login(username, password: password)

or (to authorize with extension):

    platform.authorize(username, ext: ext, password: password)

The SDK will automatically refresh the token so long the refresh token lives.

*Caution*: If no extension is specified, platform automitically refers extension 101 (default).
***

# Performing API Call

Currently all requests can be made through the following:

```swift
platform.get('/account/~/extension/~')
platform.post('/account/~/extension/~', body: [])
platform.put('/account/~/extension/~', body: [])
platform.delete('/account/~/extension/~', query: [])

```

Attach the following code as a completion handler (**always**) :
```swift
    {
      (transaction) in
        if (error) {
            // do something for error
        } else {
            // continue with code
        }
    }
```

Returning 'data' into a Dictionary (JSON): This is handled by the **ApiResponse** class within the SDK. we can retrieve the dictionary as shown below

NSJSON Serialization handled by **ApiResponse** class :
```swift
    NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &errors) as! NSDictionary  
```    
Retrieve the dictionary in your application as shown below :
```swift
    transaction.getDict()
```

For readability of the data

    println(transaction.getDict())


# Performing RingOut

RingOut follows a two-legged style telecommunication protocol.
The following method call is used to send a Ring Out.

    apiCall([
        "method": "POST",
        "url": "/restapi/v1.0/account/~/extension/~/ringout",
        "body": ["to": ["phoneNumber": "14088861168"],
                 "from": ["phoneNumber": "14088861168"],
                 "callerId": ["phoneNumber": "13464448343"],
                 "playPrompt": "true"]
    ])

# Sending SMS

The follow method call is used to send a SMS.

platform.postSms("hi i'm min", to: "12345678912") // true
    
    apiCall([
        "method": "POST",
        "url": "/restapi/v1.0/account/~/extension/~/sms",
        "body": ["to": [{"phoneNumber": "14088861168"}],
                 "from": ["phoneNumber": "14088861168"],
                 "text": "send message"
    ])


# Subscription

To enable subscription, type:

    self.subscription = Subscription(platform: self)
    subscription!.register()

In order for PubNub to do something after a callback:

    platform.subscription!.setMethod({
        (arg) in
        // do whatever you need to with the callback variable 'arg'
    })

An example in the demo is provided that changes the status color accordingly.

***

# SDK Demo 1

Login page:
    Insert app_key, app_secret, username, password in order to log in.
    This is generally done through a configuration file.

![Alt text](/img/login.png?raw=true "Optional Title")

Phone page:
    Use the number pad to type the numbers you need.
    The Status Bar (initially shown as a red rectangle 'No Call') changes color accordingly.
    Allows the sending of SMS and Fax, along with the ability to make calls.

![Alt text](/img/phone.png?raw=true "Optional Title")

Log page:
    Shows implementation of the 'Call Log' along with the 'Message Log'.

![Alt text](/img/log.png?raw=true "Optional Title")


