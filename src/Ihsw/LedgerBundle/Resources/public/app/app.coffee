module = window.module = angular.module 'ledger', []

# run
run = ($rootScope, $l, BarService) ->
    # events
    $rootScope.$on '$routeChangeStart', (event, next, current) ->
        BarService.resetBarGroups()

    # properties

    # methods
    $rootScope.navigateTo = (path) ->
        $l.path path
run.$inject = ['$rootScope', '$location', 'BarService']
module.run run

# config
config = ($routeProvider) ->
    $routeProvider.
        # misc
        when('/home', {
            controller: 'HomeController'
            templateUrl: 'app/partials/home.html'
        }).
        when('/bullshit', {
            controller: 'BullshitController',
            templateUrl: 'app/partials/bullshit.html'
        }).

        # collections
        when('/collections', {
            controller: 'Collection/IndexController'
            templateUrl: 'app/partials/collection/list.html'
        }).
        when('/collection/new', {
            controller: 'Collection/NewController'
            templateUrl: 'app/partials/collection/new.html'
        }).
        when('/collection/:collectionId/edit', {
            controller: 'Collection/EditController'
            templateUrl: 'app/partials/collection/edit.html'
        }).
        when('/collection/:collectionId', {
            controller: 'Collection/ViewController'
            templateUrl: 'app/partials/collection/view.html'
        }).
        when('/collection/:collectionId/add-item', {
            controller: 'Collection/AddItemController'
            templateUrl: 'app/partials/collection/add-item.html'
        }).

        # items
        when('/item/:itemId/edit', {
            controller: 'Item/EditController'
            templateUrl: 'app/partials/item/edit.html'
        }).

        # entries
        when('/entries', {
            controller: 'Entry/IndexController'
            templateUrl: 'app/partials/entry/list.html'
        }).
        when('/entry/new', {
            controller: 'Entry/NewController'
            templateUrl: 'app/partials/entry/new.html'
        }).
        when('/entry/:entryId', {
            controller: 'Entry/ViewController'
            templateUrl: 'app/partials/entry/view.html'
        }).
        when('/entry/:entryId/edit', {
            controller: 'Entry/EditController'
            templateUrl: 'app/partials/entry/edit.html'
        }).
        when('/entry/:entryId/select-collection', {
            controller: 'Entry/SelectCollectionController'
            templateUrl: 'app/partials/entry/select-collection.html'
        }).
        when('/entry/:entryId/collection/:collectionId/add-item', {
            controller: 'Entry/AddItemController'
            templateUrl: 'app/partials/entry/add-item.html'
        }).

        # entry-items
        when('/entry-item/:entryItemId/edit', {
            controller: 'EntryItem/EditController'
            templateUrl: 'app/partials/entry-item/edit.html'
        }).
        when('/entry-item/:entryItemId/change-item', {
            controller: 'EntryItem/ChangeItemController'
            templateUrl: 'app/partials/entry-item/change-item.html'
        }).

        # finally
        otherwise({ redirectTo: '/home' })
config.$inject = ['$routeProvider']
module.config config