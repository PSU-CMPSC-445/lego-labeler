# Lego Labeler
Swift UI project to capture labeled images of Lego bricks to generate a dataset of real world images to use with a machine learning image classification model

Setup
=====
1. The package must be loaded and run through XCode
2. The package must be built to an external device, running in an IOS simulator will not allow full access to the camera to use the application
3. The user must have access to [this Google Drive folder](https://drive.google.com/drive/folders/1ahIC3kJB02eQhwJdmjV-ebnoFPQb5jqf?usp=sharing) to use the app.

Using the App
=============
1. Upon launching the app, a user will be requested to sign in to their google account.
2. The user must sign in to a google account that has access to the previously mentioned drive folder
3. Once logged in, a user will type the label for the lego brick to be captured into the text box.
4. A user will then press the lego button to capture a new image.
5. After the image has been captured, a user must press the save button to transfer the new image to the google drive folder.
