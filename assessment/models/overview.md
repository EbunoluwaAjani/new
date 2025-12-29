{% docs __overview__ %}

# Webshop

This solution transforms raw webshop data into clean, reliable, analytics-ready models that support **order reporting**, **customer behavior analysis**, and **event tracking**, in line with the assessment requirements.

---

## Purpose

The goal of this solution is to support the business in answering key analytical questions related to **reporting**, **order fulfilment**, and **behavioral event tracking**.

The following assessment questions are addressed:

- **Order Fulfilment Performance**
  - What is the average time between *placed* and *shipped* orders, aggregated weekly?

- **Customer Behavior & Session Analysis**
  - What is the cart value of items added during a customer’s **last session**, for customers who placed an order in that same session?

- **Pricing & Discounts**
  - What is the total amount of discount granted each week?

---

## High-Level Data Flow

### 1. Raw Layer (`raw`)
Data is ingested from the webshop source system into the `public` schema. The raw tables include:

- **customer** — customer contact and profile information
- **orders** — order-level transactional data
- **order_item** — product-level details per order
- **event** — user behavior and session activity
- **product** — product catalog and discount attributes

---

### 2. Staging Layer
Raw tables are standardized into staging models (`src_*`) in the `default` schema.
Key transformations include:

- Renaming columns to follow consistent conventions

These models provide a clean foundation for downstream analytics.

---

### 3. Analytics Models

#### Dimensions
- **`dim_customer`**
  Curated customer dimension with validated email addresses, unique identifiers, and lifecycle timestamps.
  Includes tests for uniqueness, nullability, and email format.

- **`dim_product`**
  Product dimension containing product identifiers and descriptive attributes used for sales and discount analysis.

#### Fact Tables
- **`fct_orders`**
  Order-level facts including order status timestamps, customer relationships, and monetary values.
  Referential integrity is enforced against the customer dimension.

- **`fct_events`**
  Event-level facts capturing user actions, sessions, and event types.
  Includes accepted-values tests for event types.

---

## Business Logic Highlights

Key rules applied across the project include:

- Enforcing unique customer and product identifiers
- Validating customer email formats using regex
- Ensuring critical timestamps (`created_at`, `modified_at`) are always present
- Maintaining referential integrity between fact and dimension models
- Applying freshness checks on orders and events data
- Standardizing pricing and discount calculations

These rules ensure consistent and trustworthy analytical outputs.

---

## Final Outputs

The final models produced for reporting are:

- **`order_fulfillment`** — weekly analysis of placed-to-shipped order duration
- **`mart_sales`** — sales and discount aggregation for reporting
- **`mart_cart_values`** — last-session cart value for customers who placed an order

---

## Input Schema

The diagram below shows the structure of the source data used in this project:

![input schema](assets/schema.png)

---

## Navigating the Documentation

- **Sources** — raw input tables
- **Staging Models** — cleaned and standardized source data
- **Dimensions** — descriptive entities
- **Facts** — transactional and event-level data

Each section includes documented models with relevant data quality tests applied.

{% enddocs %}
