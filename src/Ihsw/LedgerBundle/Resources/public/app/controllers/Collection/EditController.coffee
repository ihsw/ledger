controller = ($rootScope, $s, $l, $r, CollectionService) ->
    # nav
    $rootScope.section = 'collections'

    # properties
    $s.loading = false
    $s.submitDisabled = true
    $s.name = ''
    $s.hasError = false
    $s.collection = {}

    # functions
    $s.refresh = (collectionId) ->
        $s.loading = true
        $s.submitDisabled = true
        $s.name = ''
        $s.hasError = false
        $s.collection = {}

        CollectionService.get(collectionId).then((collection) ->
            $s.loading = false
            $s.submitDisabled = false
            $s.name = collection.name
            $s.collection = collection
        , (response) ->
            $s.loading = false
            $s.hasError = true
        )
    $s.update = (collection) ->
        if $s.submitDisabled
            return
        $s.submitDisabled = true

        CollectionService.update(collection, { name: $s.name }).then (collection) ->
            $l.path '/collections'

    # initial load
    $s.refresh($r.collectionId)
controller.$inject = ['$rootScope', '$scope', '$location', '$routeParams', 'CollectionService']
window.module.controller 'Collection/EditController', controller