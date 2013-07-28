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

link = ($s, element, attrs, TopBarController) ->
	group =
		id: TopBarController.getGroupCount()
		label: $s.$id
		buttons: $s.buttons
	TopBarController.addGroup group

window.module.directive 'topBarGroup', ->
	return {
		require: '^topBar'
		restrict: 'E'
		controller: controller
		link: link
	}