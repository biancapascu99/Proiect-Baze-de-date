--1. Sa se afiseze instructorii care au cel mult 2 elevi. Sa se sorteze alfabetic dupa nume.

SELECT e.id_instructor as "Id instructor", i.nume as "Nume instructor", i.prenume as "Prenume instructor",
        count(e.id_elev) as "Numar elevi"
FROM elev_bpa e
JOIN  instructor_bpa i ON (e.id_instructor=i.id_instructor)
GROUP BY e.id_instructor, i.nume, i.prenume
HAVING count(e.id_elev)<=2
ORDER BY 2;

--2. Sa se afiseze codul instructorilor care nu lucreaza la aceasi scoala cu instructorul care are nr_ore = 25.

SELECT id_instructor
FROM are_instructor_bpa
MINUS
SELECT id_instructor
FROM are_instructor_bpa
WHERE id_scoala IN (SELECT id_scoala
                    FROM are_instructor_bpa
                    WHERE nr_ore = 25);

--3. Sa se afiseze elevii care au inceput si incheiat scoala in 2019.

SELECT *
FROM elev_bpa
WHERE TO_CHAR(data_inscriere, 'YYYY')  = '2019' and TO_CHAR(data_incheiere, 'YYYY') = '2019' ;

--4. Sa se afiseze elevul care a incheiat scoala de soferi dupa cel mai mare numar de zile.

SELECT id_elev,nume,prenume,data_inscriere,data_incheiere,data_incheiere-data_inscriere as "Nr zile"
FROM elev_bpa
WHERE data_incheiere-data_inscriere = 
            (
                SELECT MAX(data_incheiere-data_inscriere)
                FROM elev_bpa
            );


--5. Sa se afiseze instructorii elevilor ce au fost admisi dupa examen.

SELECT DISTINCT i.id_instructor, i.nume, i.prenume
FROM examen_bpa ex
JOIN elev_bpa e ON (e.id_elev=ex.id_elev)
JOIN instructor_bpa i ON (i.id_instructor=e.id_instructor)
WHERE LOWER(ex.calificativ)='admis';

--6 Sa se afiseze scoala de la care provin elevii care au categoria C la examen.

SELECT DISTINCT s.id_scoala,s.nume
FROM examen_bpa ex
JOIN elev_bpa e ON (e.id_elev=ex.id_elev)
JOIN instructor_bpa i ON (i.id_instructor=e.id_instructor)
JOIN are_instructor_bpa ai ON (ai.id_instructor=i.id_instructor)
JOIN scoala_bpa s ON (s.id_scoala=ai.id_scoala)
WHERE LOWER(ex.categorie)='c';

--7. Sa se afiseze elevii cu durata examenului cea mai mare.

SELECT e.id_elev,e.nume,e.prenume
FROM ruta_bpa r
JOIN examen_bpa ex ON (ex.id_ruta = r.id_ruta)
JOIN elev_bpa e ON (e.id_elev = ex.id_elev)
WHERE r.ora_sosire-r.ora_plecare = 
            (
                SELECT MAX(ruta_bpa.ora_sosire-ruta_bpa.ora_plecare)
                FROM ruta_bpa
            );


--8. Sa se afiseze instructorul si nr de elevi ai sai. Sa se sorteze descrescator dupa numarul de elevi, iar in caz de egalitate
--alfabetic dupa nume.

SELECT i.id_instructor,i.nume as "Nume instructor",count(e.id_elev) as "Nr elevi"
FROM elev_bpa e
JOIN instructor_bpa i ON (e.id_instructor=i.id_instructor)
GROUP BY e.id_instructor, i.nume, i.id_instructor
ORDER BY 3 DESC, 2 ASC;

--9. Sa se afiseze scolile care au cei mai multi elevi inscrisi.

