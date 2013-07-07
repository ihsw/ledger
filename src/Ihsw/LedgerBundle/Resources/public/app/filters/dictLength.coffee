filter = ->
	return (dict) ->
        size = 0
        for key, value of dict
            if dict.hasOwnProperty key
                size++
        return size
window.module.filter 'dictLength', filter