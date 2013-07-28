window.module.directive 'helloWorld', [() ->
	return {
		restrict: 'E'
		scope:
			name: '@name'
		templateUrl: 'app/partials/hello.html'
	}
]