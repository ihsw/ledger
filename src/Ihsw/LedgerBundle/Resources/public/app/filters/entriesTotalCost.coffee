filter = ($f) ->
	return (entries) ->
		total = 0
		for id, entry of entries
			total += +$f('entryItemsTotalCost')(entry.entry_items)
		return total
filter.$inject = ['$filter']
window.module.filter 'entriesTotalCost', filter