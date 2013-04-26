module = window.module
module.directive 'helloWorld', [() ->
	return {
		restrict: 'E'
		scope:
			name: '@name'
		templateUrl: 'app/partials/items.html'
	}
]