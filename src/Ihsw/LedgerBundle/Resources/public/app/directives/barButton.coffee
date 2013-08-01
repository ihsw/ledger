# misc functions
call = ($s, $l, href, callback) ->
    # misc
    callback = callback ? null
    href = href ? null

    # handling
    if callback != null
        phase = $s.$root.$$phase
        if phase == '$apply' or phase == '$digest'
            $s.$eval $s.callback
        else
            $s.$apply $s.callback
    else if href != null
        $l.path href

# controller
controller = ($s, $l) ->
    # scope properties
    $s.button = {}

    # scope methods
    $s.call = (href, callback) ->
        call $s, $l, href, callback

    # scope watches
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

    return @
controller.$inject = ['$scope', '$location']

# link
link = ($s, element, attrs, BarGroupController) ->
    # generating a button
    button = $s.button =
        id: BarGroupController.getButtonCount()
        label: attrs.label
        classes: attrs.class.split(' ')
        icon: attrs.icon
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
    }