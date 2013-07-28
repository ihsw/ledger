controller = ($s, $f, TopBarService) ->
	# properties
	$s.groups = {}
	$s.TopBarService = TopBarService

	# methods
	@addGroup = (group) ->
		$s.groups[group.id] = group
	@getGroupCount = ->
		return $f('dictLength')($s.groups)

	return @
controller.$inject = ['$scope', '$filter', 'TopBarService']

link = ($s, element, attrs) ->
	$s.TopBarService.setGroups $s.groups

window.module.directive 'topBar', ->
	return {
		restrict: 'E'
		controller: controller
		link: link
	}