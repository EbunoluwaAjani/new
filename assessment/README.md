### Architecture Diagram

```mermaid
graph TD
    %% 1. DATA SOURCE
    subgraph A[DATA SOURCE]
        A1["PostgreSQL DB\n(Raw Source Data)"]
    end
    A --> B;

    %% 2. STAGING LAYER
    subgraph B[STAGING LAYER]
        B_D(Cleaning and Standardization)
        direction LR
        B1[stg_customer] --- B2[stg_orders] --- B3[stg_orderitem]
        B4[stg_events] --- B5[stg_product] --- B6[Other Sources]
    end
    B --> C;

    %% 3. INTERMEDIATE LAYER
    subgraph C[INTERMEDIATE LAYER]
        C_D(Dimensional Models and Logic)
        direction TD

        subgraph C_MODELS[Models]
            direction LR
            C1[DIMENSIONS: dim_customer]
            C2[FACTS: fct_orders]
            C3[SESSIONS: int_session]
        end
        C_MODELS --> C_FULFILLMENT; %% Connection between nested subgraphs

        subgraph C_FULFILLMENT[FULFILLMENT]
            C4[int_order_fulfillment]
        end
    end
    C --> D;

    %% 4. MARTS LAYER
    subgraph D[MARTS LAYER]
        direction LR
        D1[mart_sales] --- D2[mart_cart_value] --- D3[order_fulfillment]
    end
    D --> E;

    %% 5. PROJECT METADATA
    subgraph E[METADATA & DOCS]
        direction LR
        E1[schema.yml] --- E2[sources.yml] --- E3[documentation]
    end
    