SELECT x.id_scoala, x.nume, MAX("Nr elevi") as "Numarul elevilor" from (SELECT s.id_scoala,s.nume,count(e.id_elev) as "Nr elevi"
FROM examen_bpa ex
JOIN elev_bpa e ON (e.id_elev=ex.id_elev)
JOIN instructor_bpa i ON (i.id_instructor=e.id_instructor)
JOIN are_instructor_bpa ai ON (ai.id_instructor=i.id_instructor)
JOIN scoala_bpa s ON (s.id_scoala=ai.id_scoala)
GROUP BY s.id_scoala, s.nume) x 
GROUP BY x.id_scoala, x.nume
HAVING MAX("Nr elevi") = (
                        SELECT MAX(count(e2.id_elev)) 
                        FROM examen_bpa ex2
                        JOIN elev_bpa e2 ON (e2.id_elev=ex2.id_elev)
                        JOIN instructor_bpa i2 ON (i2.id_instructor=e2.id_instructor)
                        JOIN are_instructor_bpa ai2 ON (ai2.id_instructor=i2.id_instructor)
                        JOIN scoala_bpa s2 ON (s2.id_scoala=ai2.id_scoala)
                        GROUP BY s2.id_scoala, s2.nume 
                        );


--10. Sa se afiseze instructorii care au elevi cu nivelul incepator si care au fost admisi la examen.

SELECT DISTINCT i.id_instructor, i.nume, i.prenume,e.nivel
FROM examen_bpa ex
JOIN elev_bpa e ON (e.id_elev=ex.id_elev)
JOIN instructor_bpa i ON (i.id_instructor=e.id_instructor)
WHERE LOWER(ex.calificativ)='admis' and LOWER(e.nivel) = 'incepator';

--11. Sa se afiseze toate persoanele(instructori+elevi) care au anul nasterii dupa anul 1987.

SELECT nume, prenume, data_nastere
FROM instructor_bpa
WHERE TO_CHAR(data_nastere, 'YYYY') > '1987' 
UNION 
SELECT  nume, prenume, data_nastere
FROM elev_bpa
WHERE TO_CHAR(data_nastere, 'YYYY') > '1987' ;

--12. Sa se afiseze pentru salariile instructorilor cuprinse intre [0,800) "MIC" , [800,1300) "MEDIU",
--[1300,2500] "MARE" , peste 2500 "FOARTE MARE".

SELECT salariu,
CASE 
        WHEN (salariu < 800) THEN 'MIC'
        WHEN (salariu >= 800 AND salariu < 1300) THEN 'MEDIU'
        WHEN (salariu >= 1300 AND salariu < 2500) THEN 'MARE'
        ELSE 'FOARTE MARE'
        END as "TIP SALARIU"
FROM are_instructor_bpa;

--13. Sa se afiseze elevii al caror nume contine doua litere 'a' sau al caror prenumele are exact 3 litere si 
--prenumele instructorului acestora incepe cu litera 'i'.

SELECT e.id_elev as "Id elev",e.nume as "Nume elev",e.prenume as "Prenume elev", i.nume as "Nume instructor",
        i.prenume as "Prenume instructor"
FROM elev_bpa e
JOIN instructor_bpa i ON(e.id_instructor = i.id_instructor)
WHERE (LOWER(e.nume) LIKE '%a%a%' OR LENGTH(e.prenume) = 3) AND (LOWER(i.nume) LIKE 'i%');

--14. Sa se afiseze toti instructorii si elevii lor, inclusiv instructorii care nu au elevi.

SELECT i.id_instructor, i.nume as "Nume instructor", i.prenume as "Prenume instructor", e.id_elev as "Id elev",
       e.nume as "Nume elev",e.prenume as "Prenume elev"
FROM instructor_bpa i
LEFT JOIN elev_bpa e ON (i.id_instructor = e.id_instructor);


--15. Sa se afiseze elevii care au dat examen de mai multe ori.

SELECT e.nume as "Nume",e.prenume as "Prenume", count(e.id_elev) as "Numar sustineri examen"
FROM elev_bpa e
JOIN examen_bpa ex ON (ex.id_elev = e.id_elev) 
GROUP BY e.nume, e.prenume
HAVING COUNT(e.id_elev) > 1;



--16. Sa se afiseze toate id-urile instructorilor care lucreaza la scoli cu rating = 7.

SELECT DISTINCT id_instructor
FROM are_instructor_bpa ai1
WHERE NOT EXISTS 
    (SELECT 1
     FROM scoala_bpa s
     WHERE  rating = 7
     AND NOT EXISTS
        (SELECT 2
         FROM are_instructor_bpa ai2
         WHERE s.id_scoala = ai2.id_scoala
         AND ai2.id_instructor=ai1.id_instructor
         ))
ORDER BY 1;
