RestInPlaceEditor.forms.checkbox =
  activateForm : ->
    @update()

  getValue : ->
    @$element.is(':checked')
