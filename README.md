# 💈 Salon Appointment Scheduler

Hi! This is one of my database projects for the **freeCodeCamp Relational Database Certification**. 

In this project, I created an interactive terminal-based booking application connected to a PostgreSQL database named `salon`. It manages customers, services, and appointment schedules in real time using a custom Bash script.

## ✂️ About the Project

The core objective was to build a fully normalized relational database alongside a dynamic CLI interface that handles customer registration, service selection, and appointment scheduling seamlessly.

* **`salon.sh`** - An interactive Bash script that prompts users for service choices, verifies existing customers via phone numbers, collects new user details, and schedules appointments in PostgreSQL.
* **`salon.sql`** - The complete PostgreSQL database dump generated using `pg_dump`, containing schema definitions and base lookup data.

## 🛠️ What I Learned & Key Takeaways

Building this system reinforced important concepts in database management and shell scripting:

* **Relational Schema Design:** Created three linked tables (`services`, `customers`, and `appointments`) using foreign keys and constraints (`UNIQUE`, `SERIAL`).
* **Subshell & Variable Isolation:** Learned how piped processes (`echo | while`) run inside subshells in Bash, requiring database-driven validation instead of local arrays to preserve state.
* **DRY (Don't Repeat Yourself) Principles:** Refactored repetitive hardcoded menus into a single, dynamic function capable of handling any service stored in the database.
* **Interactive CLI Logic:** Designed fallback loops for invalid user inputs and built condition-based database insertions (`INSERT INTO customers` only when a phone record is absent).

## ⚡ Challenges & Debugging Highlights

Working through this script came with several practical development hurdles:

* **Debugging Bash Pipe & Command Execution Errors:** Overcame syntax errors (`command not found`) when querying PostgreSQL via shell variables by properly setting up `PSQL` connection flags (`-X --no-align --tuples-only -c`) and formatting subshell pipes.
* **Transitioning from Hardcoded Switches to Dynamic Data:** Initially attempted hardcoded `case` statements for individual service menus (`HAIRCUT_MENU`, `MANICURE_MENU`). Realized that querying `services` directly made the application dynamic, shorter, and compliant with automated test suites.
* **Customer Lookup Logic:** Handled conditional flow based on database output, ensuring existing customers aren't prompted for their names repeatedly while correctly registering new ones.

### 💭 Final Thoughts

Navigating the logic behind recursive menus and shell-to-database communication was tricky at first, but working through it step-by-step made the process really rewarding. Building this project was a solid step forward in strengthening my backend and relational database skills for future projects!
