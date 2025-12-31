flowchart TD

%% =========================
%% DATA SOURCE
%% =========================
A[PostgreSQL<br/>public schema<br/><i>raw source tables</i>] --> B

%% =========================
%% STAGING LAYER
%% =========================
subgraph B[STAGING LAYER<br/>default schema]
    direction LR
    B1[stg_customer.sql]
    B2[stg_orders.sql]
    B3[stg_orderitem.sql]
    B4[stg_events.sql]
    B5[stg_product.sql]
end
B --> C

%% =========================
%% INTERMEDIATE LAYER
%% =========================
subgraph C[INTERMEDIATE LAYER<br/>Business Logic]
    direction LR

    %% DIMENSIONS
    subgraph C1[Dimensions]
        C1a[dim_customer]
        C1b[dim_product]
    end

    %% FACTS
    subgraph C2[Facts]
        C2a[fct_orders]
        C2b[fct_orderitem]
        C2c[fct_events]
    end

    %% SESSIONS
    subgraph C3[Sessions]
        C3a[int_session]
        C3b[int_session_bounds]
        C3c[int_last_session_per_customer]
        C3d[int_cart_value]
        C3e[int_check_order]
    end

    %% FULFILLMENT
    subgraph C4[Fulfillment]
        C4a[int_order_fulfillment]
    end
end
C --> D

%% =========================
%% MARTS LAYER
%% =========================
subgraph D[MARTS LAYER<br/>Analytics Models]
    direction LR
    D1[mart_sales]
    D2[mart_cart_value]
    D3[order_fulfillment]
end
D --> E

%% =========================
%% PROJECT METADATA
%% =========================
subgraph E[PROJECT METADATA & DOCUMENTATION]
    direction LR
    E1[schema.yml<br/><i>tests & contracts</i>]
    E2[sources.yml<br/><i>source configs</i>]
    E3[docs/overview.md<br/>docs/docs.md]
end