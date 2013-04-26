module = window.module
module.controller 'ItemController', ['$rootScope', '$timeout', '$scope', 'ItemService', ($rootScope, $timeout, $scope, ItemService) ->
    $rootScope.section = 'items'

    angular.extend $scope, {
        create: () ->
            ItemService.create({ name: @name }).then (item) =>
                @name = ''
                @itemMetadata[item.id] = { deleteDisabled: false }
        delete: (item) ->
            if !@itemMetadata[item.id].deleteDisabled
                @itemMetadata[item.id].deleteDisabled = true
                ItemService.delete(item).then () =>
                    delete @itemMetadata[item.id]
        refresh: () ->
            @loading = true
            ItemService.query().then (items) =>
                @loading = false
                @items = items

                itemMetadata = {}
                for itemId, item of items
                    itemMetadata[itemId] = { deleteDisabled: false }
                @itemMetadata = itemMetadata
    }
    $scope.refresh()
]
module.controller 'HomeController', ['$rootScope', ($rootScope) ->
    $rootScope.section = 'home'
]