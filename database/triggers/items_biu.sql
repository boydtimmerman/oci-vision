--liquibase formatted sql

--changeset boyd.timmerman:1 runOnChange:true

create or replace trigger items_biu
before insert or update
on items
for each row
begin
    if inserting then
        :new.created_on    := sysdate;
        :new.created_by    := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
    end if;

    :new.updated_on     := sysdate;
    :new.updated_by     := coalesce(sys_context('APEX$SESSION','APP_USER'),user);
end items_biu;
/

--rollback: drop trigger images_biu;