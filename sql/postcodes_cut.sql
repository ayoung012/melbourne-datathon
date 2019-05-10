ALTER TABLE postcodes_geo RENAME TO p_temp;

CREATE TABLE postcodes_geo(
  postcode varchar(5) default NULL,
  state varchar(4) default NULL,
  latitude decimal(6,3) default NULL,
  longitude decimal(6,3) default NULL
);

INSERT INTO postcodes_geo
    SELECT postcode, state, latitude, longitude
    FROM p_temp
    GROUP BY postcode,state,latitude,longitude
    ;

DROP TABLE p_temp;
