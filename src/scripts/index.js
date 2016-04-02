require('../../node_modules/angular/angular')
require('../../node_modules/angular-ui-router/release/angular-ui-router')

var _ = require('lodash')

var feministyDotCom = angular.module('feministyDotCom', [
  // angular
  'ui.router',
])

feministyDotCom.config(function($stateProvider, $urlRouterProvider) {
  $stateProvider.state('home', {
    views: {
      "landing-page": {
        templateUrl: 'templates/landing-page.html'
      }
    },
    url: '/'
  }).state('patterns', {
    views: {
      "nav": {
        templateUrl: 'templates/menu.html'
      },
      "header": {
        templateUrl: 'templates/header_submenu.html'
      },
      "content": {
        templateUrl: 'templates/patterns.html'
      }
    },
    url: '/patterns'
  }).state('category', {
    views: {
      "nav": {
        templateUrl: 'templates/menu.html'
      },
      "header": {
        templateUrl: 'templates/header_submenu.html'
      },
      "content@": {
        templateUrl: function ($stateParams) {
          return 'templates/category_' + $stateParams.id + '.html'
        }
      }
    },
    url: '/patterns/category/:id'
  }).state('pattern', {
    views: {
      "nav": {
        templateUrl: 'templates/menu.html'
      },
      "header": {
        templateUrl: 'templates/header.html'
      },
      "content@": {
        templateUrl: function ($stateParams) {
          return 'templates/pattern_' + $stateParams.id + '.html'
        }
      }
    },
    url: '/:id'
  })
  $urlRouterProvider.otherwise('/');
})

// main controller
feministyDotCom.controller('mainController', function($scope) {
  // probably stuff
})