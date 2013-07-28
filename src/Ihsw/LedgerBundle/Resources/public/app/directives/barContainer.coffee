controller = ($s, $l, BarService) ->
	# properties
	$s.bar = {}

	# methods
	$s.initialize = (name) ->
		$s.bar = BarService.initialize name
controller.$inject = ['$scope', '$location', 'BarService']

link = ($s, element, attrs) ->
	$s.initialize attrs.name

window.module.directive 'barContainer', () ->
	return {
		restrict: 'E'
		replace: true
		templateUrl: 'app/partials/bar-container.html'
		scope: {}
		controller: controller
		link: link
	}