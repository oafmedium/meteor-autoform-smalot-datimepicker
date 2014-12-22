AutoForm.addInputType "oaf-datetimepicker",
  template: "OafDatetimepicker"
  valueOut: ->
    moment(@val()).toDate()

  valueConverters:
    string: (val) ->
      (if (val instanceof Date) then val.toString() else val)

    stringArray: (val) ->
      return [val.toString()]  if val instanceof Date
      val

    number: (val) ->
      (if (val instanceof Date) then val.getTime() else val)

    numberArray: (val) ->
      return [val.getTime()]  if val instanceof Date
      val

    dateArray: (val) ->
      return [val]  if val instanceof Date
      val

  contextAdjust: (context) ->
    context.atts["data-timezone-id"] = context.atts.timezoneId  if context.atts.timezoneId
    delete context.atts.timezoneId

    context

Template.OafDatetimepicker.helpers atts: addFormControlAtts = ->
  atts = _.clone(@atts)

  # Add bootstrap class
  atts = AutoForm.Utility.addClass(atts, "form-control")
  atts

Template.OafDatetimepicker.rendered = ->
  $input = @$("input")
  $div = @$('div.oafDatetimepicker')
  data = @data
  opts = data.atts.dateTimePickerOptions or {}

  # To be able to properly detect a cleared field, the defaultDate,
  # which is "" by default, must be null instead. Otherwise we get
  # the current datetime when we call getDate() on an empty field.
  opts.defaultDate = null  if not opts.defaultDate or opts.defaultDate is ""

  # instanciate datetimepicker
  dtp = $div.datetimepicker opts
  # set and reactively update values

  startOf = (date) ->
    date.setHours 0,0,0,0
    date
  endOf = (date) ->
    date.setHours 23,59,59,999
    date

  dtp.on 'changeDate', (event) ->
    $input.val new Date event.date.valueOf()
    $input.trigger 'change'
    $input.trigger 'changeDate'
  dtp.on 'changeDay', (event) ->
    $input.val startOf new Date event.date.valueOf()
    $input.trigger 'change'
  @autorun ->
    data = Template.currentData()

    # set field value
    if data.value instanceof Date
      $div.datetimepicker 'setDate', data.value
    else
      $div.datetimepicker 'setDate', new Date()

    # set start date if there's a min in the schema
    if data.min instanceof Date
      $div.datetimepicker 'setStartDate', data.min
    else
      $div.datetimepicker 'setStartDate', null

    # set end date if there's a max in the schema
    if data.max instanceof Date
      $div.datetimepicker 'setEndDate', data.max
    else
      $div.datetimepicker 'setEndDate', null
    return

  return
