@isTest
private class TodoControllerTest {
    @TestSetup
    static void setupTestData() {
        List<ToDo__c> testTodos = new List<ToDo__c>{
            new ToDo__c(Name = 'Upcoming Task 1', Done__c = false),
            new ToDo__c(Name = 'Upcoming Task 2', Done__c = false),
            new ToDo__c(Name = 'Completed Task 1', Done__c = true)
        };
        insert testTodos;
    }

    @isTest
    static void testGetUpcomingTasks() {
        Test.startTest();
        List<ToDo__c> upcoming = TodoController.getUpcomingTasks();
        Test.stopTest();

        System.assertEquals(2, upcoming.size(), 'Should return 2 upcoming tasks');
        for (ToDo__c todo : upcoming) {
            System.assertEquals(false, todo.Done__c, 'Upcoming tasks should have Done__c as false');
        }
    }

    @isTest
    static void testGetCompletedTasks() {
        Test.startTest();
        List<ToDo__c> completed = TodoController.getCompletedTasks();
        Test.stopTest();

        System.assertEquals(1, completed.size(), 'Should return 1 completed task');
        System.assertEquals(true, completed[0].Done__c, 'Completed task should have Done__c as true');
    }

    @isTest
    static void testAddTodoSuccess() {
        Test.startTest();
        ToDo__c newTodo = TodoController.addTodo('New Test Task');
        Test.stopTest();

        System.assertNotEquals(null, newTodo.Id, 'Task should have been inserted with an Id');
        System.assertEquals('New Test Task', newTodo.Name, 'Name should match input');
        System.assertEquals(false, newTodo.Done__c, 'New task should not be completed');
    }

    @isTest
    static void testAddTodoBlankError() {
        Boolean caughtException = false;
        Test.startTest();
        try {
            TodoController.addTodo('   ');
        } catch (AuraHandledException e) {
            caughtException = true;
        }
        Test.stopTest();

        System.assert(caughtException, 'Should throw AuraHandledException for blank task name');
    }

    @isTest
    static void testMarkTodoAsCompleted() {
        ToDo__c todo = [SELECT Id, Done__c FROM ToDo__c WHERE Done__c = false LIMIT 1];

        Test.startTest();
        TodoController.markTodoAsCompleted(todo.Id);
        Test.stopTest();

        ToDo__c updated = [SELECT Id, Done__c FROM ToDo__c WHERE Id = :todo.Id];
        System.assertEquals(true, updated.Done__c, 'Task should be marked as completed');
    }

    @isTest
    static void testMarkTodoAsUpcoming() {
        ToDo__c todo = [SELECT Id, Done__c FROM ToDo__c WHERE Done__c = true LIMIT 1];

        Test.startTest();
        TodoController.markTodoAsUpcoming(todo.Id);
        Test.stopTest();

        ToDo__c updated = [SELECT Id, Done__c FROM ToDo__c WHERE Id = :todo.Id];
        System.assertEquals(false, updated.Done__c, 'Task should be marked as upcoming');
    }

    @isTest
    static void testDeleteTodo() {
        ToDo__c todo = [SELECT Id FROM ToDo__c LIMIT 1];
        Id todoId = todo.Id;

        Test.startTest();
        TodoController.deleteTodo(todoId);
        Test.stopTest();

        List<ToDo__c> remaining = [SELECT Id FROM ToDo__c WHERE Id = :todoId];
        System.assertEquals(0, remaining.size(), 'Task should be deleted from database');
    }

    @isTest
    static void testNullIdHandling() {
        Test.startTest();
        Boolean caughtCompleted = false;
        try {
            TodoController.markTodoAsCompleted(null);
        } catch (AuraHandledException e) {
            caughtCompleted = true;
        }

        Boolean caughtUpcoming = false;
        try {
            TodoController.markTodoAsUpcoming(null);
        } catch (AuraHandledException e) {
            caughtUpcoming = true;
        }

        Boolean caughtDelete = false;
        try {
            TodoController.deleteTodo(null);
        } catch (AuraHandledException e) {
            caughtDelete = true;
        }
        Test.stopTest();

        System.assert(caughtCompleted, 'Should throw for null Id on mark completed');
        System.assert(caughtUpcoming, 'Should throw for null Id on mark upcoming');
        System.assert(caughtDelete, 'Should throw for null Id on delete');
    }
}
