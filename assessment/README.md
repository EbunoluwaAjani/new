### Architecture Diagram

```mermaid
graph TD
    %% 1. DATA SOURCE
    subgraph A[DATA SOURCE]
        A1[PostgreSQL DB: public.* (raw source data)]
    end
    A --> B;

    %% 2. STAGING LAYER
    subgraph B[STAGING LAYER: Schema: default]
        B_Desc(Purpose: Light cleaning, renaming, and standardization)
        direction LR
        B1[stg_customer.sql] --- B2[stg_orders.sql] --- B3[stg_orderitem.sql]
        B4[stg_events.sql] --- B5[stg_product.sql] --- B6[...]
    end
    B --> C;

    %% 3. INTERMEDIATE LAYER
    subgraph C[INTERMEDIATE LAYER: Business logic, dimensional models, facts, sessions, and fulfillment]
        direction TD

        subgraph C_MODELS[Models]
            direction LR
            C1[DIMENSIONS: dim_customer / dim_product]
            C2[FACTS: fct_orders / fct_orderitem / fct_events]
            C3[SESSIONS: int_session / int_session_bounds / int_last_session_per_customer / int_cart_value / int_check_order]
        end

        subgraph C_FULFILLMENT[FULFILLMENT]
            C4[int_order_fulfillment]
        end
        C_MODELS --> C_FULFILLMENT;
    end
    C --> D;

    %% 4. MARTS LAYER
    subgraph D[MARTS LAYER: Business-ready, analytics-focused models]
        direction LR
        D1[mart_sales] --- D2[mart_cart_value] --- D3[order_fulfillment]
    end
    D --> E;

    %% 5. PROJECT METADATA
    subgraph E[PROJECT METADATA & DOCUMENTATION]
        direction LR
        E1[schema.yml (tests + contracts)] --- E2[sources.yml (source configs)] --- E3[overview.md / docs.md]
    end