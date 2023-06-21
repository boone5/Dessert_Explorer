# Fetch_TakeHomeProject

## Overview
This is my take on a Dessert app defined in the project exercise. I approached this with a minimal design in mind and took some insipration from designs seen on Dribbble.

For this project I chose to target iOS 15 and develop in Xcode 14.3.1. When running this on a physical device, the development team will need to be changed, but there shoudn't be any other hiccups outside of that 🤞.

## Technologies
Below are some tools I used to complete this project.
- SwiftUI
- URLSession
- JSONSerialization
- NSCache
- XCTest
- MVVM

## Potential Improvements
There are some potential improvements I wanted to mention and didn't have the chance to tackle. One feature was handling the state of the app. For example, I would've liked to safely update the UI if a user lost connection or handle other errors that might've happened when fetching and creating data. In my current implementation I throw errors, but don't handle them on the UI.

Building off of this, the addition of logs when errors do happen is another area that could ehance the project. This would be beneficial for tracking errors or crashes in the backend service. A few files mention this where I'm handling an error that was thrown.

There's always room for improvement in a project, but these are just some I wanted to highlight. I'm curious to hear about other improvements I could make!

# Conclusion
Thanks for the oppurtunity, reach out if I can clarify anything!
