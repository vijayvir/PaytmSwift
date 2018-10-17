#  fff

https://stackoverflow.com/questions/31716413/xcode-not-automatically-creating-bridging-header


## Following steps to be solve 

   add framework and objectivec file 
    make bridge file
    solve bridge file issue 
    Target -> BuildSetting -> Objective -c Bridge header  `PayTmDemo/PayTmDemo-Bridging-Header.h `


Solve issue of  follwing issue 
`library not found for -lPaymentsSDK`
https://support.apteligent.com/articles/knowledge_base/Why-getting-Library-not-found-error-in-Xcode-during-integration
to solve this set the correct path of framework in `Libary search paths`



# solving error

`[PayTmDemo.ViewController errorMisssingParameter:error:]:`


Solve issue at server side to goive you checkSum url

make sure merchant key is added at server side 
and add callback url as verify url 

