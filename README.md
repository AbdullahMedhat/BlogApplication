# README

Overall:-
 * This BlogApplication that allow users to post thier own blogs share it with others and able to read other users blogs.
 * Demo for [live version](https://arcane-taiga-96862.herokuapp.com/)


Steps to run the the application
 - App runs with rails v5.1.6, ruby v2.4.0
 - Configure environment variables
    * AUTHY_API [Twilio authy sign_up](https://www.twilio.com/console)
    * FACEBOOK_APP_ID [Facebook developers](https://developers.facebook.com/)
    * FACEBOOK_APP_SECRET
    * GOOGLE_CLIENT_ID [Google developers](https://console.developers.google.com/)
    * GOOGLE_CLIENT_SECRET
    * DATABASE_USERNAME
    * DATABASE_PASSWORD
 - You can add the ENV to the app directly by create /config/local_env.yml and add it, and it will load when the app is up.
 - bundle install
 - rake db:migrate
 - rails s

