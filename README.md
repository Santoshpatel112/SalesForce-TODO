# ⚡ Salesforce Modern TODO Manager

[![Salesforce DX](https://img.shields.io/badge/Salesforce-DX-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)](https://developer.salesforce.com/)
[![LWC](https://img.shields.io/badge/Lightning-LWC-blue?style=for-the-badge&logo=lightning)](https://developer.salesforce.com/docs/component-library/overview/components)
[![Apex](https://img.shields.io/badge/Apex-Backend-blueviolet?style=for-the-badge)](https://developer.salesforce.com/)
[![Tests Passing](https://img.shields.io/badge/Apex%20Tests-100%25%20Passing-success?style=for-the-badge)](https://developer.salesforce.com/)

A modern, responsive, full-stack **Task & Todo Management Application** built natively on Salesforce using **Lightning Web Components (LWC)** and **Apex Controllers**.

---

## 🌟 Key Features

- **⚡ Real-Time Task Management**: Create, complete, undo, and delete tasks with instant UI reactivity.
- **🕒 Dynamic Greeting & Live Clock**: Adapts the header greeting (`Good Morning`, `Good Afternoon`, `Good Evening`) and displays live system time.
- **📊 Real-time Stats & Badges**: Live counters for Upcoming and Completed tasks.
- **⌨️ Fast Keyboard Entry**: Add tasks seamlessly by hitting <kbd>Enter</kbd>.
- **🔔 Toast Feedback**: Instant feedback via `ShowToastEvent` for all CRUD actions and error handling.
- **🛡️ Enterprise Security**: Built with `with sharing` Apex, FLS, and dedicated Permission Sets (`ToDo_Manager_Access`).
- **📱 Responsive SLDS Design**: Sleek 2-column layout that adapts to desktops, tablets, and mobile devices.
- **🧪 100% Unit Test Coverage**: Robust test suites exceeding Salesforce deployment thresholds.

---

## 🏗️ Architecture & Component Overview

```
TODO-Manager/
├── force-app/main/default/
│   ├── applications/
│   │   └── Todo_Manager.app-meta.xml        # Lightning Application
│   ├── classes/
│   │   ├── TodoController.cls               # Apex Controller (CRUD & Error Handling)
│   │   └── TodoControllerTest.cls           # Comprehensive Unit Tests (100% Pass)
│   ├── flexipages/
│   │   └── Todo_Manager.flexipage-meta.xml  # Lightning App Page
│   ├── lwc/
│   │   └── todoManeger/                     # Lightning Web Component
│   │       ├── todoManeger.html             # Responsive HTML & SLDS Cards
│   │       ├── todoManeger.js               # Reactive Javascript & Apex Wire
│   │       ├── todoManeger.css              # Polished SLDS Styles & Transitions
│   │       └── todoManeger.js-meta.xml      # Targets (AppPage, HomePage, Tab)
│   ├── objects/
│   │   └── ToDo__c/                         # Custom Object & Custom Fields (Done__c)
│   ├── permissionsets/
│   │   └── ToDo_Manager_Access/             # Object, Field, Apex & Tab Permissions
│   └── tabs/
│       ├── Todo_Manager_App.tab-meta.xml    # Lightning Component Tab
│       └── ToDo__c.tab-meta.xml             # Custom Object Tab
└── config/
    └── project-scratch-def.json             # Scratch Org Definition
```

---

## 🚀 Quick Start & Deployment Guide

### Prerequisites
- [Salesforce CLI (`sf`)](https://developer.salesforce.com/tools/salesforcecli) installed.
- Access to a Salesforce Dev Hub org.

### 1. Clone the Repository
```bash
git clone https://github.com/Santoshpatel112/SalesForce-TODO.git
cd SalesForce-TODO
```

### 2. Connect Your Dev Hub
```bash
sf org login web --set-default-dev-hub --alias Todo
```

### 3. Set Project Target Configuration
```bash
sf config set target-dev-hub=Todo target-org=TODOManeger
```

### 4. Create a Scratch Org (Optional)
```bash
sf org create scratch --definition-file config/project-scratch-def.json --alias TODOManeger --set-default --duration-days 30
```

### 5. Deploy Source Code to Salesforce
```bash
sf project deploy start --ignore-conflicts
```

### 6. Assign Permission Set
```bash
sf org assign permset --name ToDo_Manager_Access
```

### 7. Run Apex Unit Tests
```bash
sf apex run test --class-names TodoControllerTest --result-format human --code-coverage --synchronous
```

### 8. Open the App in Salesforce
```bash
sf org open --path /lightning/app/c__Todo_Manager
```
*(Or click the 9-dot **App Launcher** in Salesforce and search for **Todo Manager**)*

---

## 🧪 Testing

The project includes thorough unit tests in `TodoControllerTest.cls` covering:
- Positive CRUD scenarios (`addTodo`, `markTodoAsCompleted`, `markTodoAsUpcoming`, `deleteTodo`)
- List retrieval queries (`getUpcomingTasks`, `getCompletedTasks`)
- Negative test cases & exception handling (Blank names, Null Ids)

Run tests anytime with:
```bash
sf apex run test --test-level RunLocalTests --result-format human --code-coverage
```

---

## 🛠️ Built With

- **Salesforce Lightning Web Components (LWC)**
- **Salesforce Lightning Design System (SLDS)**
- **Apex & SOQL**
- **Salesforce CLI (`sf`)**

---

## 👤 Author

**Santosh Patel**  
- GitHub: [@Santoshpatel112](https://github.com/Santoshpatel112)
