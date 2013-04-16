module = window.module = angular.module 'ledger', []
module.config ['$routeProvider', ($routeProvider) ->
    $routeProvider.
        when('/items', {
            controller: 'ItemController'
            templateUrl: 'app/partials/items.html'
        }).
        otherwise({ redirectTo: '/items' })
]