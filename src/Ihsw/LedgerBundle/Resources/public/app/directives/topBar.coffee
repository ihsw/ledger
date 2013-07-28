controller = ($s, TopBarService) ->
	@addButton = (button) ->
		TopBarService.addButton button

	return @
controller.$inject = ['$scope', 'TopBarService']

window.module.directive 'topBar', ->
	return {
		restrict: 'E'
		controller: controller
	}