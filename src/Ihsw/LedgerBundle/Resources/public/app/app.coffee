module = window.module = angular.module 'ledger', ['ui.bootstrap']
module.config ['$routeProvider', ($routeProvider) ->
    $routeProvider.
        when('/home', {
            controller: 'HomeController'
            templateUrl: 'app/partials/home.html'
        }).
        when('/items', {
            controller: 'ItemController'
            templateUrl: 'app/partials/items.html'
        }).
        when('/entries', {
            controller: 'EntryController'
            templateUrl: 'app/partials/entry/list.html'
        }).
        when('/entry/new', {
            controller: 'EntryNewController'
            templateUrl: 'app/partials/entry/new.html'
        }).
        when('/bullshit', {
            controller: 'BullshitController',
            templateUrl: 'app/partials/bullshit.html'
        }).
        otherwise({ redirectTo: '/home' })
]