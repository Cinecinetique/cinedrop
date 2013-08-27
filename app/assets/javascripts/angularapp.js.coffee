app = angular.module("CineCinetique", ["ngResource", "ng-rails-csrf", "$strap.directives", "firebase"])

fbUrl = "https://ccq-notifications.firebaseio.com/"


@NavigationCtrl =  ($scope, angularFire) ->
	$scope.popover = {
		"title": "Changed documents"
	}
	promise = angularFire(fbUrl, $scope, 'items', []);
	
