controller = ($rootScope, $s, BullshitService) ->
    # nav
    $rootScope.section = 'bullshit'

    # properties
    $s.loading = false
    $s.list = {}
    $s.listMetadata = {}

    # methods
    $s.refresh = ->
        $s.loading = true
        $s.list = {}
        $s.listMetadata = {}

        BullshitService.query($s).then (list) ->
            $s.loading = false
            $s.list = list

            listMetadata = {}
            for shitId, shit of list.values
                listMetadata[shit.id] = { deleteDisabled: false }
            $s.listMetadata = listMetadata
    $s.delete = (shit) ->
        if $s.listMetadata[shit.id].deleteDisabled
            return
        $s.listMetadata[shit.id].deleteDisabled = true

        BullshitService.delete($s, shit).then ->
            delete $s.listMetadata[shit.id]

    # initial load
    $s.refresh()
controller.$inject = ['$rootScope', '$scope', 'BullshitService']
window.module.controller 'BullshitController', controller