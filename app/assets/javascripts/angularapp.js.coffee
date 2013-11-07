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

@FileOutboxCtrl = ($scope) ->
	$scope.handleDrop = (item) ->
        console.log 'Item has been dropped'
        console.log item
        # generate link for that document
        # add a row in that list
        #console.log $(item)
        console.log document.getElementById(item)
        newRow = document.getElementById("files-to-send").insertRow(-1)
        newCell = newRow.insertCell(0)
        newText = document.createTextNode document.getElementById("document-name-"+item).innerHTML
        newLinkElement = document.createElement("a")
        newLinkElement.href= "/documents/" + item + "/share"
        newLinkElement.appendChild newText
        newCell.appendChild newLinkElement
        newCell.id = "tosend_" + document.getElementById(item).parentNode.id
        # clonedNode = document.getElementById(item).parentNode.cloneNode(true)
        # clonedNode.id = "tosend-" + document.getElementById(item).parentNode.id
        # console.log clonedNode
        # document.getElementById("files-to-send").appendChild(clonedNode)
        false


app.directive 'draggable', -> 
    (scope, element) -> 
        el = element[0]
        el.draggable = true
        el.addEventListener(
            'dragstart',
            (e) -> 
                e.dataTransfer.effectAllowed = 'copy'
                e.dataTransfer.setData('Text', el.id)
                el.classList.add('drag')
        )

        el.addEventListener(
            'dragend',
           (e) ->
                el.classList.remove('drag')
        )

app.directive 'droppable', ->
	    scope:
            drop: '&'
        link: (scope, element) ->
            el = element[0]

            el.addEventListener(
                'dragover',
                (e) ->
                    if e.preventDefault 
                        e.preventDefault()
                    el.classList.add('over')
                    e.dataTransfer.dropEffect = 'copy'
                    false
            )

            el.addEventListener(
                'dragenter',
                (e) ->
                    el.classList.add('over')
                    false
            )

            el.addEventListener(
                'dragleave',
                (e) ->
                    el.classList.remove('over')
            )

            el.addEventListener(
                'drop',
                (e) ->
                    if e.stopPropagation
                        e.stopPropagation()
                    console.log "dropping"
                    el.classList.remove('over')
                    item_id = e.dataTransfer.getData('Text')
                    scope.drop({item: item_id})
                    if e.preventDefault 
                        e.preventDefault()
                    false
            )
        

