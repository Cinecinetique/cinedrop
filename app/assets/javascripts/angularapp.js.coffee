app = angular.module("CineCinetique", ["ngResource", "ng-rails-csrf", "$strap.directives", "firebase"])

changesUrls = {}
changesUrls["development"] = "https://ccq-notifications.firebaseio.com/changes"
changesUrls["production"] = "https://ccq-prod-notifications.firebaseio.com/changes"

countUrls = {}
countUrls["development"] = "https://ccq-notifications.firebaseio.com/changes_count"
countUrls["production"] = "https://ccq-prod-notifications.firebaseio.com/changes_count"


@NavigationCtrl =  ($scope, angularFire) ->
	changes_promise = angularFire(changesUrls[rails_env], $scope, 'items', {});
	count_promise = angularFire(countUrls[rails_env], $scope, 'nb_changes', 1);

	$scope.resetNotifications =  ->
		$scope.items = {}
		$scope.nb_changes = 0
