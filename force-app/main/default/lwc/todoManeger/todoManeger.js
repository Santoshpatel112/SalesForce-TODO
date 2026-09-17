import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

import getUpcomingTasks from '@salesforce/apex/TodoController.getUpcomingTasks';
import getCompletedTasks from '@salesforce/apex/TodoController.getCompletedTasks';
import addTodo from '@salesforce/apex/TodoController.addTodo';
import markTodoAsCompleted from '@salesforce/apex/TodoController.markTodoAsCompleted';
import markTodoAsUpcoming from '@salesforce/apex/TodoController.markTodoAsUpcoming';
import deleteTodo from '@salesforce/apex/TodoController.deleteTodo';

export default class TodoManeger extends LightningElement {
    @track time = '';
    @track greeting = 'Hello';
    @track newTaskTitle = '';
    @track isLoading = false;

    upcomingTasksResult;
    completedTasksResult;

    upcomingTasksList = [];
    completedTasksList = [];

    intervalId;

    connectedCallback() {
        this.getTime();
        // eslint-disable-next-line @lwc/lwc/no-async-operation
        this.intervalId = setInterval(() => {
            this.getTime();
        }, 1000 * 30);
    }

    disconnectedCallback() {
        if (this.intervalId) {
            clearInterval(this.intervalId);
        }
    }

    getTime() {
        const now = new Date();
        const hour = now.getHours();
        const minute = now.getMinutes();

        const formattedHour = hour === 0 ? 12 : hour > 12 ? hour - 12 : hour;
        const formattedMinute = minute < 10 ? `0${minute}` : minute;
        const period = hour >= 12 ? 'PM' : 'AM';

        this.time = `${formattedHour}:${formattedMinute} ${period}`;
        this.greeting = this.computeGreeting(hour);
    }

    computeGreeting(hour) {
        if (hour < 12) {
            return 'Good Morning';
        } else if (hour < 18) {
            return 'Good Afternoon';
        }
        return 'Good Evening';
    }

    @wire(getUpcomingTasks)
    wiredUpcoming(result) {
        this.upcomingTasksResult = result;
        const { data, error } = result;
        if (data) {
            this.upcomingTasksList = data;
        } else if (error) {
            this.showToast('Error', this.extractErrorMessage(error), 'error');
        }
    }

    @wire(getCompletedTasks)
    wiredCompleted(result) {
        this.completedTasksResult = result;
        const { data, error } = result;
        if (data) {
            this.completedTasksList = data;
        } else if (error) {
            this.showToast('Error', this.extractErrorMessage(error), 'error');
        }
    }

    get upcomingCount() {
        return this.upcomingTasksList ? this.upcomingTasksList.length : 0;
    }

    get completedCount() {
        return this.completedTasksList ? this.completedTasksList.length : 0;
    }

    get hasUpcomingTasks() {
        return this.upcomingCount > 0;
    }

    get hasCompletedTasks() {
        return this.completedCount > 0;
    }

    handleInputChange(event) {
        this.newTaskTitle = event.target.value;
    }

    handleKeyUp(event) {
        if (event.key === 'Enter') {
            this.handleAddTodo();
        }
    }

    async handleAddTodo() {
        const title = (this.newTaskTitle || '').trim();
        if (!title) {
            this.showToast('Warning', 'Please enter a task name.', 'warning');
            return;
        }

        this.isLoading = true;
        try {
            await addTodo({ todoName: title });
            this.newTaskTitle = '';
            
            const inputField = this.template.querySelector('lightning-input');
            if (inputField) {
                inputField.value = '';
            }

            this.showToast('Success', 'Task added successfully!', 'success');
            await this.refreshData();
        } catch (error) {
            this.showToast('Error', this.extractErrorMessage(error), 'error');
        } finally {
            this.isLoading = false;
        }
    }

    async handleMarkCompleted(event) {
        const todoId = event.currentTarget.dataset.id;
        if (!todoId) return;

        this.isLoading = true;
        try {
            await markTodoAsCompleted({ todoId });
            this.showToast('Success', 'Task marked as completed.', 'success');
            await this.refreshData();
        } catch (error) {
            this.showToast('Error', this.extractErrorMessage(error), 'error');
        } finally {
            this.isLoading = false;
        }
    }

    async handleMarkUpcoming(event) {
        const todoId = event.currentTarget.dataset.id;
        if (!todoId) return;

        this.isLoading = true;
        try {
            await markTodoAsUpcoming({ todoId });
            this.showToast('Success', 'Task moved back to upcoming.', 'success');
            await this.refreshData();
        } catch (error) {
            this.showToast('Error', this.extractErrorMessage(error), 'error');
        } finally {
            this.isLoading = false;
        }
    }

    async handleDelete(event) {
        const todoId = event.currentTarget.dataset.id;
        if (!todoId) return;

        this.isLoading = true;
        try {
            await deleteTodo({ todoId });
            this.showToast('Success', 'Task deleted.', 'info');
            await this.refreshData();
        } catch (error) {
            this.showToast('Error', this.extractErrorMessage(error), 'error');
        } finally {
            this.isLoading = false;
        }
    }

    async refreshData() {
        await Promise.all([
            refreshApex(this.upcomingTasksResult),
            refreshApex(this.completedTasksResult)
        ]);
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant
        });
        this.dispatchEvent(event);
    }

    extractErrorMessage(error) {
        if (!error) return 'Unknown error occurred.';
        if (typeof error === 'string') return error;
        if (error.body && error.body.message) return error.body.message;
        if (error.message) return error.message;
        return JSON.stringify(error);
    }
}