window.module.filter 'entriesTotal', ['$filter', ($f) ->
	return (entries) ->
		total = 0
		for id, entry of entries
			total += +$f('entryItemsTotal')(entry.entry_items)
		return total
]