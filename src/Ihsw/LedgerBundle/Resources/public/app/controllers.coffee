module = window.module
module.controller 'ItemController', ['$scope', 'ItemService', ($scope, ItemService) ->
	ItemService.query().then (data) ->
		$scope.items = data

	angular.extend $scope, {
		create: () ->
			ItemService.create({ name: @itemName }).then () ->
				@itemName = ''
	}
]