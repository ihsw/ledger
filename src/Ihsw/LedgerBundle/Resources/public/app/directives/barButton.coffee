call = ($s, attrs) ->
	# misc
	callback = attrs.callback ? null
	href = attrs.href ? null
	$l = $s.$l

	# handling
	if callback != null
		phase = $s.$root.$$phase
		if phase == '$apply' or phase == '$digest'
			$s.$eval $s.callback
		else
			$s.$apply $s.callback
	else if href != null
		$l.path href

controller = ($s, $l) ->
	$s.$l = $l
controller.$inject = ['$scope', '$location']

link = ($s, element, attrs, BarGroupController) ->
	button =
		id: BarGroupController.getButtonCount()
		label: attrs.label
		class: attrs.class
		call: ->
			call($s, attrs)
	BarGroupController.addButton button

window.module.directive 'barButton', ->
	return {
		require: '^barGroup'
		restrict: 'E'
		scope:
			callback: '&'
		controller: controller
		link: link
	}