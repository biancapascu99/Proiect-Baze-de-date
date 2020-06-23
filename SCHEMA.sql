CREATE TABLE "SCOALA_BPA" (
	"ID_SCOALA" INT NOT NULL,
	"NUME" VARCHAR2(100) NOT NULL,
	"ADRESA" VARCHAR2(200) NOT NULL,
	"CAPACITATE" INT NOT NULL,
	"RATING" INT NOT NULL,
	constraint SCOALA_BPA_PK PRIMARY KEY ("ID_SCOALA"));

CREATE sequence "SCOALA_BPA_ID_SCOALA_SEQ";

CREATE trigger "BI_SCOALA_BPA_ID_SCOALA"
  before insert on "SCOALA_BPA"
  for each row
begin
  select "SCOALA_BPA_ID_SCOALA_SEQ".nextval into :NEW."ID_SCOALA" from dual;
end;


CREATE TABLE "RUTA_BPA" (
	"ID_RUTA" INT NOT NULL,
	"NR_KM" INT NOT NULL,
	"ORA_PLECARE" TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
	"ORA_SOSIRE" TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
	constraint RUTA_BPA_PK PRIMARY KEY ("ID_RUTA"));

CREATE sequence "RUTA_BPA_ID_RUTA_SEQ";

CREATE trigger "BI_RUTA_BPA_ID_RUTA"
  before insert on "RUTA_BPA"
  for each row
begin
  select "RUTA_BPA_ID_RUTA_SEQ".nextval into :NEW."ID_RUTA" from dual;
end;


CREATE TABLE "INSTRUCTOR_BPA" (
	"ID_INSTRUCTOR" INT NOT NULL,
	"NUME" VARCHAR2(50) NOT NULL,
	"PRENUME" VARCHAR2(50) NOT NULL,
	"DATA_NASTERE" DATE NOT NULL,
	constraint INSTRUCTOR_BPA_PK PRIMARY KEY ("ID_INSTRUCTOR"));

CREATE sequence "INST_BPA_ID_INST_SEQ";

CREATE trigger "BI_INST_BPA_ID_INST"
  before insert on "INSTRUCTOR_BPA"
  for each row
begin
  select "INST_BPA_ID_INST_SEQ".nextval into :NEW."ID_INSTRUCTOR" from dual;
end;


CREATE TABLE "ELEV_BPA" (
	"ID_ELEV" INT NOT NULL,
	"ID_INSTRUCTOR" INT NOT NULL,
	"NUME" VARCHAR2(50) NOT NULL,
	"PRENUME" VARCHAR2(50) NOT NULL,
	"DATA_NASTERE" DATE NOT NULL,
	"NIVEL" VARCHAR2(20) NOT NULL,
	"DATA_INSCRIERE" DATE NOT NULL,
	"DATA_INCHEIERE" DATE NOT NULL,
	constraint ELEV_BPA_PK PRIMARY KEY ("ID_ELEV"));

CREATE sequence "ELEV_BPA_ID_ELEV_SEQ";

CREATE trigger "BI_ELEV_BPA_ID_ELEV"
  before insert on "ELEV_BPA"
  for each row
begin
  select "ELEV_BPA_ID_ELEV_SEQ".nextval into :NEW."ID_ELEV" from dual;
end;


CREATE TABLE "ARE_INSTRUCTOR_BPA" (
	"ID_SCOALA" INT NOT NULL,
	"ID_INSTRUCTOR" INT NOT NULL,
	"NR_ORE" INT NOT NULL,
	"SALARIU" FLOAT NOT NULL);



CREATE TABLE "EXAMEN_BPA" (
	"ID_EXAMEN" INT NOT NULL,
	"ID_RUTA" INT NOT NULL,
	"ID_ELEV" INT NOT NULL,
	"CALIFICATIV" VARCHAR2(50) NOT NULL,
	"CATEGORIE" CHAR(255) NOT NULL,
	constraint EXAMEN_BPA_PK PRIMARY KEY ("ID_EXAMEN"));

CREATE sequence "EXAMEN_BPA_ID_EXAMEN_SEQ";

CREATE trigger "BI_EXAMEN_BPA_ID_EXAMEN"
  before insert on "EXAMEN_BPA"
  for each row
begin
  select "EXAMEN_BPA_ID_EXAMEN_SEQ".nextval into :NEW."ID_EXAMEN" from dual;
end;



CREATE TABLE "MASINA_BPA" (
	"ID_MASINA" INT NOT NULL,
	"ID_SCOALA" INT NOT NULL,
	"MARCA" VARCHAR2(50) NOT NULL,
	"MODEL" VARCHAR2(50) NOT NULL,
	"DATA_FABRICARE" DATE NOT NULL,
	constraint MASINA_BPA_PK PRIMARY KEY ("ID_MASINA"));

CREATE sequence "MASINA_BPA_ID_MASINA_SEQ";

