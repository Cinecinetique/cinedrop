app = angular.module("Cinecinetique", ["ngResource", "ng-rails-csrf", "$strap.directives", "firebase"])

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

@TasksCtrl = ($scope, angularFire) ->
        console.log ' * Tasks Controller loaded *'
        $scope.tasks = [
            {text: 'walk the dog', done: false},
            {text: 'feed the cat', done: false}
        ];

        $scope.returnTotalTasks = ->
            console.log ' * returnTotalTasks *'
            return $scope.tasks.length

        $scope.remaining_tasks = -> 
            remaining_tasks = []

            for task in $scope.tasks
                remaining_tasks.push task if !task.done
            remaining_tasks

            
        $scope.addNewTask = ->
            console.log ' * addNewTask *'
            if $scope.newTaskText.length
                $scope.tasks.push {text: $scope.newTaskText, done: false}
                $scope.newTaskText = ''

        $scope.archive = () ->
            console.log ' * clearFinishedTasks *'
            filtered_tasks = $scope.remaining_tasks()
            $scope.tasks = filtered_tasks

