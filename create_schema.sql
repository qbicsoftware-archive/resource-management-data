
-- for informations about foreign key on update and on delete see:
-- http://stackoverflow.com/a/6720458
--BOOL,BOOLEAN These types are synonyms for TINYINT(1). A value of zero is considered false. Nonzero values are considered

-- Mysql specific instruction that disables the check of the foreign keys
-- constraints
SET foreign_key_checks = 0;


-- Table structure for user groups or roles. Maybe it is not needed, as this
-- information might be saved in liferay as well

DROP TABLE IF EXISTS usergroups;
CREATE TABLE usergroups(
    usergroup_id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    type varchar(85),
    PRIMARY KEY (usergroup_id)
) ENGINE=INNODB DEFAULT CHARACTER SET utf8;



-- Table structre for users. Contains liferayUserId
--blocked: do we need a boolean to see block and unblock certain users ??

DROP TABLE IF EXISTS users;
CREATE TABLE users(
    user_id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    liferay_user_id mediumint(8) NOT NULL,
    usergroup_id mediumint(8) unsigned NOT NULL,
    PRIMARY KEY(user_id),
    FOREIGN KEY (usergroup_id)
        REFERENCES usergroups(usergroup_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
    )ENGINE=INNODB  DEFAULT CHARACTER SET utf8;

--Table structure for Resource/device(s) of the facs facility
DROP TABLE IF EXISTS resources;
CREATE TABLE resources(
    resource_id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    name varchar(85) NOT NULL,
    descr varchar(255) NOT NULL,
    short_desc varchar(88) NOT NULL,
    restricted TINYINT(1) NOT NULL,
    PRIMARY KEY(resource_id)
) ENGINE=InnoDB DEFAULT CHARACTER SET utf8;


--Table structure for kostenstelle, prices depend on that thing I suppose
DROP TABLE IF EXISTS cost_locations;
CREATE TABLE cost_locations(
    cost_location_id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    name varchar(85) NOT NULL,
    abbreviation varchar(20) NOT NULL,
    PRIMARY KEY (cost_location_id)
)ENGINE=InnoDB DEFAULT CHARACTER SET utf8;


--This table will link a user with a kostenstelle
DROP TABLE IF EXISTS users_cost_locations_junction;
CREATE TABLE users_cost_locations_junction(
    user_id mediumint(8) unsigned NOT NULL,
    cost_location_id mediumint(8) unsigned NOT NULL,
    CONSTRAINT user_cost_pk PRIMARY KEY (user_id, cost_location_id),
    FOREIGN KEY(user_id)
        REFERENCES users(user_id)
         ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(cost_location_id)
        REFERENCES cost_locations(cost_location_id)
        ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;


--Table structure for a time block/event. every resource can have many time
--blocks.
DROP TABLE IF EXISTS time_blocks;
CREATE TABLE time_blocks(
    block_id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    label varchar(85),
    description varchar(255),
    resource_id mediumint(8) unsigned NOT NULL,
    user_id mediumint(8) unsigned NOT NULL,
    kostenstelle_id mediumint(8) unsigned NOT NULL,
    start_time time NOT NULL,
    end_time time NOT NULL,
    PRIMARY KEY (block_id),
    INDEX (resource_id),
    FOREIGN KEY (resource_id)
      REFERENCES resources(resource_id)
      ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;


--Table strucutre for arbeitsgruppe
--this is basically a domain/cv. Many users can belong to one arbeitsgruppe
DROP TABLE IF EXISTS workgroup;
CREATE TABLE workgroup(
    name varchar(255) NOT NULL,
    PRIMARY KEY (name)
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;

--Table structure for institute
--every user belongs to one institute
DROP TABLE IF EXISTS institute;
CREATE TABLE institute(
    institute_id mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
    name varchar(255) NOT NULL,
    street varchar(255) NOT NULL,
    postal_code mediumint(8) unsigned NOT NULL,
    city varchar(255) NOT NULL,
    short_name varchar(88) NOT NULL,
    PRIMARY KEY (institute_id)
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;

--Table structure for role
-- users can have different roles. Are they external, internal something else
DROP TABLE IF EXISTS role;
CREATE TABLE role(
    name varchar(88) NOT NULL,
    PRIMARY KEY (name)
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;


--Table structure for Kategorie (domain/cv). I have no better name yet.
--is a user  advanced, novice,admin etc. for a resource/device.

DROP TABLE IF EXISTS category;
CREATE TABLE category(
    name varchar(88) NOT NULL,
    PRIMARY KEY (name)
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;

--Table structure for project(domain/cv). I have no idea how they use projects
--so far, but there are users with projects.

DROP TABLE IF EXISTS projects;
CREATE TABLE projects(
    name varchar(88) NOT NULL,
    PRIMARY KEY (name)
)ENGINE=INNODB DEFAULT CHARACTER SET utf8;



