# ⚡ Salesforce Modern TODO Manager

[![Salesforce DX](https://img.shields.io/badge/Salesforce-DX-00A1E0?style=for-the-badge&logo=salesforce&logoColor=white)](https://developer.salesforce.com/)
[![LWC](https://img.shields.io/badge/Lightning-LWC-blue?style=for-the-badge&logo=lightning)](https://developer.salesforce.com/docs/component-library/overview/components)
[![Experience Cloud](https://img.shields.io/badge/Experience-Cloud%20Ready-blueviolet?style=for-the-badge&logo=salesforce)](https://developer.salesforce.com/docs/atlas.en-us.exp_cloud_lwr.meta/exp_cloud_lwr/)
[![Apex Backend](https://img.shields.io/badge/Apex-Backend-002D62?style=for-the-badge)](https://developer.salesforce.com/)
[![Apex Tests](https://img.shields.io/badge/Apex%20Tests-100%25%20Passing-success?style=for-the-badge)](https://developer.salesforce.com/)
[![Code Style](https://img.shields.io/badge/Code%20Style-Prettier-ff69b4?style=for-the-badge&logo=prettier)](https://prettier.io)

A high-performance, responsive, full-stack **Task & Todo Management Application** built natively on Salesforce using **Lightning Web Components (LWC)**, modern **Apex Controllers**, and **Salesforce Lightning Design System (SLDS)**.

---

## 🌟 Key Features

- **⚡ Real-Time Task Management**: Create, complete, undo, and delete tasks with instant UI reactivity and optimistic wire updates (`refreshApex`).
- **🕒 Dynamic Greeting & Live Clock**: Contextual greeting (`Good Morning`, `Good Afternoon`, `Good Evening`) with an auto-updating live digital clock.
- **📊 Real-Time Metrics & Badges**: Live counters and badges displaying active and completed task statistics.
- **⌨️ Rapid Keyboard Entry**: Add tasks with instant <kbd>Enter</kbd> key support.
- **🌐 Omni-Channel Deployment**: Deployable on **Lightning App Pages**, **Home Pages**, **Record Pages**, **Custom Tabs**, and **Experience Cloud (LWR / Aura sites)**.
- **🔔 Toast Feedback**: Rich notifications powered by `ShowToastEvent` for all CRUD actions and error handling.
- **🛡️ Enterprise Security**: Built using `with sharing` Apex, Field-Level Security (FLS) compliance, and dedicated Permission Sets (`ToDo_Manager_Access`).
- **📱 Responsive SLDS Design**: Clean 2-column card layout with empty state placeholders and mobile/tablet responsive breakpoints.
- **🧪 100% Unit Test Coverage**: Full Apex test suites and LWC Jest unit tests ensuring production-readiness.

---

## 🏗️ Architecture & Component Overview

```
SalesForce-TODO/
├── force-app/main/default/
│   ├── applications/
│   │   └── Todo_Manager.app-meta.xml        # Lightning Application
│   ├── classes/
│   │   ├── TodoController.cls               # Apex Controller (CRUD & Error Handling)
│   │   ├── TodoController.cls-meta.xml      # Apex Metadata (API v67.0)
│   │   ├── TodoControllerTest.cls           # Comprehensive Unit Tests (100% Pass)
│   │   └── TodoControllerTest.cls-meta.xml  # Test Metadata
│   ├── flexipages/
│   │   └── Todo_Manager.flexipage-meta.xml  # Lightning App Page
│   ├── lwc/
│   │   └── todoManeger/                     # Lightning Web Component
│   │       ├── __tests__/                   # Jest Unit Test Suite
│   │       │   └── todoManeger.test.js      # LWC DOM & State Tests
│   │       ├── todoManeger.html             # Responsive SLDS Layout & Cards
│   │       ├── todoManeger.js               # Reactive JS & Apex Wire Adapters
│   │       ├── todoManeger.css              # Custom SLDS Transitions & Styling
│   │       └── todoManeger.js-meta.xml      # Targets (AppPage, HomePage, Tab, Experience Cloud)
│   ├── objects/
│   │   └── ToDo__c/                         # Custom Object Definition
│   │       ├── ToDo__c.object-meta.xml      # Custom Object Metadata
│   │       └── fields/
│   │           └── Done__c.field-meta.xml   # Done Checkbox Field
│   ├── permissionsets/
│   │   └── ToDo_Manager_Access.permissionset-meta.xml # Object, Field, Apex & Tab Permissions
│   └── tabs/
│       ├── Todo_Manager_App.tab-meta.xml    # Lightning Component Tab
│       └── ToDo__c.tab-meta.xml             # Custom Object Tab
├── config/
│   └── project-scratch-def.json             # Scratch Org Definition
├── sfdx-project.json                        # Salesforce Project Configuration
└── package.json                             # LWC Jest, ESLint & Prettier Tooling
```

---

## 📊 Data Model & Schema

| Object    | Field API Name | Data Type | Description                                          |
| :-------- | :------------- | :-------- | :--------------------------------------------------- |
| `ToDo__c` | `Name`         | Text (80) | Task description / title (_Required_)                |
| `ToDo__c` | `Done__c`      | Checkbox  | Task status (`true` = Completed, `false` = Upcoming) |
| `ToDo__c` | `CreatedDate`  | DateTime  | Audit timestamp for chronological sorting            |

---

## 🚀 Quick Start & Deployment Guide

### Prerequisites

- [Salesforce CLI (`sf`)](https://developer.salesforce.com/tools/salesforcecli) installed (`sf --version`).
- Access to a Salesforce Org (Scratch Org, Developer Edition, or Sandbox).
- Node.js (v18+) for local LWC testing (optional).

---

### Option A: Scratch Org Deployment (Recommended)

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Santoshpatel112/SalesForce-TODO.git
   cd SalesForce-TODO
   ```

2. **Authenticate with your Dev Hub org:**

   ```bash
   sf org login web --set-default-dev-hub --alias DevHub
   ```

3. **Create a Scratch Org:**

   ```bash
   sf org create scratch --definition-file config/project-scratch-def.json --alias TODOOrg --set-default --duration-days 30
   ```

4. **Deploy Source Metadata:**

   ```bash
   sf project deploy start
   ```

5. **Assign the Permission Set:**

   ```bash
   sf org assign permset --name ToDo_Manager_Access
   ```

6. **Run Unit Tests:**

   ```bash
   sf apex run test --class-names TodoControllerTest --result-format human --code-coverage --synchronous
   ```

7. **Open the App:**
   ```bash
   sf org open --path /lightning/app/c__Todo_Manager
   ```

---

### Option B: Developer Org / Sandbox Deployment

1. **Authenticate directly to your target org:**

   ```bash
   sf org login web --alias MyDevOrg --set-default
   ```

2. **Deploy the project:**

   ```bash
   sf project deploy start --ignore-conflicts
   ```

3. **Assign the Permission Set to your user:**

   ```bash
   sf org assign permset --name ToDo_Manager_Access
   ```

4. **Launch the Application:**
   ```bash
   sf org open --path /lightning/app/c__Todo_Manager
   ```
   _(Or click the 9-dot **App Launcher** in Salesforce and search for **Todo Manager**)_

---

## 🧪 Testing & Code Quality

### Apex Unit Tests

Execute the comprehensive Apex test suite with code coverage analysis:

```bash
sf apex run test --class-names TodoControllerTest --result-format human --code-coverage --synchronous
```

**Test Coverage Highlights:**

- ✅ Positive CRUD scenarios (`addTodo`, `markTodoAsCompleted`, `markTodoAsUpcoming`, `deleteTodo`)
- ✅ Retrieval queries (`getUpcomingTasks`, `getCompletedTasks`)
- ✅ Exception handling & validation guards (Empty Task name, Null IDs)

### LWC Jest Unit Tests

```bash
npm install
npm test
```

For coverage report:

```bash
npm run test:unit:coverage
```

### Code Formatting & Linting

```bash
# Format code across Apex, LWC, XML, CSS, HTML
npm run prettier

# Run ESLint for LWC
npm run lint
```

---

## 🛡️ Security & Permissions

The application includes a granular Permission Set: **`ToDo_Manager_Access`**

- **Object Permissions**: Full Read, Create, Edit, and Delete on `ToDo__c`.
- **Field Permissions**: Read and Edit access on `ToDo__c.Done__c`.
- **Apex Class Access**: Enabled for `TodoController`.
- **Custom Tab Visibility**: Enabled for `Todo_Manager_App` and `ToDo__c`.

---

## 🛠️ Tech Stack

- **Frontend**: Salesforce Lightning Web Components (LWC), JavaScript (ES6+), SLDS CSS
- **Backend**: Apex (with sharing), SOQL, Lightning Data Service / Apex Wire Adapters
- **Target Channels**: Lightning Experience, Salesforce Mobile App, Experience Cloud (Digital Experiences)
- **Dev Tools**: Salesforce CLI (`sf`), Prettier, ESLint, Jest, Git

---

## 👤 Author

**Santosh Patel**

- **GitHub**: [@Santoshpatel112](https://github.com/Santoshpatel112)
- **Repository**: [SalesForce-TODO](https://github.com/Santoshpatel112/SalesForce-TODO)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details (or open source for developer community use).
