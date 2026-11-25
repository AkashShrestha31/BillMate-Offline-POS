-- Auto-generated from FinalProductionSetupView.get_all_books_table_schemas
PRAGMA foreign_keys = OFF;

-- Account
CREATE TABLE `Account` (`name` text not null, `rootType` text not null, `parentAccount` text, `accountType` text, `isGroup` boolean default '0', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `lft` integer not null, `rgt` integer not null, foreign key(`parentAccount`) references `Account`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- AccountingLedgerEntry
CREATE TABLE `AccountingLedgerEntry` (`name` text not null, `date` datetime, `party` text, `account` text not null, `debit` text, `credit` text, `referenceType` text, `referenceName` text, `reverted` boolean default '0', `reverts` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`party`) references `Party`(`name`) on delete RESTRICT on update CASCADE, foreign key(`account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, foreign key(`reverts`) references `AccountingLedgerEntry`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- Address
CREATE TABLE "Address" (`name` text NOT NULL, `addressLine1` text NOT NULL, `addressLine2` text, `city` text NOT NULL, `country` text NOT NULL, `state` text, `postalCode` text, `emailAddress` text, `phone` text, `fax` text, `addressDisplay` text, `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, PRIMARY KEY (`name`));

-- AppliedCouponCodes
CREATE TABLE `AppliedCouponCodes` (`name` text not null, `coupons` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`coupons`) references `CouponCode`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- Batch
CREATE TABLE "Batch" (`name` text NOT NULL, `expiryDate` date, `manufactureDate` date, `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, PRIMARY KEY (`name`));

-- CashMovement
CREATE TABLE "CashMovement" (
                        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                        "register_id" INTEGER NOT NULL,
                        "movement_type" TEXT NOT NULL,
                        "amount" REAL NOT NULL,
                        "reason" TEXT,
                        "reference_id" TEXT,
                        "created_by" TEXT,
                        "created" DATETIME DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY ("register_id") REFERENCES "CashRegister"("id") ON DELETE CASCADE
                    );

-- CashRegister
CREATE TABLE "CashRegister" (
                        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                        "name" TEXT NOT NULL,
                        "status" TEXT DEFAULT 'closed',
                        "opening_time" DATETIME,
                        "closing_time" DATETIME,
                        "opening_amount" REAL DEFAULT 0,
                        "closing_amount" REAL DEFAULT 0,
                        "expected_amount" REAL DEFAULT 0,
                        "difference" REAL DEFAULT 0,
                        "total_sales" REAL DEFAULT 0,
                        "total_cash_in" REAL DEFAULT 0,
                        "total_cash_out" REAL DEFAULT 0,
                        "opening_note" TEXT,
                        "closing_note" TEXT,
                        "opened_by" TEXT,
                        "closed_by" TEXT,
                        "created" DATETIME DEFAULT CURRENT_TIMESTAMP,
                        "modified" DATETIME DEFAULT CURRENT_TIMESTAMP
                    );

-- Category
CREATE TABLE Category (
                        id       INTEGER PRIMARY KEY AUTOINCREMENT,
                        name     TEXT NOT NULL UNIQUE,
                        created  TEXT DEFAULT (datetime('now')),
                        modified TEXT DEFAULT (datetime('now'))
                    );

-- Role (party role master: Customer, Supplier, Both, etc.)
CREATE TABLE "Role" (
                    "name" TEXT NOT NULL PRIMARY KEY,
                    "description" TEXT,
                    "sort_order" INTEGER NOT NULL DEFAULT 0,
                    "is_system" INTEGER NOT NULL DEFAULT 0,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL
                );

-- ClosingAmounts
CREATE TABLE `ClosingAmounts` (`name` text not null, `paymentMethod` text not null, `openingAmount` text, `closingAmount` text, `expectedAmount` text, `differenceAmount` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- ClosingCash
CREATE TABLE `ClosingCash` (`name` text not null, `denomination` text not null, `count` integer not null default '0', `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- CollectionRulesItems
CREATE TABLE `CollectionRulesItems` (`name` text not null, `tierName` text, `collectionFactor` float, `minimumTotalSpent` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- Color
CREATE TABLE `Color` (`name` text not null, `hexvalue` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- ContactBook
CREATE TABLE ContactBook (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        phone TEXT,
        email TEXT,
        address TEXT,
        category TEXT DEFAULT 'general',
        company TEXT,
        notes TEXT,
        is_favorite BOOLEAN DEFAULT 0,
        photo_url TEXT,
        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        modified_at DATETIME DEFAULT CURRENT_TIMESTAMP,
        created_by TEXT DEFAULT 'system',
        modified_by TEXT DEFAULT 'system'
      );

-- CouponCode
CREATE TABLE `CouponCode` (`name` text not null, `couponName` text not null, `isEnabled` boolean not null default '1', `pricingRule` text not null, `minAmount` text, `maxAmount` text, `validFrom` date not null, `validTo` date not null, `maximumUse` integer not null default '0', `used` integer not null default '0', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`pricingRule`) references `PricingRule`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- Currency
CREATE TABLE `Currency` (`name` text not null, `fraction` text, `fractionUnits` integer, `smallestValue` text, `symbol` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- CustomField
CREATE TABLE `CustomField` (`name` text not null, `label` text not null, `fieldname` text not null, `fieldtype` text not null default 'Data', `isRequired` boolean default '0', `default` text, `section` text default 'Default', `tab` text default 'Custom', `options` text, `target` text, `references` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- CustomForm
CREATE TABLE `CustomForm` (`name` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- DailyCashSummary
CREATE TABLE DailyCashSummary (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        date DATE NOT NULL UNIQUE,
                        opening_balance REAL DEFAULT 0.0,
                        sales_amount REAL DEFAULT 0.0,
                        qr_amount REAL DEFAULT 0.0,
                        cash_amount REAL DEFAULT 0.0,
                        discount REAL DEFAULT 0.0,
                        expenses REAL DEFAULT 0.0,
                        un_paid REAL DEFAULT 0.0,
                        un_paid_discount REAL DEFAULT 0.0,
                        credit_paid_cash REAL DEFAULT 0.0,
                        credit_qr REAL DEFAULT 0.0,
                        closing_balance REAL DEFAULT 0.0,
                        lost_money REAL DEFAULT 0.0,
                        extra_money REAL DEFAULT 0.0,
                        pay_qr_get_cash_exchange REAL DEFAULT 0.0,
                        pay_cash_get_qr_exchange REAL DEFAULT 0.0,
                        created_by TEXT NOT NULL,
                        created_at DATETIME NOT NULL,
                        modified_by TEXT NOT NULL,
                        modified_at DATETIME NOT NULL
                    );

-- DefaultCashDenominations
CREATE TABLE `DefaultCashDenominations` (`name` text not null, `denomination` text not null, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- ERPNextSyncQueue
CREATE TABLE `ERPNextSyncQueue` (`name` text not null, `referenceType` text not null, `documentName` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- Employee
CREATE TABLE "Employee" (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        employee_code TEXT NOT NULL UNIQUE,
                        first_name TEXT NOT NULL,
                        last_name TEXT NOT NULL,
                        full_name TEXT NOT NULL,
                        email TEXT UNIQUE,
                        phone TEXT,
                        address TEXT,
                        date_of_birth DATE,
                        hire_date DATE NOT NULL,
                        department TEXT NOT NULL,
                        position TEXT NOT NULL,
                        employment_type TEXT NOT NULL DEFAULT 'FULL_TIME' 
                            CHECK(employment_type IN ('FULL_TIME', 'PART_TIME', 'CONTRACT', 'INTERN')),
                        employment_status TEXT NOT NULL DEFAULT 'ACTIVE' 
                            CHECK(employment_status IN ('ACTIVE', 'INACTIVE', 'TERMINATED', 'RESIGNED')),
                        basic_salary REAL NOT NULL DEFAULT 0.0,
                        hourly_rate REAL DEFAULT 0.0,
                        working_hours_per_day REAL DEFAULT 8.0,
                        working_days_per_week INTEGER DEFAULT 6,
                        manager_id INTEGER,
                        party_id TEXT,
                        emergency_contact_name TEXT,
                        emergency_contact_phone TEXT,
                        bank_account_number TEXT,
                        bank_name TEXT,
                        national_id TEXT,
                        tax_id TEXT,
                        profile_image TEXT,
                        notes TEXT,
                        is_active BOOLEAN DEFAULT 1,
                        created_by TEXT NOT NULL,
                        modified_by TEXT NOT NULL,
                        created DATETIME NOT NULL,
                        modified DATETIME NOT NULL,
                        FOREIGN KEY(manager_id) REFERENCES Employee(id) ON DELETE SET NULL ON UPDATE CASCADE,
                        FOREIGN KEY(party_id) REFERENCES Party(name) ON DELETE SET NULL ON UPDATE CASCADE
                    );

-- EmployeeAttendance
CREATE TABLE "EmployeeAttendance" (
                    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                    "employee_id" INTEGER NOT NULL,
                    "attendance_date" DATE NOT NULL,
                    "check_in_time" DATETIME,
                    "check_out_time" DATETIME,
                    "break_start_time" DATETIME,
                    "break_end_time" DATETIME,
                    "total_hours_worked" REAL DEFAULT 0.0,
                    "total_break_hours" REAL DEFAULT 0.0,
                    "overtime_hours" REAL DEFAULT 0.0,
                    "attendance_status" TEXT NOT NULL DEFAULT 'PRESENT' CHECK (attendance_status IN ('PRESENT', 'ABSENT', 'LATE', 'HALF_DAY', 'SICK_LEAVE', 'VACATION', 'HOLIDAY')),
                    "late_arrival_minutes" INTEGER DEFAULT 0,
                    "early_departure_minutes" INTEGER DEFAULT 0,
                    "location" TEXT DEFAULT 'Hotel Premises',
                    "notes" TEXT,
                    "approved_by" TEXT,
                    "is_approved" BOOLEAN DEFAULT 0,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    FOREIGN KEY("employee_id") REFERENCES "Employee"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                    UNIQUE("employee_id", "attendance_date")
                );

-- EmployeeLeaveApplication
CREATE TABLE "EmployeeLeaveApplication" (
                    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                    "application_number" TEXT NOT NULL UNIQUE,
                    "employee_id" INTEGER NOT NULL,
                    "leave_type_id" INTEGER NOT NULL,
                    "from_date" DATE NOT NULL,
                    "to_date" DATE NOT NULL,
                    "total_days" INTEGER NOT NULL,
                    "reason" TEXT NOT NULL,
                    "emergency_contact" TEXT,
                    "handover_notes" TEXT,
                    "application_date" DATE NOT NULL,
                    "status" TEXT NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED')),
                    "approved_by" TEXT,
                    "approved_date" DATE,
                    "rejection_reason" TEXT,
                    "manager_comments" TEXT,
                    "hr_comments" TEXT,
                    "attachment" TEXT,
                    "is_emergency" BOOLEAN DEFAULT 0,
                    "is_half_day" BOOLEAN DEFAULT 0,
                    "half_day_session" TEXT CHECK (half_day_session IN ('MORNING', 'AFTERNOON', '')),
                    "substitute_employee_id" INTEGER,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    FOREIGN KEY("employee_id") REFERENCES "Employee"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                    FOREIGN KEY("leave_type_id") REFERENCES "LeaveType"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                    FOREIGN KEY("substitute_employee_id") REFERENCES "Employee"("id") ON DELETE SET NULL ON UPDATE CASCADE
                );

-- EmployeeLeaveBalance
CREATE TABLE "EmployeeLeaveBalance" (
                    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                    "employee_id" INTEGER NOT NULL,
                    "leave_type_id" INTEGER NOT NULL,
                    "year" INTEGER NOT NULL,
                    "total_allocated" INTEGER DEFAULT 0,
                    "total_used" INTEGER DEFAULT 0,
                    "total_pending" INTEGER DEFAULT 0,
                    "balance_remaining" INTEGER DEFAULT 0,
                    "carry_forward_from_previous" INTEGER DEFAULT 0,
                    "last_updated" DATETIME NOT NULL,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    FOREIGN KEY("employee_id") REFERENCES "Employee"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                    FOREIGN KEY("leave_type_id") REFERENCES "LeaveType"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                    UNIQUE("employee_id", "leave_type_id", "year")
                );

-- EmployeePayroll
CREATE TABLE "EmployeePayroll" (
                    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                    "employee_id" INTEGER NOT NULL,
                    "payroll_month" TEXT NOT NULL,
                    "pay_period_start" DATE NOT NULL,
                    "pay_period_end" DATE NOT NULL,
                    "total_working_days" INTEGER DEFAULT 0,
                    "days_present" INTEGER DEFAULT 0,
                    "days_absent" INTEGER DEFAULT 0,
                    "sick_days" INTEGER DEFAULT 0,
                    "vacation_days" INTEGER DEFAULT 0,
                    "total_hours_worked" REAL DEFAULT 0.0,
                    "regular_hours" REAL DEFAULT 0.0,
                    "overtime_hours" REAL DEFAULT 0.0,
                    "basic_salary" REAL DEFAULT 0.0,
                    "overtime_pay" REAL DEFAULT 0.0,
                    "allowances" REAL DEFAULT 0.0,
                    "bonus" REAL DEFAULT 0.0,
                    "gross_pay" REAL DEFAULT 0.0,
                    "tax_deduction" REAL DEFAULT 0.0,
                    "insurance_deduction" REAL DEFAULT 0.0,
                    "provident_fund" REAL DEFAULT 0.0,
                    "other_deductions" REAL DEFAULT 0.0,
                    "total_deductions" REAL DEFAULT 0.0,
                    "net_pay" REAL DEFAULT 0.0,
                    "payment_date" DATE,
                    "payment_method" TEXT DEFAULT 'BANK_TRANSFER',
                    "payment_status" TEXT DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING', 'PAID', 'CANCELLED')),
                    "bank_reference" TEXT,
                    "notes" TEXT,
                    "generated_by" TEXT NOT NULL,
                    "approved_by" TEXT,
                    "paid_by" TEXT,
                    "is_approved" BOOLEAN DEFAULT 0,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    FOREIGN KEY("employee_id") REFERENCES "Employee"("id") ON DELETE CASCADE ON UPDATE CASCADE,
                    UNIQUE("employee_id", "payroll_month")
                );

-- EmployeeSalary
CREATE TABLE "EmployeeSalary" (
                    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                    "employee_id" INTEGER NOT NULL,
                    "effective_date" DATE NOT NULL,
                    "basic_salary" REAL NOT NULL,
                    "hourly_rate" REAL DEFAULT 0.0,
                    "overtime_rate" REAL DEFAULT 0.0,
                    "allowances" REAL DEFAULT 0.0,
                    "house_allowance" REAL DEFAULT 0.0,
                    "transport_allowance" REAL DEFAULT 0.0,
                    "meal_allowance" REAL DEFAULT 0.0,
                    "bonus" REAL DEFAULT 0.0,
                    "commission" REAL DEFAULT 0.0,
                    "deductions" REAL DEFAULT 0.0,
                    "tax_deduction" REAL DEFAULT 0.0,
                    "insurance_deduction" REAL DEFAULT 0.0,
                    "provident_fund" REAL DEFAULT 0.0,
                    "other_deductions" REAL DEFAULT 0.0,
                    "gross_salary" REAL DEFAULT 0.0,
                    "net_salary" REAL DEFAULT 0.0,
                    "currency" TEXT DEFAULT 'NPR',
                    "salary_type" TEXT DEFAULT 'MONTHLY' CHECK (salary_type IN ('MONTHLY', 'HOURLY', 'DAILY')),
                    "is_active" BOOLEAN DEFAULT 1,
                    "notes" TEXT,
                    "approved_by" TEXT,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    FOREIGN KEY("employee_id") REFERENCES "Employee"("id") ON DELETE CASCADE ON UPDATE CASCADE
                );

-- Employee_backup
CREATE TABLE Employee_backup(
  id INT,
  employee_code TEXT,
  first_name TEXT,
  last_name TEXT,
  full_name TEXT,
  email TEXT,
  phone TEXT,
  address TEXT,
  date_of_birth NUM,
  hire_date NUM,
  department TEXT,
  position TEXT,
  employment_type TEXT,
  employment_status TEXT,
  basic_salary REAL,
  hourly_rate REAL,
  working_hours_per_day REAL,
  working_days_per_week INT,
  manager_id INT,
  emergency_contact_name TEXT,
  emergency_contact_phone TEXT,
  bank_account_number TEXT,
  bank_name TEXT,
  national_id TEXT,
  tax_id TEXT,
  profile_image TEXT,
  notes TEXT,
  is_active NUM,
  created_by TEXT,
  modified_by TEXT,
  created NUM,
  modified NUM
);

-- FetchFromERPNextQueue
CREATE TABLE `FetchFromERPNextQueue` (`name` text not null, `referenceType` text not null, `documentName` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- IntegrationErrorLog
CREATE TABLE `IntegrationErrorLog` (`name` text not null, `data` text, `error` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- Item
CREATE TABLE "Item" (`image` text, `name` text NOT NULL, `for` text NOT NULL DEFAULT 'Both', `itemType` text DEFAULT 'Product', `unit` text DEFAULT 'Unit', `rate` text, `description` text, `incomeAccount` text NOT NULL, `expenseAccount` text NOT NULL, `tax` text, `hsnCode` text, `barcode` text, `trackItem` boolean DEFAULT '0', `hasBatch` boolean DEFAULT '0', `hasSerialNumber` boolean DEFAULT '0', `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, category TEXT
                    REFERENCES Category(name), isFavorite integer DEFAULT 0, FOREIGN KEY (`unit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`incomeAccount`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`expenseAccount`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`tax`) REFERENCES `Tax` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- ItemEnquiry
CREATE TABLE `ItemEnquiry` (`name` text not null, `item` text not null, `customer` text, `contact` text, `description` text, `similarProduct` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- ItemGroup
CREATE TABLE `ItemGroup` (`name` text not null, `tax` text, `hsnCode` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `image` text, foreign key(`tax`) references `Tax`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- JournalEntry
CREATE TABLE `JournalEntry` (`name` text not null, `numberSeries` text not null default 'JV-', `entryType` text not null, `date` date not null, `referenceNumber` text, `referenceDate` date, `userRemark` text, `attachment` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `submitted` boolean not null, `cancelled` boolean not null, foreign key(`numberSeries`) references `NumberSeries`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- JournalEntryAccount
CREATE TABLE `JournalEntryAccount` (`name` text not null, `account` text not null, `debit` text, `credit` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- Lead
CREATE TABLE `Lead` (`name` text not null, `status` text not null default 'Open', `email` text, `mobile` text, `address` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`address`) references `Address`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- LeaveType
CREATE TABLE "LeaveType" (
                    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                    "leave_type_name" TEXT NOT NULL UNIQUE,
                    "description" TEXT,
                    "max_days_per_year" INTEGER DEFAULT 30,
                    "carry_forward_allowed" BOOLEAN DEFAULT 0,
                    "max_carry_forward_days" INTEGER DEFAULT 0,
                    "requires_approval" BOOLEAN DEFAULT 1,
                    "advance_notice_days" INTEGER DEFAULT 3,
                    "is_paid" BOOLEAN DEFAULT 1,
                    "gender_specific" TEXT DEFAULT 'ALL' CHECK (gender_specific IN ('ALL', 'MALE', 'FEMALE')),
                    "is_active" BOOLEAN DEFAULT 1,
                    "created_by" TEXT NOT NULL,
                    "modified_by" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL
                );

-- LiquorCategory
CREATE TABLE `LiquorCategory` (
                    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
                    `name` TEXT NOT NULL UNIQUE,
                    `description` TEXT,
                    `isActive` BOOLEAN DEFAULT 1,
                    `createdBy` TEXT NOT NULL,
                    `created` DATETIME NOT NULL,
                    `modified` DATETIME NOT NULL
                );

-- LiquorItem
CREATE TABLE `LiquorItem` (
                    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
                    `name` TEXT NOT NULL UNIQUE,
                    `category` TEXT NOT NULL,
                    `brand` TEXT,
                    `volume` TEXT,
                    `description` TEXT,
                    `isActive` BOOLEAN DEFAULT 1,
                    `createdBy` TEXT NOT NULL,
                    `created` DATETIME NOT NULL,
                    `modified` DATETIME NOT NULL,
                    FOREIGN KEY (`category`) REFERENCES `LiquorCategory`(`name`) ON DELETE RESTRICT ON UPDATE CASCADE
                );

-- LiquorPricing
CREATE TABLE `LiquorPricing` (
                    `id` INTEGER PRIMARY KEY AUTOINCREMENT,
                    `itemName` TEXT NOT NULL,
                    `purchasePrice` DECIMAL(10,2) DEFAULT 0,
                    `sellingPrice` DECIMAL(10,2) DEFAULT 0,
                    `marginAmount` DECIMAL(10,2) DEFAULT 0,
                    `marginPercentage` DECIMAL(5,2) DEFAULT 0,
                    `effectiveFrom` DATE NOT NULL,
                    `effectiveTo` DATE,
                    `location` TEXT DEFAULT 'Main Bar',
                    `notes` TEXT,
                    `isActive` BOOLEAN DEFAULT 1,
                    `createdBy` TEXT NOT NULL,
                    `created` DATETIME NOT NULL,
                    `modified` DATETIME NOT NULL,
                    FOREIGN KEY (`itemName`) REFERENCES `LiquorItem`(`name`) ON DELETE RESTRICT ON UPDATE CASCADE
                );

-- Location
CREATE TABLE `Location` (`name` text not null, `address` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`address`) references `Address`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- LoyaltyPointEntry
CREATE TABLE `LoyaltyPointEntry` (`name` text not null, `loyaltyProgram` text not null, `loyaltyProgramTier` text, `customer` text not null, `invoice` text not null, `loyaltyPoints` integer, `purchaseAmount` text not null, `expiryDate` date, `postingDate` date, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`customer`) references `Party`(`name`) on delete RESTRICT on update CASCADE, foreign key(`invoice`) references `SalesInvoice`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- LoyaltyProgram
CREATE TABLE `LoyaltyProgram` (`name` text not null, `fromDate` date not null, `toDate` date not null, `isEnabled` boolean not null default '1', `conversionFactor` float not null default '1', `expiryDuration` integer not null default '1', `expenseAccount` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`expenseAccount`) references `Account`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- NumberSeries
CREATE TABLE `NumberSeries` (`name` text not null, `start` integer not null default '1001', `padZeros` integer not null default '4', `referenceType` text not null default '-', `current` integer not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- OpeningAmounts
CREATE TABLE `OpeningAmounts` (`name` text not null, `paymentMethod` text not null, `amount` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- OpeningCash
CREATE TABLE `OpeningCash` (`name` text not null, `denomination` text not null, `count` integer not null default '0', `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- POSClosingShift
CREATE TABLE `POSClosingShift` (`name` text not null, `closingDate` datetime, `openingShift` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`openingShift`) references `POSOpeningShift`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- POSOpeningShift
CREATE TABLE "POSOpeningShift" (`name` text not null, `openingDate` datetime, `closingShift` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`closingShift`) references `POSClosingShift`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- POSProfile
CREATE TABLE "POSProfile" (`name` text, `posCustomer` text, `inventory` text NOT NULL, `posPrintTemplate` text, `posUI` text NOT NULL DEFAULT 'Classic', `isShiftOpen` boolean DEFAULT '0', `itemVisibility` text NOT NULL DEFAULT 'Inventory Items', `canChangeRate` boolean DEFAULT '0', `hideUnavailableItems` boolean DEFAULT '0', `canEditDiscount` boolean DEFAULT '0', `ignorePricingRule` boolean DEFAULT '0', `saveButtonColour` text DEFAULT '#9575cd', `cancelButtonColour` text DEFAULT '#e86674', `submitButtonColour` text DEFAULT '#00bcd4', `heldButtonColour` text DEFAULT '#ff9800', `returnButtonColour` text DEFAULT '#00bcd4', `payButtonColour` text DEFAULT '#66bb6a', `payAndPrintButtonColour` text DEFAULT '#ff9800', `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, FOREIGN KEY (`posCustomer`) REFERENCES `Party` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`inventory`) REFERENCES `Location` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`posPrintTemplate`) REFERENCES `PrintTemplate` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- Party
CREATE TABLE "Party" (`id` integer, `image` text, `name` text NOT NULL, `role` text NOT NULL DEFAULT 'Both', `email` text, `phone` text, `address` text, `defaultAccount` text, `currency` text, `fromLead` text, `loyaltyProgram` text, `loyaltyPoints` integer DEFAULT '0', `outstandingAmount` text, `status` integer DEFAULT 1, `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, `taxId` text, FOREIGN KEY (`address`) REFERENCES `Address` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`defaultAccount`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`currency`) REFERENCES `Currency` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`fromLead`) REFERENCES `Lead` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`loyaltyProgram`) REFERENCES `LoyaltyProgram` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- PatchRun
CREATE TABLE `PatchRun` (`name` text not null, `failed` boolean default '0', `version` text default '0.0.0', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- Payment
CREATE TABLE `Payment` (`name` text not null, `numberSeries` text not null default 'PAY-', `party` text not null, `date` date not null, `paymentType` text not null, `account` text not null, `paymentAccount` text not null, `paymentMethod` text not null default 'Cash', `clearanceDate` date, `referenceId` text, `referenceDate` date, `amount` text not null, `writeoff` text, `attachment` text, `referenceType` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `submitted` boolean not null, `cancelled` boolean not null, foreign key(`numberSeries`) references `NumberSeries`(`name`) on delete RESTRICT on update CASCADE, foreign key(`party`) references `Party`(`name`) on delete RESTRICT on update CASCADE, foreign key(`account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, foreign key(`paymentAccount`) references `Account`(`name`) on delete RESTRICT on update CASCADE, foreign key(`paymentMethod`) references `PaymentMethod`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- PaymentFor
CREATE TABLE `PaymentFor` (`name` text not null, `referenceType` text not null, `referenceName` text not null, `amount` text not null, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, primary key (`name`));

-- PaymentMethod
CREATE TABLE `PaymentMethod` (`name` text, `type` text not null, `account` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- PreviousStock
CREATE TABLE "PreviousStock" (
                    "name" TEXT NOT NULL,
                    "item" TEXT NOT NULL,
                    "location" TEXT NOT NULL,
                    "previousQuantity" REAL NOT NULL DEFAULT 0,
                    "reportingDate" DATE NOT NULL,
                    "uploadDate" DATETIME NOT NULL,
                    "uploadedBy" TEXT NOT NULL,
                    "batchNumber" TEXT,
                    "expiryDate" DATE,
                    "rate" REAL,
                    "value" REAL,
                    "notes" TEXT,
                    "isActive" BOOLEAN DEFAULT 1,
                    "createdBy" TEXT NOT NULL,
                    "modifiedBy" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    PRIMARY KEY("name"),
                    FOREIGN KEY("item") REFERENCES "Item"("name") ON DELETE RESTRICT ON UPDATE CASCADE,
                    FOREIGN KEY("location") REFERENCES "Location"("name") ON DELETE RESTRICT ON UPDATE CASCADE
                );

-- PriceList
CREATE TABLE `PriceList` (`name` text not null, `isEnabled` boolean default '1', `isSales` boolean default '1', `isPurchase` boolean default '0', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- PriceListItem
CREATE TABLE `PriceListItem` (`name` text not null, `item` text not null, `unit` text, `rate` text not null, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`item`) references `Item`(`name`) on delete RESTRICT on update CASCADE, foreign key(`unit`) references `UOM`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- PricingRule
CREATE TABLE "PricingRule" (`name` text NOT NULL, `numberSeries` text NOT NULL DEFAULT 'PRLE-', `isEnabled` boolean DEFAULT '1', `title` text NOT NULL, `discountType` text NOT NULL, `isCouponCodeBased` boolean DEFAULT '0', `priority` text NOT NULL, `priceDiscountType` text, `discountRate` text, `discountPercentage` float, `discountAmount` text, `freeItem` text, `freeItemQuantity` float, `freeItemUnit` text, `roundFreeItemQty` boolean DEFAULT '0', `roundingMethod` text NOT NULL DEFAULT 'round', `isRecursive` boolean DEFAULT '0', `recurseEvery` float, `minQuantity` float, `maxQuantity` float, `minAmount` text, `maxAmount` text, `validFrom` date, `validTo` date, `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, `isMultiple` boolean default '0', `freeItemRate` text, FOREIGN KEY (`numberSeries`) REFERENCES `NumberSeries` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`freeItem`) REFERENCES `Item` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`freeItemUnit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- PricingRuleDetail
CREATE TABLE `PricingRuleDetail` (`name` text not null, `referenceName` text, `referenceItem` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`referenceName`) references `PricingRule`(`name`) on delete RESTRICT on update CASCADE, foreign key(`referenceItem`) references `Item`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- PricingRuleItem
CREATE TABLE `PricingRuleItem` (`name` text not null, `item` text not null, `unit` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`item`) references `Item`(`name`) on delete RESTRICT on update CASCADE, foreign key(`unit`) references `UOM`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- PrintTemplate
CREATE TABLE `PrintTemplate` (`name` text not null, `type` text not null default 'SalesInvoice', `template` text not null, `height` float default '29.7', `width` float default '21', `isCustom` boolean default '1', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- PurchaseInvoice
CREATE TABLE "PurchaseInvoice" (`name` text NOT NULL, `numberSeries` text NOT NULL DEFAULT 'PINV-', `party` text NOT NULL, `account` text NOT NULL, `date` datetime NOT NULL, `priceList` text, `netTotal` text, `baseGrandTotal` text, `grandTotal` text, `setDiscountAmount` boolean DEFAULT '0', `discountAmount` text, `discountPercent` float, `entryCurrency` text DEFAULT 'Party', `currency` text, `exchangeRate` float DEFAULT '1', `discountAfterTax` boolean DEFAULT '0', `makeAutoPayment` boolean DEFAULT '0', `makeAutoStockTransfer` boolean DEFAULT '0', `outstandingAmount` text, `stockNotTransferred` float, `terms` text, `attachment` text, `isReturned` boolean DEFAULT '0', `backReference` text, `returnAgainst` text, `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, `submitted` boolean NOT NULL, `cancelled` boolean NOT NULL, FOREIGN KEY (`numberSeries`) REFERENCES `NumberSeries` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`party`) REFERENCES `Party` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`account`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`priceList`) REFERENCES `PriceList` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`currency`) REFERENCES `Currency` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`backReference`) REFERENCES `PurchaseReceipt` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`returnAgainst`) REFERENCES `PurchaseInvoice` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- PurchaseInvoiceItem
CREATE TABLE "PurchaseInvoiceItem" (`name` text NOT NULL, `item` text NOT NULL, `description` text, `rate` text NOT NULL, `transferUnit` text DEFAULT 'Unit', `transferQuantity` float NOT NULL DEFAULT '1', `unit` text DEFAULT 'Unit', `batch` text, `quantity` float NOT NULL DEFAULT '1', `unitConversionFactor` float NOT NULL DEFAULT '1', `account` text NOT NULL, `tax` text, `amount` text, `setItemDiscountAmount` boolean DEFAULT '0', `itemDiscountAmount` text, `itemDiscountPercent` float, `hsnCode` integer, `stockNotTransferred` float, `idx` integer NOT NULL, `parent` text NOT NULL, `parentSchemaName` text NOT NULL, `parentFieldname` text NOT NULL, FOREIGN KEY (`item`) REFERENCES `Item` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`transferUnit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`unit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`batch`) REFERENCES `Batch` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`account`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`tax`) REFERENCES `Tax` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- PurchaseReceipt
CREATE TABLE `PurchaseReceipt` (`name` text not null, `numberSeries` text not null default 'PREC-', `party` text not null, `date` datetime not null, `grandTotal` text, `terms` text, `attachment` text, `isReturned` boolean default '0', `backReference` text, `returnAgainst` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `submitted` boolean not null, `cancelled` boolean not null, foreign key(`numberSeries`) references `NumberSeries`(`name`) on delete RESTRICT on update CASCADE, foreign key(`party`) references `Party`(`name`) on delete RESTRICT on update CASCADE, foreign key(`backReference`) references `PurchaseInvoice`(`name`) on delete RESTRICT on update CASCADE, foreign key(`returnAgainst`) references `PurchaseReceipt`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- PurchaseReceiptItem
CREATE TABLE "PurchaseReceiptItem" (`name` text NOT NULL, `item` text NOT NULL, `location` text NOT NULL, `transferUnit` text DEFAULT 'Unit', `transferQuantity` float NOT NULL DEFAULT '1', `unit` text DEFAULT 'Unit', `batch` text, `serialNumber` text, `quantity` float NOT NULL DEFAULT '1', `unitConversionFactor` float NOT NULL DEFAULT '1', `rate` text NOT NULL, `amount` text, `description` text, `hsnCode` integer, `idx` integer NOT NULL, `parent` text NOT NULL, `parentSchemaName` text NOT NULL, `parentFieldname` text NOT NULL, FOREIGN KEY (`item`) REFERENCES `Item` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`location`) REFERENCES `Location` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`transferUnit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`unit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`batch`) REFERENCES `Batch` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- RegisterClosingDetail
CREATE TABLE "RegisterClosingDetail" (
                        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                        "register_id" INTEGER NOT NULL,
                        "denomination" REAL NOT NULL,
                        "quantity" INTEGER DEFAULT 0,
                        "amount" REAL DEFAULT 0,
                        "type" TEXT DEFAULT 'note',
                        "created" DATETIME DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY ("register_id") REFERENCES "CashRegister"("id") ON DELETE CASCADE
                    );

-- RegisterOpeningDetail
CREATE TABLE "RegisterOpeningDetail" (
                        "id" INTEGER PRIMARY KEY AUTOINCREMENT,
                        "register_id" INTEGER NOT NULL,
                        "denomination" REAL NOT NULL,
                        "quantity" INTEGER DEFAULT 0,
                        "amount" REAL DEFAULT 0,
                        "type" TEXT DEFAULT 'note',
                        "created" DATETIME DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY ("register_id") REFERENCES "CashRegister"("id") ON DELETE CASCADE
                    );

-- SalesInvoice
CREATE TABLE "SalesInvoice" (`name` text NOT NULL, `numberSeries` text NOT NULL DEFAULT 'SINV-', `party` text NOT NULL, `account` text NOT NULL, `date` datetime NOT NULL, `priceList` text, `netTotal` text, `baseGrandTotal` text, `grandTotal` text, `setDiscountAmount` boolean DEFAULT '0', `discountAmount` text, `discountPercent` float, `entryCurrency` text DEFAULT 'Party', `currency` text, `exchangeRate` float DEFAULT '1', `discountAfterTax` boolean DEFAULT '0', `makeAutoPayment` boolean DEFAULT '0', `makeAutoStockTransfer` boolean DEFAULT '0', `outstandingAmount` text, `stockNotTransferred` float, `terms` text, `attachment` text, `isReturned` boolean DEFAULT '0', `backReference` text, `returnAgainst` text, `quote` text, `loyaltyProgram` text, `redeemLoyaltyPoints` boolean DEFAULT '0', `loyaltyPoints` integer, `isPOS` boolean DEFAULT '0', `isPricingRuleApplied` boolean DEFAULT '0', `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, `submitted` boolean NOT NULL, `cancelled` boolean NOT NULL, FOREIGN KEY (`numberSeries`) REFERENCES `NumberSeries` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`party`) REFERENCES `Party` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`account`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`priceList`) REFERENCES `PriceList` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`currency`) REFERENCES `Currency` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`backReference`) REFERENCES `Shipment` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`returnAgainst`) REFERENCES `SalesInvoice` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`quote`) REFERENCES `SalesQuote` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`loyaltyProgram`) REFERENCES `LoyaltyProgram` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- SalesInvoiceItem
CREATE TABLE "SalesInvoiceItem" (`name` text NOT NULL, `item` text NOT NULL, `description` text, `rate` text NOT NULL, `transferUnit` text DEFAULT 'Unit', `transferQuantity` float NOT NULL DEFAULT '1', `unit` text DEFAULT 'Unit', `batch` text, `quantity` float NOT NULL DEFAULT '1', `unitConversionFactor` float NOT NULL DEFAULT '1', `account` text NOT NULL, `tax` text, `amount` text, `setItemDiscountAmount` boolean DEFAULT '0', `itemDiscountAmount` text, `itemDiscountPercent` float, `hsnCode` integer, `stockNotTransferred` float, `isFreeItem` boolean DEFAULT '0', `pricingRule` text, `idx` integer NOT NULL, `parent` text NOT NULL, `parentSchemaName` text NOT NULL, `parentFieldname` text NOT NULL, FOREIGN KEY (`item`) REFERENCES `Item` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`transferUnit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`unit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`batch`) REFERENCES `Batch` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`account`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`tax`) REFERENCES `Tax` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- SalesQuote
CREATE TABLE "SalesQuote" (`name` text NOT NULL, `numberSeries` text NOT NULL DEFAULT 'SQUOT-', `party` text NOT NULL, `date` datetime NOT NULL, `priceList` text, `netTotal` text, `baseGrandTotal` text, `grandTotal` text, `setDiscountAmount` boolean DEFAULT '0', `discountAmount` text, `discountPercent` float, `entryCurrency` text DEFAULT 'Party', `currency` text, `exchangeRate` float DEFAULT '1', `discountAfterTax` boolean DEFAULT '0', `makeAutoPayment` boolean DEFAULT '0', `outstandingAmount` text, `terms` text, `attachment` text, `referenceType` text NOT NULL DEFAULT 'Party', `createdBy` text NOT NULL, `modifiedBy` text NOT NULL, `created` datetime NOT NULL, `modified` datetime NOT NULL, `submitted` boolean NOT NULL, `cancelled` boolean NOT NULL, FOREIGN KEY (`numberSeries`) REFERENCES `NumberSeries` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`priceList`) REFERENCES `PriceList` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`currency`) REFERENCES `Currency` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- SalesQuoteItem
CREATE TABLE "SalesQuoteItem" (`name` text NOT NULL, `item` text NOT NULL, `description` text, `rate` text NOT NULL, `transferUnit` text DEFAULT 'Unit', `transferQuantity` float NOT NULL DEFAULT '1', `unit` text DEFAULT 'Unit', `batch` text, `quantity` float NOT NULL DEFAULT '1', `unitConversionFactor` float NOT NULL DEFAULT '1', `account` text NOT NULL, `tax` text, `amount` text, `setItemDiscountAmount` boolean DEFAULT '0', `itemDiscountAmount` text, `itemDiscountPercent` float, `hsnCode` integer, `stockNotTransferred` float, `idx` integer NOT NULL, `parent` text NOT NULL, `parentSchemaName` text NOT NULL, `parentFieldname` text NOT NULL, FOREIGN KEY (`item`) REFERENCES `Item` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`transferUnit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`unit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`batch`) REFERENCES `Batch` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`account`) REFERENCES `Account` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`tax`) REFERENCES `Tax` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- SerialNumber
CREATE TABLE `SerialNumber` (`name` text not null, `item` text not null, `description` text, `status` text default 'Inactive', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`item`) references `Item`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- Shipment
CREATE TABLE `Shipment` (`name` text not null, `numberSeries` text not null default 'SHPM-', `party` text not null, `date` datetime not null, `grandTotal` text, `terms` text, `attachment` text, `isReturned` boolean default '0', `backReference` text, `returnAgainst` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `submitted` boolean not null, `cancelled` boolean not null, foreign key(`numberSeries`) references `NumberSeries`(`name`) on delete RESTRICT on update CASCADE, foreign key(`party`) references `Party`(`name`) on delete RESTRICT on update CASCADE, foreign key(`backReference`) references `SalesInvoice`(`name`) on delete RESTRICT on update CASCADE, foreign key(`returnAgainst`) references `Shipment`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- ShipmentItem
CREATE TABLE "ShipmentItem" (`name` text NOT NULL, `item` text NOT NULL, `location` text NOT NULL, `transferUnit` text DEFAULT 'Unit', `transferQuantity` float NOT NULL DEFAULT '1', `unit` text DEFAULT 'Unit', `batch` text, `serialNumber` text, `quantity` float NOT NULL DEFAULT '1', `unitConversionFactor` float NOT NULL DEFAULT '1', `rate` text NOT NULL, `amount` text, `description` text, `hsnCode` integer, `idx` integer NOT NULL, `parent` text NOT NULL, `parentSchemaName` text NOT NULL, `parentFieldname` text NOT NULL, FOREIGN KEY (`item`) REFERENCES `Item` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`location`) REFERENCES `Location` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`transferUnit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`unit`) REFERENCES `UOM` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, FOREIGN KEY (`batch`) REFERENCES `Batch` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE, PRIMARY KEY (`name`));

-- SingleValue
CREATE TABLE `SingleValue` (`name` text not null, `parent` text not null, `fieldname` text not null, `value` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- StockAdjustment
CREATE TABLE "StockAdjustment" (
                    "name" TEXT NOT NULL,
                    "adjustmentDate" DATE NOT NULL,
                    "adjustmentType" TEXT NOT NULL,
                    "item" TEXT NOT NULL,
                    "location" TEXT NOT NULL,
                    "batchNumber" TEXT,
                    "previousQuantity" REAL NOT NULL DEFAULT 0,
                    "adjustedQuantity" REAL NOT NULL DEFAULT 0,
                    "variance" REAL NOT NULL DEFAULT 0,
                    "currentRate" REAL,
                    "adjustmentValue" REAL,
                    "reason" TEXT,
                    "notes" TEXT,
                    "adjustedBy" TEXT NOT NULL,
                    "approvedBy" TEXT,
                    "isApproved" BOOLEAN DEFAULT 0,
                    "createdBy" TEXT NOT NULL,
                    "modifiedBy" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    PRIMARY KEY("name"),
                    FOREIGN KEY("item") REFERENCES "Item"("name") ON DELETE RESTRICT ON UPDATE CASCADE,
                    FOREIGN KEY("location") REFERENCES "Location"("name") ON DELETE RESTRICT ON UPDATE CASCADE
                );

-- StockLedgerEntry
CREATE TABLE `StockLedgerEntry` (`name` text not null, `date` datetime, `location` text, `batch` text, `serialNumber` text, `item` text, `rate` text, `quantity` float, `referenceType` text, `referenceName` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, foreign key(`location`) references `Location`(`name`) on delete RESTRICT on update CASCADE, foreign key(`batch`) references `Batch`(`name`) on delete RESTRICT on update CASCADE, foreign key(`serialNumber`) references `SerialNumber`(`name`) on delete RESTRICT on update CASCADE, foreign key(`item`) references `Item`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- StockMovement
CREATE TABLE `StockMovement` (`name` text not null, `numberSeries` text not null default 'SMOV-', `movementType` text not null, `date` datetime not null, `amount` text, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, `submitted` boolean not null, `cancelled` boolean not null, foreign key(`numberSeries`) references `NumberSeries`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- StockMovementItem
CREATE TABLE `StockMovementItem` (`name` text not null, `item` text not null, `fromLocation` text, `toLocation` text, `transferUnit` text default 'Unit', `transferQuantity` float not null default '1', `unit` text default 'Unit', `batch` text, `serialNumber` text, `quantity` float not null default '1', `unitConversionFactor` float not null default '1', `rate` text not null, `amount` text, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`item`) references `Item`(`name`) on delete RESTRICT on update CASCADE, foreign key(`fromLocation`) references `Location`(`name`) on delete RESTRICT on update CASCADE, foreign key(`toLocation`) references `Location`(`name`) on delete RESTRICT on update CASCADE, foreign key(`transferUnit`) references `UOM`(`name`) on delete RESTRICT on update CASCADE, foreign key(`unit`) references `UOM`(`name`) on delete RESTRICT on update CASCADE, foreign key(`batch`) references `Batch`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- StockReconciliationReport
CREATE TABLE "StockReconciliationReport" (
                    "name" TEXT NOT NULL,
                    "reportDate" DATE NOT NULL,
                    "fromDate" DATE NOT NULL,
                    "toDate" DATE NOT NULL,
                    "item" TEXT NOT NULL,
                    "location" TEXT NOT NULL,
                    "previousStock" REAL DEFAULT 0,
                    "totalPurchases" REAL DEFAULT 0,
                    "totalSales" REAL DEFAULT 0,
                    "totalStockIn" REAL DEFAULT 0,
                    "totalStockOut" REAL DEFAULT 0,
                    "expectedStock" REAL DEFAULT 0,
                    "actualStock" REAL DEFAULT 0,
                    "variance" REAL DEFAULT 0,
                    "varianceValue" REAL DEFAULT 0,
                    "itemRate" REAL DEFAULT 0,
                    "status" TEXT DEFAULT 'Pending',
                    "notes" TEXT,
                    "createdBy" TEXT NOT NULL,
                    "modifiedBy" TEXT NOT NULL,
                    "created" DATETIME NOT NULL,
                    "modified" DATETIME NOT NULL,
                    PRIMARY KEY("name"),
                    FOREIGN KEY("item") REFERENCES "Item"("name") ON DELETE RESTRICT ON UPDATE CASCADE,
                    FOREIGN KEY("location") REFERENCES "Location"("name") ON DELETE RESTRICT ON UPDATE CASCADE
                );

-- Tax
CREATE TABLE `Tax` (`name` text not null, `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- TaxDetail
CREATE TABLE `TaxDetail` (`name` text not null, `account` text not null, `payment_account` text, `rate` float not null, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, foreign key(`payment_account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- TaxSummary
CREATE TABLE `TaxSummary` (`name` text not null, `account` text not null, `from_account` text, `rate` float not null, `amount` text not null, `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, foreign key(`from_account`) references `Account`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

-- UOM
CREATE TABLE `UOM` (`name` text not null, `isWhole` boolean default '0', `createdBy` text not null, `modifiedBy` text not null, `created` datetime not null, `modified` datetime not null, primary key (`name`));

-- UOMConversionItem
CREATE TABLE `UOMConversionItem` (`name` text not null, `uom` text not null, `conversionFactor` float not null default '1', `idx` integer not null, `parent` text not null, `parentSchemaName` text not null, `parentFieldname` text not null, foreign key(`uom`) references `UOM`(`name`) on delete RESTRICT on update CASCADE, primary key (`name`));

PRAGMA foreign_keys = ON;
