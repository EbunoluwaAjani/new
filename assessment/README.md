### Architecture Diagram

```mermaid
graph TD

    %% ============================
    %% 1. DATA SOURCES
    %% ============================
    subgraph A[DATA SOURCES]
        A1["PostgreSQL / APIs / Files"]
    end
    A --> B

    %% ============================
    %% 2. STAGING LAYER
    %% ============================
    subgraph B[STAGING LAYER (stg_*)]
        direction LR
        B1[stg_customers]
        B2[stg_orders]
        B3[stg_order_items]
        B4[stg_products]
        B5[stg_events]
    end
    B --> C

    %% ============================
    %% 3. INTERMEDIATE LAYER
    %% ============================
    subgraph C[INTERMEDIATE LAYER (int_*)]
        direction TB

        subgraph C_DIM[Dimensions]
            C1[dim_customers]
            C2[dim_products]
        end

        subgraph C_FACT[Facts]
            C3[fct_orders]
            C4[fct_sessions]
        end

        subgraph C_LOGIC[Business Logic]
            C5[int_order_fulfillment]
            C6[int_customer_lifecycle]
        end
    end
    C --> D

    %% ============================
    %% 4. MARTS LAYER
    %% ============================
    subgraph D[MARTS LAYER (mart_*)]
        direction LR
        D1[mart_sales]
        D2[mart_customer_value]
        D3[mart_fulfillment]
    end
    D --> E

    %% ============================
    %% 5. METADATA & DOCUMENTATION
    %% ============================
    subgraph E[METADATA & DOCS]
        direction LR
        E1[schema.yml]
        E2[sources.yml]
        E3[dbt docs]
    end
