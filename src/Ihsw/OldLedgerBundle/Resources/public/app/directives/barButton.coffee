# controller
controller = ($s, $f, BarService, $document) ->
    C = @

    ### SCOPE
    ###
    # properties
    $s.button = {}
    $s.items = {}

    # methods
    $s.call = (href, callback) ->
        if $f('dictLength')($s.items) == 0
            BarService.call $s, href, callback
            return

        opened = !$s.button.opened
        $s.button.opened = opened
    $s.getItems = ->
        return $f('dictListReverse')($s.items)
    $s.greetings = ->
        alert 'fuck'

    # watches
    $s.$watch 'disabled', ->
        if typeof $s.disabled == 'undefined'
            return

        if $s.disabled == false
            i = $s.button.classes.indexOf 'disabled'
            if i < 0
                return
            $s.button.classes.splice i, 1
            return

        $s.button.classes.push 'disabled'

    ### CONTROLLER
    ###
    # methods
    C.addItem = (item) ->
        item.id = $f('dictLength')($s.items)
        $s.items[item.id] = item
    C.onItemCall = (item) ->
        $s.button.opened = false

    return C
controller.$inject = ['$scope', '$filter', 'BarService', '$document']

# link
link = ($s, element, attrs, BarGroupController) ->
    # generating a button
    classValue = attrs.class ? ''
    button = $s.button =
        label: attrs.label
        classes: classValue.split(' ')
        icon: attrs.icon
        items: $s.getItems()
        opened: false
        itemAlignment: attrs.itemAlignment
        call: ->
            $s.call attrs.href, attrs.callback

    # pushing it up
    BarGroupController.addButton button

# directive definition
window.module.directive 'barButton', ->
    return {
        require: '^barGroup'
        restrict: 'E'
        scope:
            callback: '&'
            disabled: '='
        controller: controller
        link: link
        transclude: true
        template: '<div ng-transclude/>'
    }