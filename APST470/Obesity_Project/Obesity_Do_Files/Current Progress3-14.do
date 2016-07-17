/*Start with variable recoding, eliminate missing data codes*/
recode  no_exercise few_fruit_veg obesity high_blood_pres smoker diabetes health_status unhealthy_days (-1111.1=.), gen ( no_exerciseRec, few_fruit_vegRec, obesityRec, high_blood_presRec, smokerRec, diabetesRec, health_statusRec, unhealthy_daysRec)
recode  elderly_medicare disabled_medicare (-2222=.), gen ( elderly_medicareRec, disabled_medicareRec)
recode  poverty dentist_rate (-2222.2=.), gen (povertyRec, dentist_rateRec)
recode community_health_center_ind (1=0) (2=1), gen (CenterYN)
recode  hpsa_ind (1=0) (2=1), gen (HP_ShortageYN)

/*Generate new variables that will be useful for comparisons*/
*These variables were counts that needed to be turned into rates*
gen uninsuredrate= (uninsured/ population_size)
gen eldermedicarerate= ( elderly_medicare/ population_size)
gen disabmedicarerate= (  disabled_medicare/ population_size)