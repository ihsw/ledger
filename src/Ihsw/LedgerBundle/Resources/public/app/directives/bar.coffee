controller = ($s, $f, BarService) ->
	# properties
	$s.groups = {}
	$s.BarService = BarService

	# methods
	@addGroup = (group) ->
		$s.groups[group.id] = group
	@getGroupCount = ->
		return $f('dictLength')($s.groups)

	return @
controller.$inject = ['$scope', '$filter', 'BarService']

link = ($s, element, attrs) ->
	if !('target' of attrs)
		throw 'target required in bar directive, not found'
	$s.BarService.setBarGroups attrs.target, $s.groups

window.module.directive 'bar', ->
	return {
		restrict: 'E'
		controller: controller
		link: link
	}