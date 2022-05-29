{% if sql-vendor == "postgresql" %}
CREATE DATABASE rtm
  WITH
    TEMPLATE = template0
    ENCODING = 'UTF8'
    OWNER = {{ db-user }}
    CONNECTION LIMIT = -1
    IS_TEMPLATE = TRUE
    ;

DROP DATABASE IF EXISTS {{ db-name }} CASCADE;
CREATE DATABASE {{ db-name }}
  WITH
    TEMPLATE = rtm;

DROP SCHEMA IF EXISTS rtm CASCADE;
CREATE SCHEMA IF NOT EXISTS rtm AUTHORIZATION {{ db-user }}

DROP SCHEMA IF EXISTS {{ db-schema }} CASCADE;
CREATE SCHEMA {{ db-schema }} TEMPLATE rtm;

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

SELECT pg_catalog.set_config('search_path', '', false);

SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
SET default_tablespace = '';

{% endif %}
