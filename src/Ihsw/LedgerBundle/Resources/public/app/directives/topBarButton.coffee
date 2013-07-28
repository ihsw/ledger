controller = ($s) ->
	# hmm!
controller.$inject = ['$scope']

link = ($s, element, attrs, TopBarController) ->
	button =
		label: attrs.label
		class: attrs.class
		href: attrs.href
	TopBarController.addButton button

window.module.directive 'topBarButton', ->
	return {
		require: '^topBar'
		restrict: 'E'
		scope: {}
		controller: controller
		link: link
	}