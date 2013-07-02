service = ($http, $window) ->
    R = $window.Routing
    S = {}

    # properties
    S.list =
        values: {}
        getLength: ->
            size = 0
            entries = S.list.values
            for key, value of entries
                if entries.hasOwnProperty key
                    size++
            return size

    # functions
    S.create = (entryItem) ->
        $http.post(R.generate('entryitem_create', { entryId: entryItem.entry.id }), entryItem).then (response) ->
            entryItem = response.data
            S.list.values[entryItem.id] = entryItem

            return entryItem
    S.delete = (entryItem) ->
        $http.delete(R.generate('entryitem_delete', { entryItemId: entryItem.id })).then (response) ->
            delete S.list.values[entryItem.id]

    return S
service.$inject = ['$http', '$window']
window.module.service 'EntryItemService', service