app = angular.module("CineCinetique", ["ngResource", "ng-rails-csrf", "$strap.directives", "firebase"])

fbUrl = "https://ccq-notifications.firebaseio.com/changes"


@NavigationCtrl =  ($scope, angularFire) ->
	promise = angularFire(fbUrl, $scope, 'items', {});
	
