controller = ($s, $l, TopBarService) ->
	# properties
	$s.buttons = []

	# methods
	$s.refresh = ->
		$s.buttons = []

	# initialization
	$s.refresh()
	TopBarService.initialize $s
controller.$inject = ['$scope', '$location', 'TopBarService']

link = ($s, element, attrs) ->
	# hmm!

window.module.directive 'topBarContainer', () ->
	return {
		restrict: 'E'
		replace: true
		templateUrl: 'app/partials/top-bar-container.html'
		controller: controller
		link: link
	}