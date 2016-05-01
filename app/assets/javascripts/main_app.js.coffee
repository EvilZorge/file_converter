@mainApp = angular.module('mainApp', ['ui.bootstrap', 'angularFileUpload', 'templates', 'lk-google-picker', 'smart-table', 'ngAnimate', 'mgcrea.ngStrap', 'mgcrea.ngStrap.modal'])

@mainApp.config(['lkGoogleSettingsProvider', (lkGoogleSettingsProvider) ->
  lkGoogleSettingsProvider.configure(
    apiKey   : 'AIzaSyDmWgJX2KkmDWH-DrGGvBgVlrKUq8vID3A',
    clientId : '326780241952-5kbkbo58evurqrrr1nhdoie8qjjpocsd.apps.googleusercontent.com',
    scopes   : ['https://www.googleapis.com/auth/drive'],
    locale   : 'en'
    views    : ['DocsView().setIncludeFolders(true)']
  )
])
