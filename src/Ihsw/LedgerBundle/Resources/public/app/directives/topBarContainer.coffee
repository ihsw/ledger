controller = ($s, $l, TopBarService) ->
	# properties
	$s.buttons = []

	# methods
	$s.refresh = ->
		$s.resetButtons()
		TopBarService.initialize $s
	$s.addButton = (button) ->
		$s.buttons.push button
	$s.resetButtons = ->
		$s.buttons = []

	# refreshing
	$s.refresh()
controller.$inject = ['$scope', '$location', 'TopBarService']

window.module.directive 'topBarContainer', () ->
	return {
		restrict: 'E'
		replace: true
		templateUrl: 'app/partials/top-bar-container.html'
		controller: controller
	}