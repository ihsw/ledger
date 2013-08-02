# controller
controller = ($s, $f) ->
    C = @

    ### SCOPE
    ###
    # properties
    $s.group = {}
    $s.buttons = {}

    # methods
    $s.getButtons = ->
        return $f('dictListReverse')($s.buttons)

    ### CONTROLLER
    ###
    # methods
    C.addButton = (button) ->
        button.id = $f('dictLength')($s.buttons)
        $s.buttons[button.id] = button

    return C
controller.$inject = ['$scope', '$filter']

# link
link = ($s, element, attrs, BarController) ->
    # generating a group
    group = $s.group =
        id: BarController.getGroupCount()
        buttons: $s.getButtons()

    # pushing it up
    BarController.addGroup group

# directive definition
window.module.directive 'barGroup', ->
    return {
        require: '^bar'
        restrict: 'E'
        controller: controller
        link: link
    }