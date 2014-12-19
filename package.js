Package.describe({
  name: 'oaf:autoform-smalot-datetimepicker',
  summary: 'Custom smalot datetimepicker input type for AutoForm',
  version: '0.1.0',
  git: 'https://github.com/oafmedium/meteor-autoform-smalot-datimepicker.git'
});

Package.onUse(function(api) {
  api.use('mikehaney:bootstrap-datetimepicker@2.3.1');
  api.use('coffeescript@1.0.4');
  api.use('momentjs:moment@2.8.4');
  api.use('templating@1.0.0');
  api.use('blaze@2.0.0');
  api.use('aldeed:autoform@4.0.0');
  api.addFiles([
    'oaf:autoform-smalot-datetimepicker.html',
    'oaf:autoform-smalot-datetimepicker.coffee'
  ], 'client');
});
