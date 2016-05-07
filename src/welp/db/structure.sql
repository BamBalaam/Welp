--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cafes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cafes (
    place_id integer NOT NULL,
    smoking boolean,
    snack boolean
);


--
-- Name: cafes_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cafes_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cafes_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cafes_place_id_seq OWNED BY cafes.place_id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE comments (
    place_id integer NOT NULL,
    user_id integer NOT NULL,
    stars integer NOT NULL,
    text_comment text NOT NULL,
    creation_date timestamp without time zone NOT NULL
);


--
-- Name: comments_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_place_id_seq OWNED BY comments.place_id;


--
-- Name: comments_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_user_id_seq OWNED BY comments.user_id;


--
-- Name: hotels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hotels (
    place_id integer NOT NULL,
    num_stars integer,
    num_rooms integer,
    price_range_double_room character varying(200)
);


--
-- Name: hotels_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hotels_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotels_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hotels_place_id_seq OWNED BY hotels.place_id;


--
-- Name: places; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE places (
    place_id integer NOT NULL,
    creator_id integer NOT NULL,
    creation_date timestamp without time zone,
    name character varying(100) NOT NULL,
    street character varying(64) NOT NULL,
    num character varying(10) NOT NULL,
    zip text NOT NULL,
    city character varying(100) NOT NULL,
    longitude real,
    latitude real,
    phone character varying(100),
    website character varying(100)
);


--
-- Name: places_creator_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE places_creator_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: places_creator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE places_creator_id_seq OWNED BY places.creator_id;


--
-- Name: places_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE places_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: places_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE places_place_id_seq OWNED BY places.place_id;


--
-- Name: restaurants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE restaurants (
    place_id integer NOT NULL,
    price_range character varying(200),
    banquet integer,
    take_out boolean,
    delivery boolean,
    closed bit(14)
);


--
-- Name: restaurants_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE restaurants_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurants_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE restaurants_place_id_seq OWNED BY restaurants.place_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tags (
    place_id integer NOT NULL,
    user_id integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- Name: tags_place_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_place_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_place_id_seq OWNED BY tags.place_id;


--
-- Name: tags_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_user_id_seq OWNED BY tags.user_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    user_id integer NOT NULL,
    username character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    passwd character varying(64) NOT NULL,
    date_sign_up character varying(100) NOT NULL,
    is_admin boolean DEFAULT false
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;


--
-- Name: place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cafes ALTER COLUMN place_id SET DEFAULT nextval('cafes_place_id_seq'::regclass);


--
-- Name: place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN place_id SET DEFAULT nextval('comments_place_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN user_id SET DEFAULT nextval('comments_user_id_seq'::regclass);


--
-- Name: place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hotels ALTER COLUMN place_id SET DEFAULT nextval('hotels_place_id_seq'::regclass);


--
-- Name: place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY places ALTER COLUMN place_id SET DEFAULT nextval('places_place_id_seq'::regclass);


--
-- Name: creator_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY places ALTER COLUMN creator_id SET DEFAULT nextval('places_creator_id_seq'::regclass);


--
-- Name: place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurants ALTER COLUMN place_id SET DEFAULT nextval('restaurants_place_id_seq'::regclass);


--
-- Name: place_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN place_id SET DEFAULT nextval('tags_place_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN user_id SET DEFAULT nextval('tags_user_id_seq'::regclass);


--
-- Name: user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (place_id, user_id, creation_date);


--
-- Name: places_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY places
    ADD CONSTRAINT places_pkey PRIMARY KEY (place_id);


--
-- Name: tags_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (place_id, user_id);


--
-- Name: users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: cafes_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cafes
    ADD CONSTRAINT cafes_place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);


--
-- Name: comments_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);


--
-- Name: comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- Name: hotels_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hotels
    ADD CONSTRAINT hotels_place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);


--
-- Name: places_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY places
    ADD CONSTRAINT places_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES users(user_id);


--
-- Name: restaurants_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurants
    ADD CONSTRAINT restaurants_place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);


--
-- Name: tags_place_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_place_id_fkey FOREIGN KEY (place_id) REFERENCES places(place_id);


--
-- Name: tags_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(user_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160507141941');

