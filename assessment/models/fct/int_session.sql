with ordered_events as (
    select
        customer_id,
        event_id,
        event_type,
        created_at,
        product,

        -- 1. Look at the previous event timestamp for this customer
        lag(created_at) over (
            partition by customer_id
            order by created_at
        ) as previous_event_time,

        -- 2. Compute the time difference in minutes
        extract(
            epoch from (
                created_at - lag(created_at) over (
                    partition by customer_id
                    order by created_at
                )
            )
        ) / 60 as min_since_prev_event,

        -- 3. Decide if this is a session break (gap > 30 minutes)
        case
            when lag(created_at) over (
                    partition by customer_id
                    order by created_at
                 ) is null then 0
            when extract(
                    epoch from (
                        created_at - lag(created_at) over (
                            partition by customer_id
                            order by created_at
                        )
                    )
                 ) / 60 > 30
            then 1
            else 0
        end as session_break
    from {{ ref('fct_events') }}
),

sessionized as (
    select
        *,
        -- 4. Create session_id by cumulatively summing session_break
        sum(session_break) over (
            partition by customer_id
            order by created_at
            rows between unbounded preceding and current row
        ) as session_id
    from ordered_events
)

select *
from sessionized
