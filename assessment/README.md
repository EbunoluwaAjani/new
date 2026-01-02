### Architecture Diagram

┌──────────────────────────────┐
│ DATA SOURCE │
│ PostgreSQL public.* │
│ (raw source tables) │
└─────────────┬────────────────┘
│
▼
┌──────────────────────────────┐
│ STAGING LAYER │
│ Schema: default │
│ Light cleaning & renaming │
│ │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ │ stg_customer │ │ stg_orders │ │ stg_orderitem│
│ │ stg_events │ │ stg_product │ │ ... │
│ └──────────────┘ └──────────────┘ └──────────────┘
└─────────────┬────────────────┘
│
▼
┌──────────────────────────────┐
│ INTERMEDIATE LAYER │
│ Business logic, facts, dims, │
│ sessions, fulfillment │
│ │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ │ DIMENSIONS │ │ FACTS │ │ SESSIONS │
│ │ dim_customer │ │ fct_orders │ │ int_session │
│ │ dim_product │ │ fct_orderitem│ │ int_session_bounds│
│ │ │ │ fct_events │ │ int_last_session_per_customer│
│ │ │ │ │ │ int_cart_value │
│ │ │ │ │ │ int_check_order │
│ └──────────────┘ └──────────────┘ └──────────────┘
│ │
│ ┌───────────────────┐ │
│ │ FULFILLMENT LOGIC │ │
│ │ int_order_fulfill │ │
│ └───────────────────┘ │
└─────────────┬────────────────┘
│
▼
┌──────────────────────────────┐
│ MARTS LAYER │
│ Business-ready models │
│ │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ │ mart_sales │ │ mart_cart_value│ │ order_fulfill│
│ └──────────────┘ └──────────────┘ └──────────────┘
└─────────────┬────────────────┘
│
▼
┌──────────────────────────────┐
│ PROJECT METADATA & DOCS │
│ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
│ │ schema.yml │ │ sources.yml │ │ overview.md │
│ │ (tests+contracts) │ (source configs) │ docs.md │
│ └──────────────┘ └──────────────┘ └──────────────┘
└──────────────────────────────┘

###