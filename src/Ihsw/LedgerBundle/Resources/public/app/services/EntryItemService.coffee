service = ($http, $window, EntryService) ->
    R = $window.Routing
    S = {}

    # properties
    S.list = {}

    # functions
    S.create = (entryItem) ->
        $http.post(R.generate('entryitem_create', { entryId: entryItem.entry.id }), entryItem).then (response) ->
            entryItem = response.data
            S.list[entryItem.id] = entryItem

            return entryItem
    S.delete = (entryItem) ->
        $http.delete(R.generate('entryitem_delete', { entryItemId: entryItem.id })).then (response) ->
            delete S.list[entryItem.id]
    S.get = (entryItemId) ->
        $http.get(R.generate('entryitem_show', { entryItemId: entryItemId })).then (response) ->
            entryItem = response.data
            S.list[entryItem.id] = entryItem
            return entryItem
    S.update = (entryItem, newEntryItem) ->
        $http.put(R.generate('entryitem_update', { entryItemId: entryItem.id }), newEntryItem).then (response) ->
            entryItem = response.data
            S.list[entryItem.id] = entryItem
            return entryItem

    return S
service.$inject = ['$http', '$window', 'EntryService']
window.module.service 'EntryItemService', service