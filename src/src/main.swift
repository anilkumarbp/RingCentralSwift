//
//  main.swift
//  src
//
//  Created by Anil Kumar BP on 11/17/15.
//  Copyright (c) 2015 Anil Kumar BP. All rights reserved.
//

import Foundation

var app_key: String = ""
var app_secret = ""
var username = ""
var password = ""
var response: ApiResponse


var rcsdk = SDK(appKey: app_key, appSecret: app_secret, server: SDK.RC_SERVER_SANDBOX)
println("SDK initialized")
var platform = rcsdk.platform()
var subscription = rcsdk.createSubscription()
var multipartBuilder = rcsdk.createMultipartBuilder()
println("Platform singleton")
response = platform.login(username, ext:"101", password: password)
println(response.getDict())

// Test a GET request

//platform.refresh()

platform.get("/account/~/extension/~/call-log")
    {
        (apiresponse) in
        println("Response is :")
        println(apiresponse.getResponse())
        println("API response is :")
        println(apiresponse.getDict())
}


// external refresh

println("Performing refresh now")

platform.refresh()



print("completed call-logs")

subscription.addEvents(
    [
        "/restapi/v1.0/account/~/extension/~/presence",
        "/restapi/v1.0/account/~/extension/~/message-store"
    ])

subscription.register()
    {
        (apiresponse) in
        println("Response is :")
        println(apiresponse.getResponse())
        println("API response is :")
        println(apiresponse.getDict())
}


platform.post("/account/~/extension/~/ringout", body :
    [ "to": ["phoneNumber": "18315941779"],
        "from": ["phoneNumber": "15856234190"],
        "callerId": ["phoneNumber": ""],
        "playPrompt": "true"
    ])
    {
        (apiresponse) in
        println("Response is :")
        println(apiresponse.getResponse())
        println("API response is :")
        println(apiresponse.getDict())
        
}




platform.post("/account/~/extension/~/sms", body :
    [ "to": [["phoneNumber": "18315941779"]],
        "from": ["phoneNumber": "15856234190"],
        "text": "Test"
    ])
    {
        (apiresponse) in
        println("Response is :")
        println(apiresponse.getResponse())
        println("API response is :")
        println(apiresponse.getDict())
        
}

print("completed ring-out")

platform.delete("/account/~/extension/~/ringout", query :
    [
        "ringoutId": "264"
    ])
    {
        (apiresponse) in
        println("Response is :")
        println(apiresponse.getResponse())
        println("API response is :")
        println(apiresponse.getDict())

    }


print("ring-out cancelled")

multipartBuilder.setBody([
    "to":["phoneNumber":"15856234120"],
    "faxResolution":"High"
    ])
multipartBuilder.add("sample testing", fileName: "sample.txt")

multipartBuilder.request("/account/~/extension/~/fax")
{
    (apiresponse) in
    println("Response is :")
    println(apiresponse.getResponse())
    println("API response is :")
    println(apiresponse.getDict())

}



