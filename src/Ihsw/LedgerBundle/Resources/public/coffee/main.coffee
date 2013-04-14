module = angular.module 'ledger', []
module.controller 'TodoCtrl', ['$scope', ($scope) ->
	angular.extend $scope, {
		todos: [
			{ text: 'learn angular', done: true },
			{ text: 'build an angular app', done: false }
		]
		addTodo: ->
			@todos.push({ text: @todoText, done: false })
			@todoText = ''
		remaining: ->
			@todos.reduce (count, todo) ->
				if todo.done then count + 1 else count
			, 0
		archive: ->
			@todos = (todo for todo in @todos when !todo.done)
	}
]