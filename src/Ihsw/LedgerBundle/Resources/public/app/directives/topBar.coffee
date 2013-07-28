controller = ($s, TopBarService) ->
	# properties

	# methods
	@addButton = (button) ->
		TopBarService.addButton button

	TopBarService.resetButtons()
	return @
controller.$inject = ['$scope', 'TopBarService']

link = ($s, element, attrs) ->
	# hmm!

window.module.directive 'topBar', ->
	return {
		restrict: 'E'
		scope: {}
		controller: controller
		link: link
	}