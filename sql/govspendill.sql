select t.Patient_ID, ic.ChronicIllness, sum(GovernmentReclaim_Amt) as total
from transactions t
join implied_condition ic on t.Patient_ID = ic.Patient_ID
where GovernmentReclaim_Amt != '' group by t.Patient_ID, ic.ChronicIllness order by total desc limit 10;

select t.Patient_ID, ic.ChronicIllness, sum(GovernmentReclaim_Amt) as total
from transactions t
join implied_condition ic on t.Patient_ID = ic.Patient_ID
where t.Patient_ID IN (
    SELECT t2.Patient_ID from transactions t2
    where GovernmentReclaim_Amt != ''
    group by t2.Patient_ID
    order by sum(GovernmentReclaim_Amt) desc
    limit 10
)
group by t.Patient_ID, ic.ChronicIllness

order by total desc;

