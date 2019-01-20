create table interaction
(
  id              serial                                                  not null
    constraint interaction_pkey
    primary key,
  parent_id       integer
    constraint fk_parent
    references interaction
    deferrable,
  name            varchar(100),
  from_service    varchar(100)                                            not null,
  to_service      varchar(100)                                            not null,
  action          varchar(100)                                            not null,
  inner_action    boolean default false                                   not null,
  message_id      varchar(100),
  next_processing timestamp,
  completed       boolean default false                                   not null,
  failed          boolean default false                                   not null,
  cancelled       boolean default false                                   not null,
  lock            timestamp default to_timestamp((0) :: double precision) not null,
  options         jsonb,
  created         timestamp                                               not null,
  modified        timestamp                                               not null
);

create index interaction_completed_idx
  on interaction (completed);

create index interaction_failed_idx
  on interaction (failed);

create index interaction_from_service_idx
  on interaction (from_service);

create unique index interaction_id_idx
  on interaction (id);

create index interaction_lock_idx
  on interaction (lock);

create index interaction_message_id_idx
  on interaction (message_id);

create index interaction_next_processing_idx
  on interaction (next_processing);

create index interaction_parent_id_name_idx
  on interaction (parent_id, name);

create index interaction_to_service_idx
  on interaction (to_service);

