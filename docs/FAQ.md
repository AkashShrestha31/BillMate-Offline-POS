# BizTrack — Frequently Asked Questions

BizTrack helps hotels and similar businesses manage sales, purchases, parties, inventory, employees, and day-end operations. This FAQ covers common questions for daily use on mobile.

---

## Getting started

### What is BizTrack?
BizTrack is a business management app for recording sales and purchase invoices, managing customers and suppliers (parties), tracking stock, handling payments, and viewing summaries on the dashboard.

### Do I need internet to use the app?
The app can run in **offline (local)** mode after first-time setup. Data is stored on your device. When a server connection is configured, you can sync data from the **More** tab. Day-to-day entry works without internet once setup is complete.

### What happens on first install?
1. Optional **walkthrough** (overview of Home, Expenses, Parties).
2. **Local setup** — organization name, company details, admin user (name, email, password), country, currency, fiscal year, chart of accounts, optional bank name.
3. **Login** with the email and password you created during setup.

### I forgot my password. What can I do?
On the login screen, use any password recovery option your administrator provides. In **local-only** installs, passwords are stored on the device database — contact whoever set up the device or repeat local setup only if your IT policy allows resetting the local database (this removes existing data unless backed up).

### Can I change organization details after setup?
Some organization settings are fixed at setup. Company name and user profile can often be updated from **More → Profile** or employee edit screens, depending on your role and permissions.

---

## Login & security

### What do I use to log in?
Your **email address** and **password** from local setup (or credentials issued by your administrator). The app remembers your session until you log out.

### Why was I logged out?
You tapped **Logout**, the session was cleared, or the app data was reset. Log in again with the same email and password.

### Who can see financial data?
Access depends on **role and permissions** (e.g. supervisor, manager, staff). Some screens (such as full revenue details) are limited to supervisors or managers.

---

## Navigation

### What do the bottom tabs mean?
| Tab | Purpose |
|-----|---------|
| **Home** | Dashboard, statistics, quick overview |
| **Sales** | Sales invoices by date |
| **Expenses** | Purchase / expense invoices |
| **Center button** | Opens **Parties** (customers, suppliers, etc.) |
| **More** | Profile, reports, sync, settings, help, logout |

### How do I go back?
Use the **back arrow** at the top left of most screens. On iOS-style screens this may appear as a close (×) on bottom sheets.

---

## Sales & purchase invoices

### How do I create a sales invoice?
Open the **Sales** tab, pick a date on the calendar, tap **+** (floating button), add line items, party, and save. You can submit as draft or with payment depending on your workflow.

### How do I record a purchase (expense)?
Use the **Expenses** tab the same way as Sales — select the date, add items and amounts, and save.

### What is “Submit invoice”?
**Submit** marks the invoice as finalized in the books. Until then it may remain a draft with different edit rules.

### How do I see invoice details?
Tap an invoice in the list. **Transaction details** shows line items, totals, discounts, and payment information. You can print, share PDF, duplicate, or make payment from there.

### Why are rate or amount showing as zero in transaction details?
Usually the line was saved without amount data or payments were not linked. After updating the app, reopen the invoice. If you just fixed a settlement, run **Make Payment** again only if amounts are still wrong. New invoices and settlements should show correct values.

### How do I duplicate an invoice?
Open **Transaction details** on a **paid** invoice and tap **Duplicate Order** to start a new invoice with similar lines.

---

## Payments & settlement

### How do I record a partial payment?
Open the invoice → **Transaction details** → **Make Payment** (when there is outstanding balance). Enter amount, payment method, and date, then **Process Settlement**.

### How does Multiple Payment work?
Turn **Multiple Payment** ON, tap the edit icon, and split the amount across methods (e.g. Cash, Card, QR). The total of all splits should match what you want to pay. **Process Settlement** records each method separately.

### Only one payment method was saved after multiple payment. Why?
This was a known issue in local mode when only the first split line was stored. Update to the latest app version and settle again if needed. You should see all methods under **Payment** in transaction details.

