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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: Comment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "Comment" (
    pid integer NOT NULL,
    uid integer NOT NULL,
    stars integer NOT NULL,
    "Text" text NOT NULL,
    "Date" timestamp without time zone NOT NULL
);


--
-- Name: Comment_pid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Comment_pid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Comment_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Comment_pid_seq" OWNED BY "Comment".pid;


--
-- Name: Comment_uid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "Comment_uid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: Comment_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "Comment_uid_seq" OWNED BY "Comment".uid;


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "User" (
    userid integer NOT NULL,
    username character varying(20) NOT NULL,
    email character varying(100) NOT NULL,
    "Password" character varying(64) NOT NULL,
    datesignup character varying(100) NOT NULL,
    isadmin boolean DEFAULT false
);


--
-- Name: User_userid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE "User_userid_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: User_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE "User_userid_seq" OWNED BY "User".userid;


--
-- Name: cafe; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE cafe (
    pid integer NOT NULL,
    smoking boolean,
    snack boolean
);


--
-- Name: cafe_pid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cafe_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cafe_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cafe_pid_seq OWNED BY cafe.pid;


--
-- Name: hotel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE hotel (
    pid integer NOT NULL,
    numstars integer,
    numrooms integer,
    pricerangedoubleroom character varying(200)
);


--
-- Name: hotel_pid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE hotel_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hotel_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE hotel_pid_seq OWNED BY hotel.pid;


--
-- Name: place; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE place (
    placeid integer NOT NULL,
    creatorid integer NOT NULL,
    creationdate timestamp without time zone,
    name character varying(100) NOT NULL,
    street character varying(64) NOT NULL,
    num character varying(10) NOT NULL,
    zip integer NOT NULL,
    city character varying(100) NOT NULL,
    longitude double precision,
    latitude double precision,
    phonenum character varying(100),
    website character varying(100)
);


--
-- Name: place_creatorid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE place_creatorid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_creatorid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE place_creatorid_seq OWNED BY place.creatorid;


--
-- Name: place_placeid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE place_placeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: place_placeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE place_placeid_seq OWNED BY place.placeid;


--
-- Name: restaurant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE restaurant (
    pid integer NOT NULL,
    pricerange character varying(200),
    banquet integer,
    takeout boolean,
    delivery boolean,
    closed character varying(300)
);


--
-- Name: restaurant_pid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE restaurant_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restaurant_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE restaurant_pid_seq OWNED BY restaurant.pid;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tag; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tag (
    pid integer NOT NULL,
    uid integer NOT NULL,
    name character varying(100) NOT NULL
);


--
-- Name: tag_pid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tag_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tag_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tag_pid_seq OWNED BY tag.pid;


--
-- Name: tag_uid_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tag_uid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tag_uid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tag_uid_seq OWNED BY tag.uid;


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Comment" ALTER COLUMN pid SET DEFAULT nextval('"Comment_pid_seq"'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Comment" ALTER COLUMN uid SET DEFAULT nextval('"Comment_uid_seq"'::regclass);


--
-- Name: userid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY "User" ALTER COLUMN userid SET DEFAULT nextval('"User_userid_seq"'::regclass);


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cafe ALTER COLUMN pid SET DEFAULT nextval('cafe_pid_seq'::regclass);


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY hotel ALTER COLUMN pid SET DEFAULT nextval('hotel_pid_seq'::regclass);


--
-- Name: placeid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY place ALTER COLUMN placeid SET DEFAULT nextval('place_placeid_seq'::regclass);


--
-- Name: creatorid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY place ALTER COLUMN creatorid SET DEFAULT nextval('place_creatorid_seq'::regclass);


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant ALTER COLUMN pid SET DEFAULT nextval('restaurant_pid_seq'::regclass);


--
-- Name: pid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag ALTER COLUMN pid SET DEFAULT nextval('tag_pid_seq'::regclass);


--
-- Name: uid; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag ALTER COLUMN uid SET DEFAULT nextval('tag_uid_seq'::regclass);


--
-- Name: Comment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (pid, uid, "Date");


--
-- Name: User_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- Name: User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (userid);


--
-- Name: User_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "User"
    ADD CONSTRAINT "User_username_key" UNIQUE (username);


--
-- Name: place_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY place
    ADD CONSTRAINT place_pkey PRIMARY KEY (placeid);


--
-- Name: tag_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_name_key UNIQUE (name);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (pid, uid);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: Comment_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Comment"
    ADD CONSTRAINT "Comment_pid_fkey" FOREIGN KEY (pid) REFERENCES place(placeid);


--
-- Name: Comment_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "Comment"
    ADD CONSTRAINT "Comment_uid_fkey" FOREIGN KEY (uid) REFERENCES "User"(userid);


--
-- Name: cafe_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY cafe
    ADD CONSTRAINT cafe_pid_fkey FOREIGN KEY (pid) REFERENCES place(placeid);


--
-- Name: hotel_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY hotel
    ADD CONSTRAINT hotel_pid_fkey FOREIGN KEY (pid) REFERENCES place(placeid);


--
-- Name: place_creatorid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY place
    ADD CONSTRAINT place_creatorid_fkey FOREIGN KEY (creatorid) REFERENCES "User"(userid);


--
-- Name: restaurant_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY restaurant
    ADD CONSTRAINT restaurant_pid_fkey FOREIGN KEY (pid) REFERENCES place(placeid);


--
-- Name: tag_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pid_fkey FOREIGN KEY (pid) REFERENCES place(placeid);


--
-- Name: tag_uid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_uid_fkey FOREIGN KEY (uid) REFERENCES "User"(userid);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;



