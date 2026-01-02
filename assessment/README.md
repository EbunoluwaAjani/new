### Data Pipeline Architecture

```mermaid
graph TD
    %% 1. DATA SOURCE
    A[PostgreSQL DB: raw source data] --> B(STAGING LAYER);

    %% 2. STAGING LAYER
    subgraph B [STAGING LAYER: Light cleaning, renaming]
        direction LR
        B1[stg_customer.sql]
        B2[stg_orders.sql]
        B3[stg_orderitem.sql]
        B4[stg_events.sql]
        B5[stg_product.sql]
    end

    B --> C(INTERMEDIATE LAYER);

    %% 3. INTERMEDIATE LAYER
    subgraph C [INTERMEDIATE LAYER: Business Logic, Dimensional Modeling]
        direction LR
        C1[DIMENSIONS]
        C2[FACTS]
        C3[SESSIONS / FULFILLMENT]
    end

    C --> D(MARTS LAYER);

    %% 4. MARTS LAYER
    subgraph D [MARTS LAYER: Business-ready, Analytics-focused]
        direction LR
        D1[mart_sales]
        D2[mart_cart_value]
        D3[order_fulfillment]
    end

    D --> E[PROJECT METADATA & DOCS];

    