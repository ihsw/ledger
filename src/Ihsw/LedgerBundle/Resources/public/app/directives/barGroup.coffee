controller = ($s, $f) ->
	# properties
	$s.buttons = {}

	# methods
	@addButton = (button) ->
		$s.buttons[button.id] = button
	@getButtonCount = ->
		return $f('dictLength')($s.buttons)

	return @
controller.$inject = ['$scope', '$filter']

link = ($s, element, attrs, BarController) ->
	group =
		id: BarController.getGroupCount()
		label: $s.$id
		buttons: $s.buttons
	BarController.addGroup group

window.module.directive 'barGroup', ->
	return {
		require: '^bar'
		restrict: 'E'
		controller: controller
		link: link
	}