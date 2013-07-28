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

link = ($s, element, attrs, TopBarGroupController) ->
	button =
		id: TopBarGroupController.getButtonCount()
		label: attrs.label
		class: attrs.class
		call: ->
			call($s, attrs)
	TopBarGroupController.addButton button

window.module.directive 'topBarButton', ->
	return {
		require: '^topBarGroup'
		restrict: 'E'
		scope:
			callback: '&'
		controller: controller
		link: link
	}