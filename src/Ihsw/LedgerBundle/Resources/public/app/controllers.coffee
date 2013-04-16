module = window.module
module.controller 'ItemController', ['$scope', 'ItemService', ($scope, ItemService) ->
    ItemService.query().then (items) ->
        $scope.items = items

    angular.extend $scope, {
        create: () ->
            ItemService.create({ name: @itemName }).then () ->
                @itemName = ''
    }
]