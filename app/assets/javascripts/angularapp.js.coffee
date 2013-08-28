app = angular.module("CineCinetique", ["ngResource", "ng-rails-csrf", "$strap.directives", "firebase"])

changesUrl = "https://ccq-notifications.firebaseio.com/changes"
countUrl = "https://ccq-notifications.firebaseio.com/changes_count"


@NavigationCtrl =  ($scope, angularFire) ->

	changes_promise = angularFire(changesUrl, $scope, 'items', {});
	count_promise = angularFire(countUrl, $scope, 'nb_changes', 1);

	$scope.resetNotifications =  ->
		$scope.items = {}
		$scope.nb_changes = 0
