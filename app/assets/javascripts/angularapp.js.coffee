app = angular.module("Cinecinetique", ["ngResource", "ng-rails-csrf", "$strap.directives", "firebase"])

changesUrls = {}
changesUrls["development"] = "https://ccq-notifications.firebaseio.com/changes"
changesUrls["production"] = "https://ccq-prod-notifications.firebaseio.com/changes"

countUrls = {}
countUrls["development"] = "https://ccq-notifications.firebaseio.com/changes_count"
countUrls["production"] = "https://ccq-prod-notifications.firebaseio.com/changes_count"

tasksUrls = {}
tasksUrls["development"] = "https://ccq-notifications.firebaseio.com/user_tasks/"
tasksUrls["production"] = "https://ccq-prod-notifications.firebaseio.com/user_tasks/"
remindersUrls = {}
remindersUrls["development"] = "https://ccq-notifications.firebaseio.com/reminders/"
remindersUrls["production"] = "https://ccq-prod-notifications.firebaseio.com/reminders/"


@NavigationCtrl =  ($scope, angularFire) ->
	changes_promise = angularFire(changesUrls[rails_env], $scope, 'items', {});
	count_promise = angularFire(countUrls[rails_env], $scope, 'nb_changes', 1);

	$scope.resetNotifications =  ->
		$scope.items = {}
		$scope.nb_changes = 0

@TasksCtrl = ($scope, angularFire) ->
	tasks_promise = switch 
		when mode == 'user_tasks' then angularFire("#{tasksUrls[rails_env]}#{remote_id}/", $scope, 'tasks', [])
		when mode == 'reminders' then angularFire("#{remindersUrls[rails_env]}#{remote_id}/", $scope, 'tasks', [])

	tasks_promise.then ->
		$scope.returnTotalTasks = ->
		    return $scope.tasks.length

		$scope.remaining_tasks = -> 
		    remaining_tasks = [] 

		    for task in $scope.tasks
		        remaining_tasks.push task if !task.done
		    remaining_tasks

		    
		$scope.addNewTask = ->
		    if $scope.newTaskText.length
		        $scope.tasks.push {text: $scope.newTaskText, done: false}
		        $scope.newTaskText = ''

		$scope.archive = () ->
		    filtered_tasks = $scope.remaining_tasks()
		    $scope.tasks = filtered_tasks

