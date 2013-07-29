# misc functions
call = ($s, $l, attrs) ->
	# misc
	callback = attrs.callback ? null
	href = attrs.href ? null

	# handling
	if callback != null
		phase = $s.$root.$$phase
		if phase == '$apply' or phase == '$digest'
			$s.$eval $s.callback
		else
			$s.$apply $s.callback
	else if href != null
		$l.path href

# controller
controller = ($s, $l) ->
	# properties
	$s.button = {}
	$s.BarGroupController = {}
	$s.$l = $l

	# watching the disabled property, and pushing it up on update
	$s.$watch 'disabled', ->
		if typeof $s.disabled == 'undefined'
			return

		if $s.disabled == false
			i = $s.button.classes.indexOf 'disabled'
			if i < 0
				return
			$s.button.classes.splice i, 1
			return

		$s.button.classes.push 'disabled'

	return @
controller.$inject = ['$scope', '$location']

# link
link = ($s, element, attrs, BarGroupController) ->
	# properties
	$s.BarGroupController = BarGroupController

	# generating a button
	button = $s.button =
		id: BarGroupController.getButtonCount()
		label: attrs.label
		classes: attrs.class.split(' ')
		icon: attrs.icon
		call: ->
			call($s, $s.$l, attrs)

	# pushing it up
	BarGroupController.addButton button

# directive definition
window.module.directive 'barButton', ->
	return {
		require: '^barGroup'
		restrict: 'E'
		scope:
			callback: '&'
			disabled: '='
		controller: controller
		link: link
	}