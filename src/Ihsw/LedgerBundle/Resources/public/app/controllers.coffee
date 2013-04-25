module = window.module
module.controller 'ItemController', ['$scope', 'ItemService', ($scope, ItemService) ->
    angular.extend $scope, {
        create: () ->
            ItemService.create({ name: @name }).then () =>
                @name = ''
        delete: (item) ->
            ItemService.delete(item)
        refresh: () ->
            $scope.loading = true
            ItemService.query().then (items) ->
                $scope.loading = false
                $scope.items = items
        cunts: () ->
            ItemService.cunts()
    }
    $scope.refresh()
]
module.controller 'HomeController', ['$scope', 'ItemService', ($scope, ItemService) ->
]