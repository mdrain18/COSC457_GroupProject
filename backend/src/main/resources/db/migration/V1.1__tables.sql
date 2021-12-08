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
    partner    boolean      NOT NULL,

    PRIMARY KEY (empID)
);

CREATE TABLE IF NOT EXISTS eduLvl
(
    eduLvlID    integer NOT NULL,
    eduLvlName  varchar(20) NOT NULL,
    eduLvlDesc  varchar(100),

    PRIMARY KEY (eduLvlID)
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
    resumeLoc     varchar(255),

    PRIMARY KEY (resumeID),
    constraint emp_fk foreign key (empID) references employee (empID),
    constraint edu_fk foreign key (maxEduID) references eduLvl (eduLvlID)
);

CREATE TABLE IF NOT EXISTS clearances
(
    clearanceID integer NOT NULL,
    clName      varchar(100) NOT NULL,
    clDesc      varchar(255) NOT NULL,

    PRIMARY KEY (clearanceID)
);

CREATE TABLE IF NOT EXISTS contractManager
(
    CMID      integer NOT NULL,
    empID     integer NOT NULL,
    startDate date    NOT NULL,
    endDate   date,

    PRIMARY KEY (CMID),
    constraint empCM_fk foreign key (empID) references employee (empID)
);

CREATE TABLE IF NOT EXISTS sponsors
(
    sponsorID   integer      NOT NULL,
    sponsorName varchar(255) NOT NULL,
    sponsorDesc varchar(255) NOT NULL,

    PRIMARY KEY (sponsorID)
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
    endDate        date,

    PRIMARY KEY (contractID),
    constraint cmid_fk foreign key (CMID) references contractManager (CMID),
    constraint sponsor_fk foreign key (sponsorID) references sponsors (sponsorID)
);

CREATE TABLE IF NOT EXISTS taskOrders
(
    TOID       integer      NOT NULL,
    contractID integer      NOT NULL,
    taskName   varchar(100) NOT NULL,
    taskDescr  varchar(255) NOT NULL,
    SOWID      varchar(100),

    PRIMARY KEY (TOID),
    constraint contract_fk foreign key (contractID) references contracts (contractID)
);

CREATE TABLE IF NOT EXISTS empContract
(
    ECID       integer NOT NULL,
    contractID integer NOT NULL,
    empID      integer NOT NULL,
    startDate  date    NOT NULL,
    endDate    date    NOT NULL,

    PRIMARY KEY (ECID),
    constraint contactEmp_fk foreign key (contractID) references contracts (contractID),
    constraint empID_fk foreign key (empID) references employee (empID)
);

CREATE TABLE IF NOT EXISTS skills
(
    skillID   integer      NOT NULL,
    skillDesc varchar(255) NOT NULL,

    PRIMARY KEY (skillID)
);

CREATE TABLE IF NOT EXISTS resumeSkills
(
    RSID     integer NOT NULL,
    resumeID integer NOT NULL,
    skillID  integer NOT NULL,
    RSRank   integer NOT NULL,   --RSRank is ...

    PRIMARY KEY (RSID),
    constraint resumeID_fk foreign key (resumeID) references resumes (resumeID),
    constraint skill_fk foreign key (skillID) references skills (skillID)
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
    reqClearanceID integer      NOT NULL, --reqClearanceID is...
    sinNumber      varchar(100),
    billAmtMin     decimal,
    billAmtMax     decimal,

    PRIMARY KEY (LCID),
    constraint reqEd_fk foreign key (reqEduLvl) references eduLvl (eduLvlID)
);

CREATE TABLE IF NOT EXISTS contractSkills
(
    CSID       integer NOT NULL,
    contractID integer NOT NULL,
    skillID    integer NOT NULL,
    CSRank     integer NOT NULL, --CSRank is ...
    LCID       integer NOT NULL,

    PRIMARY KEY (CSID),
    constraint conSkill_fk foreign key (contractID) references contracts (contractID),
    constraint skillCon_fk foreign key (skillID) references skills (skillID),
    constraint LCID_fk foreign key (LCID) references laborCategories (LCID)
);

CREATE TABLE IF NOT EXISTS certifications
(
    certID   integer      NOT NULL,
    certDesc varchar(255) NOT NULL,

    PRIMARY KEY (certID)
);

CREATE TABLE IF NOT EXISTS resumeCert
(
    RCID         integer NOT NULL,
    certID       integer NOT NULL,
    resumeID     integer NOT NULL,
    dateRecieved date,
    renewalDate  date,

    PRIMARY KEY (RCID),
    constraint certID_fk foreign key (certID) references certifications (certID),
    constraint resumeCert_fk foreign key (resumeID) references resumes (resumeID)
);