CREATE trigger "BI_MASINA_BPA_ID_MASINA"
  before insert on "MASINA_BPA"
  for each row
begin
  select "MASINA_BPA_ID_MASINA_SEQ".nextval into :NEW."ID_MASINA" from dual;
end;




ALTER TABLE "MASINA_BPA" ADD CONSTRAINT "MASINA_BPA_fk0" FOREIGN KEY ("ID_SCOALA")
            REFERENCES "SCOALA_BPA"("ID_SCOALA");


ALTER TABLE "ELEV_BPA" ADD CONSTRAINT "ELEV_BPA_fk0" FOREIGN KEY ("ID_INSTRUCTOR") 
            REFERENCES "INSTRUCTOR_BPA"("ID_INSTRUCTOR");

ALTER TABLE "ARE_INSTRUCTOR_BPA" ADD CONSTRAINT "ARE_INSTRUCTOR_BPA_fk0" FOREIGN KEY ("ID_SCOALA") 
            REFERENCES "SCOALA_BPA"("ID_SCOALA");
ALTER TABLE "ARE_INSTRUCTOR_BPA" ADD CONSTRAINT "ARE_INSTRUCTOR_BPA_fk1" FOREIGN KEY ("ID_INSTRUCTOR") 
            REFERENCES "INSTRUCTOR_BPA"("ID_INSTRUCTOR");

ALTER TABLE "EXAMEN_BPA" ADD CONSTRAINT "EXAMEN_BPA_fk0" FOREIGN KEY ("ID_RUTA") 
            REFERENCES "RUTA_BPA"("ID_RUTA");
ALTER TABLE "EXAMEN_BPA" ADD CONSTRAINT "EXAMEN_BPA_fk1" FOREIGN KEY ("ID_ELEV") 
            REFERENCES "ELEV_BPA"("ID_ELEV");

--instructor 

INSERT INTO instructor_bpa (nume,prenume,data_nastere)
VALUES ('Ionescu','Ionel',TO_DATE('1989-12-09','YYYY-MM-DD'));

INSERT INTO instructor_bpa (nume,prenume,data_nastere)
VALUES ('Marinescu','Monica',TO_DATE('1972-02-12','YYYY-MM-DD'));

INSERT INTO instructor_bpa (nume,prenume,data_nastere)
VALUES ('Mihnea','Aurel',TO_DATE('1977-11-29','YYYY-MM-DD'));

INSERT INTO instructor_bpa (nume,prenume,data_nastere)
VALUES ('Mateescu','Alexandru',TO_DATE('1990-01-21','YYYY-MM-DD'));

INSERT INTO instructor_bpa (nume,prenume,data_nastere)
VALUES ('Popa','Irina',TO_DATE('1982-12-29','YYYY-MM-DD'));

INSERT INTO instructor_bpa (nume,prenume,data_nastere)
VALUES ('Baniciu','Andrei',TO_DATE('1989-03-05','YYYY-MM-DD'));


