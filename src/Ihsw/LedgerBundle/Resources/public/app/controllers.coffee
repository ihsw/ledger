module = window.module
module.controller 'ItemController', ['$scope', 'ItemService', ($scope, ItemService) ->
	angular.extend $scope, {
		items: ItemService.getItems()
		addItem: () ->
			ItemService.addItem { name: @itemName }
			@itemName = ''
	}
]