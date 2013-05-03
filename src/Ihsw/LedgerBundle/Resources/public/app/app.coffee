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
            templateUrl: 'app/partials/entries.html'
        }).
        otherwise({ redirectTo: '/home' })
]