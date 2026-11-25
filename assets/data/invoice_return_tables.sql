-- Invoice return tables (not in base books_schema.sql; used for local returns).

CREATE TABLE "SalesReturn" (
  `name` text NOT NULL,
  `party` text NOT NULL,
  `date` datetime NOT NULL,
  `returnAgainst` text NOT NULL,
  `grandTotal` text,
  `reason` text,
  `status` text DEFAULT 'Returned',
  `refundStatus` text,
  `refundMethod` text,
  `refundPaymentMethod` text,
  `createdBy` text NOT NULL,
  `modifiedBy` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `submitted` boolean NOT NULL DEFAULT '1',
  `cancelled` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
);

CREATE TABLE "SalesReturnItem" (
  `name` text NOT NULL,
  `item` text NOT NULL,
  `originalItemName` text NOT NULL,
  `quantity` float NOT NULL DEFAULT '0',
  `rate` text NOT NULL,
  `amount` text,
  `unit` text DEFAULT 'Unit',
  `idx` integer NOT NULL DEFAULT '1',
  `parent` text NOT NULL,
  `parentSchemaName` text NOT NULL DEFAULT 'SalesReturn',
  `parentFieldname` text NOT NULL DEFAULT 'items',
  PRIMARY KEY (`name`)
);

CREATE TABLE "PurchaseReturn" (
  `name` text NOT NULL,
  `party` text NOT NULL,
  `date` datetime NOT NULL,
  `returnAgainst` text NOT NULL,
  `grandTotal` text,
  `reason` text,
  `status` text DEFAULT 'Returned',
  `refundStatus` text,
  `refundMethod` text,
  `refundPaymentMethod` text,
  `createdBy` text NOT NULL,
  `modifiedBy` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `submitted` boolean NOT NULL DEFAULT '1',
  `cancelled` boolean NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
);

CREATE TABLE "PurchaseReturnItem" (
  `name` text NOT NULL,
  `item` text NOT NULL,
  `originalItemName` text NOT NULL,
  `quantity` float NOT NULL DEFAULT '0',
  `rate` text NOT NULL,
  `amount` text,
  `unit` text DEFAULT 'Unit',
  `idx` integer NOT NULL DEFAULT '1',
  `parent` text NOT NULL,
  `parentSchemaName` text NOT NULL DEFAULT 'PurchaseReturn',
  `parentFieldname` text NOT NULL DEFAULT 'items',
  PRIMARY KEY (`name`)
);

CREATE INDEX IF NOT EXISTS "idx_sales_return_against" ON "SalesReturn" (`returnAgainst`);
CREATE INDEX IF NOT EXISTS "idx_sales_return_item_parent" ON "SalesReturnItem" (`parent`);
CREATE INDEX IF NOT EXISTS "idx_purchase_return_against" ON "PurchaseReturn" (`returnAgainst`);
CREATE INDEX IF NOT EXISTS "idx_purchase_return_item_parent" ON "PurchaseReturnItem" (`parent`);
