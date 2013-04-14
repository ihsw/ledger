module = window.module
module.factory 'ItemService', () ->
	{
		items: [
			{ id: 1, name: 'Derp' }
		]
		getItems: () ->
			@items
		addItem: (item) ->
			item.id = if @items.length == 0 then 1 else @items[@items.length - 1].id + 1
			@items.push item
	}