# iOS-SwiftUI-demo

The code here is a demo for the technical task at Clear Score. This was completed in 1.5 weeks after hours

Notes on the project:
- The project was done with SwiftUI. This was my first use of SwiftUI but I enjoyed the language quirks and the simplicity of state linking comared to story boards
- The app uses an MVVM data pattern
- The app makes a call to the data endpoint on a background thread, and loads a spinner on the main thread. Once the request returns, it either shows a generic error message or the main app UI on success. With more time I would have made the error message more specific and relevant to the issue, as well as a retry mechanism
- The colours in the app change depending on the credit score and other values.
-  A currency formatter is used to convert double and int values to the currency of the device local. Normally I would prefer to get the currency from the API but for formatting purposes the locale will do
- The app has english and spanish language availability
- There is a full suite of unit tests. With  more time I would have used a mocking framework to spoof the API call and test the `fetchData()` function
- There is a basic UI test as well. I would normally find a way to mock this out so that it doesn't require a call to the server in order to run, as this is time consuming
