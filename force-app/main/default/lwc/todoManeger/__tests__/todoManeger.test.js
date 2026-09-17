import { createElement } from '@lwc/engine-dom';
import TodoManeger from 'c/todoManeger';

describe('c-todo-maneger', () => {
    afterEach(() => {
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('keeps upcoming and completed tasks separate and removes the correct item', async () => {
        const element = createElement('c-todo-maneger', {
            is: TodoManeger
        });

        document.body.appendChild(element);

        element.todos = [
            { id: '1', text: 'Write report', completed: false },
            { id: '2', text: 'Pay bills', completed: true },
            { id: '3', text: 'Call mom', completed: false }
        ];

        await Promise.resolve();

        expect(element.upcomingTasks).toHaveLength(2);
        expect(element.completedTasks).toHaveLength(1);

        element.toggleTodoStatus('1');
        await Promise.resolve();
        expect(element.upcomingTasks).toHaveLength(1);
        expect(element.completedTasks).toHaveLength(2);

        element.deleteTodo('2');
        await Promise.resolve();
        expect(element.completedTasks).toHaveLength(1);
        expect(element.completedTasks[0].text).toBe('Write report');
        expect(element.shadowRoot.querySelectorAll('.upcoming-item')).toHaveLength(1);
        expect(element.shadowRoot.querySelectorAll('.completed-item')).toHaveLength(1);
    });
});