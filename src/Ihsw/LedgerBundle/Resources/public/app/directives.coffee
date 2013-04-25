module = window.module
module.directive 'helloWorld', [() ->
	return {
		restrict: 'E'
		scope:
			name: '@name'
		templateUrl: 'app/partials/items.html'
	}
]
module.directive 'whenActive', ['$location', ($location) ->
	return {
		scope: true
		link: (scope, element, attrs) ->
			scope.$on '$routeChangeSuccess', () ->
				path = "\##{ $location.path() }"
				parent = element.parent()
				if path == element.attr('href')
					parent.addClass 'active'
				else
					parent.removeClass 'active'
	}
]