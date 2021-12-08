--------------------------------------------------------------
-- Filename:  V1.1__baseline.sql
--------------------------------------------------------------

CREATE TABLE IF NOT EXISTS employee
(
    empID      integer      NOT NULL,
    firstName  varchar(100) NOT NULL,
    lastName   varchar(100) NOT NULL,
    middleI    varchar(1),
    ssn        varchar(11)  NOT NULL,
    address1   varchar(100) NOT NULL,
    address2   varchar(100),
    city       varchar(50)  NOT NULL,
    state      varchar(50)  NOT NULL,
    postalCode varchar(20)  NOT NULL,
    country    varchar(50)  NOT NULL,
    hireDate   date         NOT NULL,
    termDate   date,
    partner    boolean      NOT NULL
);

CREATE TABLE IF NOT EXISTS eduLvl
(
    eduLvlID    integer NOT NULL,
    eduLvlName  varchar(20) NOT NULL,
    eduLvlDesc  varchar(100)
);

CREATE TABLE IF NOT EXISTS resumes
(
    resumeID      integer NOT NULL,
    empID         integer,
    DateSubmitted integer NOT NULL,
    interviewed   boolean NOT NULL,
    interviewDate date,
    maxEduID      integer,
    submitDate    date,
    resumeLoc     varchar(255)
);

CREATE TABLE IF NOT EXISTS contractManager
(
    CMID      integer NOT NULL,
    empID     integer NOT NULL,
    startDate date    NOT NULL,
    endDate   date
);

CREATE TABLE IF NOT EXISTS sponsors
(
    sponsorID   integer      NOT NULL,
    sponsorName varchar(255) NOT NULL,
    sponsorDesc varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS contracts
(
    contractID     integer      NOT NULL,
    contractName   varchar(255) NOT NULL,
    CMID           integer      NOT NULL,
    classifMinID   integer      NOT NULL,
    sponsorID      integer,
    startDate      date         NOT NULL,
    renewalDate    date         NOT NULL,
    activeContract boolean      NOT NULL,
    endDate        date
);

CREATE TABLE IF NOT EXISTS taskOrders
(
    TOID       integer      NOT NULL,
    contractID integer      NOT NULL,
    taskName   varchar(100) NOT NULL,
    taskDescr  varchar(255) NOT NULL,
    SOWID      varchar(100)
);

CREATE TABLE IF NOT EXISTS empContract
(
    ECID       integer NOT NULL,
    contractID integer NOT NULL,
    empID      integer NOT NULL,
    startDate  date    NOT NULL,
    endDate    date    NOT NULL
);

CREATE TABLE IF NOT EXISTS skills
(
    skillID   integer      NOT NULL,
    skillDesc varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS resumeSkills
(
    RSID     integer NOT NULL,
    resumeID integer NOT NULL,
    skillID  integer NOT NULL,
    RSRank   integer NOT NULL   --RSRank is ...
);

CREATE TABLE IF NOT EXISTS laborCategories
(
    LCID           integer      NOT NULL,
    laborIDNum     varchar(100) NOT NULL,
    LCDesc         varchar(255) NOT NULL,
    reqYearsExp    integer,
    categoryID     integer,
    subCatID       integer,
    worksite       varchar(100),
    reqEduLvl      integer,
    reqClearanceID integer      NOT NULL,
    sinNumber      varchar(100),
    billAmtMin     decimal,
    billAmtMax     decimal
);

CREATE TABLE IF NOT EXISTS contractSkills
(
    CSID       integer NOT NULL,
    contractID integer NOT NULL,
    skillID    integer NOT NULL,
    CSRank     integer NOT NULL, --CSRank is ...
    LCID       integer NOT NULL
);

CREATE TABLE IF NOT EXISTS certifications
(
    certID   integer      NOT NULL,
    certDesc varchar(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS resumeCert
(
    RCID         integer NOT NULL,
    certID       integer NOT NULL,
    resumeID     integer NOT NULL,
    dateRecieved date,
    renewalDate  date
);