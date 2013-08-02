filter = ($f) ->
    return (dictList) ->
    	dictLength = $f('dictLength')(dictList)
    	newDictList = {}
    	for id, dict of dictList
    	    newId = dictLength-id
    	    dict.id = newId
    	    newDictList[newId] = dict
	    return newDictList
filter.$inject = ['$filter']
window.module.filter 'dictListReverse', filter