### What payment methods are available?
Methods come from your **Payment Methods** setup (e.g. Cash, Card, Transfer, QR). Use **Multiple Payment** when the customer pays using more than one method.

---

## Items & menu

### How do I add a new item?
From sales/purchase flows or **Quick add items**, use **Add item**. Fill name, rate, unit, purpose (Sales / Purchases), optional photo, and **Create item**.

### Why doesn’t my item photo show in the menu grid?
Photos are stored on the device when using local mode. Re-save the item with a photo after updating the app. Supported formats: JPEG, PNG, GIF, WebP (max 5 MB).

### How do I add a custom unit (e.g. Litre, Box)?
When selecting **Unit**, choose **Create new unit** at the bottom of the list and enter the name.

### Can I scan a barcode when adding an item?
On the add-item screen, use the **QR / barcode** icon in the header to scan and fill the barcode field (and name when lookup succeeds).

---

## Parties (customers & suppliers)

### What is a “party”?
A customer, supplier, or contact you sell to or buy from. Open **Parties** from the center bottom button.

### What is “Cash Customer”?
A default walk-in customer when no specific party is selected on an invoice.

---

## Stock & reconciliation

### How do I upload stock quantities?
Go to the stock / reconciliation flow (from inventory or reconciliation menu, depending on your build). Use **Enter stock quantities**, add items and counts, then **Save file**. You can clear all quantities from the app bar if you need to start over.

### Can I upload an Excel file for stock?
Some builds focus on **manual quantity entry** in the app. If Excel upload is not shown on your screen, use the quantity editor or ask your administrator about server-side import.

### What is opening / closing?
**Opening** records starting balances or register state for a business day. **Closing** summarizes sales, cash, and related totals for end-of-day reporting. Access these from **More** or dashboard shortcuts if enabled for your role.

---

## Employees

### How do I add or edit an employee?
**More** → employee management (or Employees list). Add or edit name, contact, role, and other fields. If you edit **your own** profile, the name on **More** and dashboard updates after save.

### Why didn’t my name update on the profile after I edited it?
Ensure you saved the correct employee record linked to your login email. Log out and back in only if the app still shows old data after a successful save.

---

## Dashboard & reports

### What does the Home dashboard show?
High-level sales, expenses, and shortcuts. Tap cards or links for more detail (e.g. **Revenue Details** for supervisors).

### What is Revenue Details?
A monthly view: daily sales trend chart, **Net profit** and **Outstanding**, and **Daily sales breakdown** (sales vs purchase per day). Use the calendar icon or month chip to change month.

### Where are profit & loss or analytics reports?
**More** → Reports section (Analytics, Profit & Loss, Statement, etc.) when enabled for your account.

---

## Sync & data

### What is “Send data to client” / sync?
From **More**, sync options upload or download data between the device and a connected server. Use only when your administrator has configured sync and told you when to run it.

### Will sync delete my local data?
Follow your administrator’s instructions. Typically upload sends local changes up; download merges server data down. Avoid syncing during active billing unless you know the process.

---

## Troubleshooting

### The app feels slow or stuck on loading
Check storage space, restart the app, and ensure you are on a recent version. For sync operations, wait for completion or retry on stable network.

### I see “No internet” on a list
In offline mode this can appear for features that expect a server. Use local flows (invoices, parties, items) or connect and sync if available.

### Floating + button is too high or hidden
On Sales and Expenses tabs, the add button sits above the bottom navigation. Pull to refresh or scroll; update the app if layout looks wrong on your device.

### Amounts on dashboard don’t match my expectations
Confirm the **selected date or month**, submitted vs draft invoices, and whether returns or discounts are included. Use **Revenue Details** or reports for drill-down.

### How do I log out?
**More** → **Logout** at the bottom of the list.

---

## Contact & support

### Where is FAQ in the app?
**More** → **Help & Support** → **FAQ**.

### How do I report a problem?
**More** → **Report a problem** (or contact your system administrator with steps, screenshots, and invoice or screen names).

---

*Last updated for BizTrack mobile (local/offline workflows). Wording may vary slightly by app version and enabled modules.*
