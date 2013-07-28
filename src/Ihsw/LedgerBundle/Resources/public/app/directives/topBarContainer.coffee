controller = ($s, $l, TopBarService) ->
	# properties
	$s.groups = {}

	# methods
	$s.refresh = ->
		$s.resetGroups()
		TopBarService.initialize $s
	$s.setGroups = (groups) ->
		console.log groups
		$s.groups = groups
	$s.resetGroups = ->
		$s.groups = {}

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