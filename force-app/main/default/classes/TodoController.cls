public with sharing class TodoController {
    @AuraEnabled(cacheable=true)
    public static List<ToDo__c> getUpcomingTasks() {
        try {
            return [
                SELECT Id, Name, Done__c, CreatedDate, CreatedBy.Name, LastModifiedBy.Name
                FROM ToDo__c
                WHERE Done__c = false
                ORDER BY CreatedDate DESC
                LIMIT 500
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching upcoming tasks: ' + e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<ToDo__c> getCompletedTasks() {
        try {
            return [
                SELECT Id, Name, Done__c, CreatedDate, CreatedBy.Name, LastModifiedBy.Name
                FROM ToDo__c
                WHERE Done__c = true
                ORDER BY CreatedDate DESC
                LIMIT 500
            ];
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching completed tasks: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static ToDo__c addTodo(String todoName) {
        if (String.isBlank(todoName)) {
            throw new AuraHandledException('Task name cannot be empty.');
        }

        try {
            ToDo__c todo = new ToDo__c();
            todo.Name = todoName.trim();
            todo.Done__c = false;

            insert todo;
            return todo;
        } catch (Exception e) {
            throw new AuraHandledException('Error adding task: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void markTodoAsCompleted(Id todoId) {
        if (todoId == null) {
            throw new AuraHandledException('Task Id is required.');
        }

        try {
            ToDo__c todo = [
                SELECT Id, Done__c
                FROM ToDo__c
                WHERE Id = :todoId
                LIMIT 1
            ];

            todo.Done__c = true;
            update todo;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating task: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void markTodoAsUpcoming(Id todoId) {
        if (todoId == null) {
            throw new AuraHandledException('Task Id is required.');
        }

        try {
            ToDo__c todo = [
                SELECT Id, Done__c
                FROM ToDo__c
                WHERE Id = :todoId
                LIMIT 1
            ];

            todo.Done__c = false;
            update todo;
        } catch (Exception e) {
            throw new AuraHandledException('Error updating task: ' + e.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteTodo(Id todoId) {
        if (todoId == null) {
            throw new AuraHandledException('Task Id is required.');
        }

        try {
            ToDo__c todo = [
                SELECT Id
                FROM ToDo__c
                WHERE Id = :todoId
                LIMIT 1
            ];

            delete todo;
        } catch (Exception e) {
            throw new AuraHandledException('Error deleting task: ' + e.getMessage());
        }
    }
}