filter = ->
	return (entryItems) ->
		total = 0
		for id, entryItem of entryItems
			total += +entryItem.quantity
		return total
window.module.filter 'entryItemsTotalQuantity', filter