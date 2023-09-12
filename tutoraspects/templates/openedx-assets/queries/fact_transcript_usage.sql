with transcripts as (
select *
from {{ DBT_PROFILE_TARGET_DATABASE }}.fact_transcript_usage
where
    {% raw %}
    {% if filter_values('video_name') != [] %}
    video_name in {{ filter_values('video_name', remove_filter=True) | where_in }}
    {% else %}
    0=1
    {% endif %}
    {% endraw %}
    {% include 'openedx-assets/queries/common_filters.sql' %}
)

select
    emission_time,
    org,
    course_key,
    course_name,
    course_run,
    video_name,
    actor_id
from transcripts
