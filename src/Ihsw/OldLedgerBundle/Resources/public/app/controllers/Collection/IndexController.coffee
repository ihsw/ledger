controller = ($rootScope, $s, CollectionService, $filter) ->
    # nav
    $rootScope.section = 'collections'

    # properties
    $s.loading = false
    $s.listMetadata = {}
    $s.list = {}
    $s.hasError = false

    # functions
    $s.refresh = ->
        $s.loading = true

        CollectionService.query().then (list) ->
            $s.loading = false
            $s.list = list

            listMetadata = {}
            for collectionId, collection of list
                deleteDisabled =
                    value: false
                    tooltip: 'Delete'
                if $filter('dictLength')(collection.items) > 0
                    deleteDisabled =
                        value: true
                        tooltip: 'Has >0 items'
                listMetadata[collectionId] = { deleteDisabled: deleteDisabled }
            $s.listMetadata = listMetadata
    $s.delete = (collection) ->
        if $s.listMetadata[collection.id].deleteDisabled.value
            return
        $s.listMetadata[collection.id].deleteDisabled =
            value: true
            tooltip: 'Deleting'

        CollectionService.delete(collection).then(->
            delete $s.listMetadata[collection.id]
        , (response) ->
            $s.hasError = true
        )
    $s.meta = (collection) ->
        return $s.listMetadata[collection.id]

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', 'CollectionService', '$filter']
window.module.controller 'Collection/IndexController', controller