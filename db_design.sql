
SELECT mnemonic, course_name
FROM COURSES_ERD
WHERE active = TRUE;

SELECT mnemonic, course_name
FROM COURSES_ERD
WHERE active = FALSE;

SELECT instructor_name
FROM INSTRUCTORS_ERD
WHERE active = FALSE;

SELECT c.mnemonic, c.course_name, COUNT(l.outcome_id) AS number_of_learning_outcome
FROM COURSES_ERD c
LEFT JOIN LEARNING_OUTCOMES_ERD l ON c.course_id = l.course_id
GROUP BY c.course_id, c.mnemonic, c.course_name;

SELECT c.mnemonic, c.course_name
FROM COURSES_ERD c
LEFT JOIN LEARNING_OUTCOMES_ERD l ON c.course_id = l.course_id
WHERE l.outcome_id IS NULL;

SELECT c.mnemonic, c.course_name, l.learning_outcome
FROM COURSES_ERD c
JOIN LEARNING_OUTCOMES_ERD l ON c.course_id = l.course_id
WHERE l.learning_outcome LIKE '%SQL%';

SELECT i.instructor_name
FROM COURSE_ASSIGNMENT_ERD ca
JOIN INSTRUCTORS_ERD i ON ca.instructor_id = i.instructor_id
JOIN COURSES_ERD c ON ca.course_id = c.course_id
WHERE c.mnemonic = 'ds5100'
  AND ca.term = 'summer2021';

SELECT DISTINCT i.instructor_name
FROM COURSE_ASSIGNMENT_ERD ca
JOIN INSTRUCTORS_ERD i ON ca.instructor_id = i.instructor_id
WHERE ca.term = 'fall2021'
ORDER BY i.instructor_name;

SELECT i.instructor_name, ca.term, COUNT(ca.course_id) AS course_count
FROM COURSE_ASSIGNMENT_ERD ca
JOIN INSTRUCTORS_ERD i ON ca.instructor_id = i.instructor_id
GROUP BY i.instructor_name, ca.term
ORDER BY ca.term, i.instructor_name;

SELECT c.mnemonic, ca.term
FROM COURSE_ASSIGNMENT_ERD ca
JOIN COURSES_ERD c ON ca.course_id = c.course_id
GROUP BY c.mnemonic, ca.term
HAVING COUNT(DISTINCT ca.instructor_id) > 1;

WITH Multiple_Instructors AS (
    SELECT ca.course_id, ca.term
    FROM COURSE_ASSIGNMENT_ERD ca
    GROUP BY ca.course_id, ca.term
    HAVING COUNT(DISTINCT ca.instructor_id) > 1
)
SELECT ca.term, c.mnemonic, i.instructor_name
FROM COURSE_ASSIGNMENT_ERD ca
JOIN COURSES_ERD c ON ca.course_id = c.course_id
JOIN INSTRUCTORS_ERD i ON ca.instructor_id = i.instructor_id
JOIN Multiple_Instructors mi ON ca.course_id = mi.course_id AND ca.term = mi.term
ORDER BY ca.term, c.mnemonic, i.instructor_name;

