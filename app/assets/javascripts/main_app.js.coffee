@mainApp = angular.module('mainApp', ['ui.bootstrap', 'angularFileUpload', 'templates', 'lk-google-picker', 'smart-table', 'ngAnimate', 'mgcrea.ngStrap', 'mgcrea.ngStrap.modal', 'pascalprecht.translate'])

@mainApp.config(['lkGoogleSettingsProvider', '$translateProvider', '$locationProvider', (lkGoogleSettingsProvider, $translateProvider, $locationProvider) ->
  lkGoogleSettingsProvider.configure(
    apiKey   : 'AIzaSyDmWgJX2KkmDWH-DrGGvBgVlrKUq8vID3A',
    clientId : '326780241952-5kbkbo58evurqrrr1nhdoie8qjjpocsd.apps.googleusercontent.com',
    scopes   : ['https://www.googleapis.com/auth/drive'],
    locale   : 'en'
    views    : ['DocsView().setIncludeFolders(true)']
  )

  $locationProvider.html5Mode(enabled: true, requireBase: false)

  $translateProvider.translations('en', {
    computer: 'Choose From Computer',
    dropbox_chooser: 'Choose From Dropbox',
    dropbox_saver: 'Save To Dropbox',
    google_drive_chooser: 'Choose From Google Drive',
    google_drive_saver: 'Save To Google Drive',
    url: 'Choose From Url',
    dropzone: 'or drag & drop files on this zone',
    convert: 'Convert All',
    download: 'Download',
    header: 'Select Files to Convert',
    modal_title: 'Add file by url',
    not_valid_url: 'Not valid url!',
    submit: 'Submit',
    cancel: 'Cancel',
    filename: 'Filename',
    format: 'Format',
    extension: 'Extension',
    state: 'State',
    created_at: 'Created At',
    send_email: 'Send email after convertation',
    email: 'Enter your email'
  });
  $translateProvider.translations('ru', {
    computer: 'Выбрать с компьютера',
    dropbox_chooser: 'Выбрать из Dropbox',
    dropbox_saver: 'Сохранить в Dropbox',
    google_drive_chooser: 'Выбрать из Google Drive',
    google_drive_saver: 'Сохранить в Google Drive',
    url: 'Указать url адрес',
    dropzone: 'или перетяните их на страницу',
    convert: 'Сконвертировать',
    download: 'Скачать',
    header: 'Выберите файлы для преобразования',
    modal_title: 'Добавить файл через url',
    not_valid_url: 'Неверный url!',
    submit: 'Добавить',
    cancel: 'Закрыть',
    filename: 'Имя файла',
    format: 'Формат',
    extension: 'Расширение',
    state: 'Статус',
    created_at: 'Дата создания'
    send_email: 'Прислать email после конвертации',
    email: 'Введите свой email'
  });
  $translateProvider.preferredLanguage('ru');
])
