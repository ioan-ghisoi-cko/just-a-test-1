# Demo

To launch the demo and see an example of the checkout ios sdk, follow this steps:

### 1 - Get sandbox account

To get the sandbox account, you can go to the website [checkout.com](checkout.com), click on get sandbox and enter your details.
Once done, you will receive an email with your public and secret key.

### 2 - Clone the repository

Clone the repository and open it with xcode. Replace the public key in `iOS Example/StartViewController` by the one received in the email.

### 3 - Setup the example backend

You can setup a quick backend to launch the demo. Note: The backend is meant for demo purposes.
Deploy the backend to heroku by clicking on the button below:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/floriel-fedry-cko/just-another-test)

Set the `SECRET_KEY` environment variable with the one received in the email and deploy the application.

Once the application is deployed, replaced the value of `baseUrl` in `iOS Example/MerchantAPIClient` by your application url.

e.g.

```swift
  let baseUrl = "https://just-a-test-2.herokuapp.com/"
```

### 4 - Start the demo

Select iOS Example and you can run the demo.
