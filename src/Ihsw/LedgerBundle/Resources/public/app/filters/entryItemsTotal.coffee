window.module.filter 'entryItemsTotal', [() ->
	return (entryItems) ->
		total = 0
		for id, entryItem of entryItems
			total += +entryItem.cost
		return total
]