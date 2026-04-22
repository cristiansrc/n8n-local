CREATE TABLE IF NOT EXISTS ai_plan_tasks_control
(
    task_plan_id character varying(255) COLLATE pg_catalog."default" NOT NULL,
    last_error_hash text COLLATE pg_catalog."default",
    all_errors_history text[] COLLATE pg_catalog."default",
    business_context text COLLATE pg_catalog."default",
    research_context text COLLATE pg_catalog."default",
    attempt_count integer DEFAULT 1,
    status character varying(50) COLLATE pg_catalog."default" DEFAULT 'IN_PROGRESS'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ai_plan_tasks_control_pkey PRIMARY KEY (task_plan_id)
)


CREATE TABLE IF NOT EXISTS work_plan_execution
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    id_task_plan character varying(256) COLLATE pg_catalog."default" NOT NULL,
    output_data jsonb NOT NULL,
    architecture character varying(256) COLLATE pg_catalog."default" NOT NULL,
    stack_details jsonb,
    validation_notes text COLLATE pg_catalog."default",
    swagger_definition text COLLATE pg_catalog."default",
    state character varying(256) COLLATE pg_catalog."default",
    CONSTRAINT work_plan_execution_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS work_plan_execution_task
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    task_id integer NOT NULL,
    work_plan_execution_id bigint NOT NULL,
    label character varying(256) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default" NOT NULL,
    technical_context text COLLATE pg_catalog."default" NOT NULL,
    can_parallize boolean DEFAULT false,
    output_data character varying(256) COLLATE pg_catalog."default" NOT NULL,
    depends_on integer[],
    task_role character varying(256) COLLATE pg_catalog."default",
    CONSTRAINT work_plan_execution_task_pkey PRIMARY KEY (id),
    CONSTRAINT work_plan_execution_task_work_plan_execution_id_fkey FOREIGN KEY (work_plan_execution_id)
        REFERENCES public.work_plan_execution (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