--elevi 

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (2,'Gheorghe','Ionut',TO_DATE('1999-12-09','YYYY-MM-DD'),'Incepator',TO_DATE('2020-12-09','YYYY-MM-DD'),
        TO_DATE('2021-02-09','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (2,'Ghimis','Cristian',TO_DATE('2000-02-10','YYYY-MM-DD'),'Mediu',TO_DATE('2020-02-10','YYYY-MM-DD'),
        TO_DATE('2020-04-10','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (2,'Proteasa','Vlad',TO_DATE('1999-12-09','YYYY-MM-DD'),'Avansat',TO_DATE('2019-03-05','YYYY-MM-DD'),
        TO_DATE('2019-05-05','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (1,'Barda','Monica',TO_DATE('1999-07-12','YYYY-MM-DD'),'Incepator',TO_DATE('2018-08-25','YYYY-MM-DD'),
        TO_DATE('2018-10-25','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (5,'Barda','Monica',TO_DATE('1999-07-12','YYYY-MM-DD'),'Avansat',TO_DATE('2020-09-25','YYYY-MM-DD'),
        TO_DATE('2020-11-25','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (1,'Sima','Ion',TO_DATE('1999-06-09','YYYY-MM-DD'),'Mediu',TO_DATE('2020-12-09','YYYY-MM-DD'),
        TO_DATE('2021-02-09','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (1,'Dumitrana','Daniel',TO_DATE('1997-10-16','YYYY-MM-DD'),'Mediu',TO_DATE('2018-08-28','YYYY-MM-DD'),
        TO_DATE('2018-10-28','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (3,'Vasilescu','Dariana',TO_DATE('1998-04-19','YYYY-MM-DD'),'Incepator',TO_DATE('2018-12-09','YYYY-MM-DD'),
        TO_DATE('2019-02-09','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (4,'Bratu','Valerian',TO_DATE('1996-04-08','YYYY-MM-DD'),'Avansat',TO_DATE('2020-04-08','YYYY-MM-DD'),
        TO_DATE('2020-06-08','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (4,'Mario','Marcel',TO_DATE('1998-07-09','YYYY-MM-DD'),'Incepator',TO_DATE('2020-06-09','YYYY-MM-DD'),
        TO_DATE('2021-08-09','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (4,'Petre','Maria',TO_DATE('1999-03-09','YYYY-MM-DD'),'Mediu',TO_DATE('2018-07-09','YYYY-MM-DD'),
        TO_DATE('2018-09-09','YYYY-MM-DD'));

INSERT INTO elev_bpa (id_instructor,nume,prenume,data_nastere,nivel,data_inscriere,data_incheiere)
VALUES (5,'Apetrei','Mara',TO_DATE('1996-04-13','YYYY-MM-DD'),'Mediu',TO_DATE('2019-02-12','YYYY-MM-DD'),
        TO_DATE('2021-04-12','YYYY-MM-DD'));

--scoala

INSERT INTO scoala_bpa (nume,adresa,capacitate,rating)
VALUES ('Cama','Strada Maria Tanase 3', 12, 8);

INSERT INTO scoala_bpa (nume,adresa,capacitate,rating)
VALUES ('TOP','Calea Mosilor 84', 5, 9);

INSERT INTO scoala_bpa (nume,adresa,capacitate,rating)
VALUES ('Drive School','Strada Olteniei 35-37', 20, 7);

INSERT INTO scoala_bpa (nume,adresa,capacitate,rating)
VALUES ('Teo','Strada Florilor 12', 15, 5);

INSERT INTO scoala_bpa (nume,adresa,capacitate,rating)
VALUES ('Mara','Strada Ion Creanga 45', 20, 10);


-- ruta

INSERT INTO ruta_bpa (nr_km,ora_plecare,ora_sosire)
VALUES (10, TO_TIMESTAMP ('10-Sep-20 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),
        TO_TIMESTAMP ('10-Sep-20 16:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'));

INSERT INTO ruta_bpa (nr_km,ora_plecare,ora_sosire)
VALUES (15, TO_TIMESTAMP ('22-JUN-21 12:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),
        TO_TIMESTAMP ('22-JUN-21 14:30:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'));

INSERT INTO ruta_bpa (nr_km,ora_plecare,ora_sosire)
VALUES (20, TO_TIMESTAMP ('30-AUG-18 11:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),
        TO_TIMESTAMP ('30-AUG-18 12:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'));

INSERT INTO ruta_bpa (nr_km,ora_plecare,ora_sosire)
VALUES (13, TO_TIMESTAMP ('30-AUG-20 16:30:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),
        TO_TIMESTAMP ('30-AUG-20 19:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'));

INSERT INTO ruta_bpa (nr_km,ora_plecare,ora_sosire)
VALUES (5, TO_TIMESTAMP ('14-Feb-19 15:50:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),
        TO_TIMESTAMP ('14-Feb-19 16:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'));

INSERT INTO ruta_bpa (nr_km,ora_plecare,ora_sosire)
VALUES (21, TO_TIMESTAMP ('20-FEB-20 14:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'),
        TO_TIMESTAMP ('20-Feb-20 16:10:10.123000', 'DD-Mon-RR HH24:MI:SS.FF'));


--masina

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (1, 'Audi', 'A5', to_date('2007-06-09','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (1, 'Audi', 'A4', to_date('2002-06-09','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (2, 'Dacia', 'Logan', to_date('2005-07-01','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (2, 'Opel', 'Astra', to_date('2000-04-03','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (2, 'Volkswagen', 'Polo', to_date('2004-12-10','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (3, 'Audi', 'A5', to_date('2010-07-09','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (3, 'Volkswagen', 'Golf', to_date('2001-09-24','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (4, 'Mercedes-Benz', 'Q7', to_date('2012-04-09','YYYY-MM-DD'));

INSERT INTO masina_bpa( id_scoala,marca,model,data_fabricare)
VALUES (5, 'Mercedes-Benz', 'Q1', to_date('2003-12-09','YYYY-MM-DD'));

--examen

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (4,2,'Admis','C');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (6,2,'Respins','C');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (7,2,'Respins','C');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (5,1,'Admis','C');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (4,1,'Respins','C');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (6,9,'Respins','C');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (7,11,'Respins','D');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (8,8,'Admis','E');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (9,3,'Respins','E');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (7,3,'Admis','E');

INSERT INTO examen_bpa(id_ruta, id_elev,calificativ,categorie)
VALUES (4,3,'Respins','E');


--are_instructor

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (1,1,12,1200);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (3,1,20,1400);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (2,1,3,700);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (3,4,20,2200);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (4,3,10,1100);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (5,6,3,700);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (4,5,25,3500);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (1,5,5,500);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (3,6,13,1800);

INSERT INTO are_instructor_bpa(id_scoala,id_instructor,nr_ore,salariu)
VALUES (5,2,3,700);
