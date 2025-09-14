-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2025-09-13 23:13:45 CLST
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE afp (
    id_afp     NUMBER NOT NULL,
    nombre_afp VARCHAR2(30) NOT NULL
);

ALTER TABLE afp ADD CONSTRAINT afp_pk PRIMARY KEY ( id_afp );

ALTER TABLE afp ADD CONSTRAINT afp_nombre_afp_un UNIQUE ( nombre_afp );

CREATE TABLE atencion_medica (
    id_atencion            NUMBER NOT NULL,
    fecha_atencion         DATE NOT NULL,
    medico_id_medico       NUMBER,
    paciente_id_paciente   NUMBER,
    solicitud_id_solicitud NUMBER NOT NULL
);

CREATE UNIQUE INDEX atencion_medica__idx ON
    atencion_medica (
        solicitud_id_solicitud
    ASC );

ALTER TABLE atencion_medica ADD CONSTRAINT atencion_medica_pk PRIMARY KEY ( id_atencion );

CREATE TABLE comuna (
    id_comuna        NUMBER NOT NULL,
    nombre_comuna    VARCHAR2(30) NOT NULL,
    region_id_region NUMBER NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna );

ALTER TABLE comuna ADD CONSTRAINT comuna_nombre_comuna_un UNIQUE ( nombre_comuna );

CREATE TABLE especialidad (
    id_especialidad NUMBER NOT NULL,
    nomb_esp        VARCHAR2(30) NOT NULL
);

ALTER TABLE especialidad ADD CONSTRAINT especialidad_nomb_esp_un UNIQUE ( nomb_esp );

CREATE TABLE examen (
    id_examen              NUMBER NOT NULL,
    nombre_examen          VARCHAR2(30) NOT NULL,
    solicitud_id_solicitud NUMBER NOT NULL
);

ALTER TABLE examen ADD CONSTRAINT examen_pk PRIMARY KEY ( id_examen );

ALTER TABLE examen ADD CONSTRAINT examen_nombre_examen_un UNIQUE ( nombre_examen );

CREATE TABLE fonasa (
    id_inst NUMBER NOT NULL
);

ALTER TABLE fonasa ADD CONSTRAINT fonasa_pk PRIMARY KEY ( id_inst );

CREATE TABLE general (
    id_atencion NUMBER NOT NULL
);

ALTER TABLE general ADD CONSTRAINT general_pk PRIMARY KEY ( id_atencion );

CREATE TABLE institucion_salud (
    id_inst   NUMBER NOT NULL,
    nomb_inst VARCHAR2(30) NOT NULL
);

ALTER TABLE institucion_salud ADD CONSTRAINT institucion_salud_pk PRIMARY KEY ( id_inst );

ALTER TABLE institucion_salud ADD CONSTRAINT institucion_salud_nomb_inst_un UNIQUE ( nomb_inst );

CREATE TABLE isapre (
    id_inst NUMBER NOT NULL
);

ALTER TABLE isapre ADD CONSTRAINT isapre_pk PRIMARY KEY ( id_inst );

CREATE TABLE medico (
    id_medico                 NUMBER NOT NULL,
    rut_medico                VARCHAR2(15) NOT NULL,
    nombre_medico             VARCHAR2(30) NOT NULL,
    fecha_ingreso             DATE NOT NULL,
    institucion_salud_id_inst NUMBER,
    afp_id_afp                NUMBER,
    medico_id_medico          NUMBER,
    especialidad_nomb_esp     VARCHAR2(30)
);

ALTER TABLE medico ADD CONSTRAINT medico_pk PRIMARY KEY ( id_medico );

ALTER TABLE medico ADD CONSTRAINT medico_rut_medico_un UNIQUE ( rut_medico );

CREATE TABLE paciente (
    id_paciente                NUMBER NOT NULL,
    rut_paciente               VARCHAR2(15) NOT NULL,
    nombre_paciente            VARCHAR2(30) NOT NULL,
    fecha_naciemiento_paciente DATE NOT NULL,
    direccion_paciente         VARCHAR2(50) NOT NULL,
    comuna_id_comuna           NUMBER,
    tipo_paciente              VARCHAR2(15) NOT NULL,
    email_paciente             VARCHAR2(50) NOT NULL
);

ALTER TABLE paciente
    ADD CONSTRAINT ck_paciente_tipo_paciente CHECK ( tipo_paciente IN ( '"Estudiante"', '"Externo"', '"Funcionario"' ) );

ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY ( id_paciente );

ALTER TABLE paciente ADD CONSTRAINT paciente_rut_paciente_un UNIQUE ( rut_paciente );

CREATE TABLE paciente_femenino (
    id_paciente NUMBER NOT NULL
);

ALTER TABLE paciente_femenino ADD CONSTRAINT paciente_femenino_pk PRIMARY KEY ( id_paciente );

CREATE TABLE paciente_masculino (
    id_paciente NUMBER NOT NULL
);

ALTER TABLE paciente_masculino ADD CONSTRAINT paciente_masculino_pk PRIMARY KEY ( id_paciente );

CREATE TABLE pago (
    id_pago                     NUMBER NOT NULL,
    monto                       NUMBER NOT NULL,
    fecha_pago                  DATE NOT NULL,
    atencion_medica_id_atencion NUMBER NOT NULL
);

ALTER TABLE pago ADD CONSTRAINT ck_pago_monto CHECK ( monto >= 0 );

ALTER TABLE pago ADD CONSTRAINT pago_pk PRIMARY KEY ( id_pago );

CREATE TABLE pago_convenio (
    id_pago     NUMBER NOT NULL,
    id_convenio NUMBER NOT NULL,
    nomb_conv   VARCHAR2(30) NOT NULL
);

ALTER TABLE pago_convenio ADD CONSTRAINT pago_convenio_pk PRIMARY KEY ( id_pago );

ALTER TABLE pago_convenio ADD CONSTRAINT pago_convenio_pkv1 UNIQUE ( id_convenio );

ALTER TABLE pago_convenio ADD CONSTRAINT pago_convenio_nomb_conv_un UNIQUE ( nomb_conv );

CREATE TABLE pago_credito (
    id_pago NUMBER NOT NULL,
    cuotas  NUMBER NOT NULL
);

ALTER TABLE pago_credito ADD CONSTRAINT ck_pago_credito_cuotas CHECK ( cuotas > 0 );

ALTER TABLE pago_credito ADD CONSTRAINT pago_credito_pk PRIMARY KEY ( id_pago );

CREATE TABLE pago_debito (
    id_pago NUMBER NOT NULL
);

ALTER TABLE pago_debito ADD CONSTRAINT pago_debito_pk PRIMARY KEY ( id_pago );

CREATE TABLE pago_efectivo (
    id_pago NUMBER NOT NULL
);

ALTER TABLE pago_efectivo ADD CONSTRAINT pago_efectivo_pk PRIMARY KEY ( id_pago );

CREATE TABLE pago_tarjeta (
    id_pago        NUMBER NOT NULL,
    id_tarjeta     NUMBER NOT NULL,
    nombre_tarjeta VARCHAR2(30) NOT NULL
);

ALTER TABLE pago_tarjeta ADD CONSTRAINT pago_tarjeta_pk PRIMARY KEY ( id_pago );

ALTER TABLE pago_tarjeta ADD CONSTRAINT pago_tarjeta_pkv1 UNIQUE ( id_tarjeta );

CREATE TABLE preparacion (
    id_preparacion   NUMBER NOT NULL,
    nomb_prep        VARCHAR2(30) NOT NULL,
    examen_id_examen NUMBER
);

ALTER TABLE preparacion ADD CONSTRAINT preparacion_pk PRIMARY KEY ( id_preparacion );

ALTER TABLE preparacion ADD CONSTRAINT preparacion_nomb_prep_un UNIQUE ( nomb_prep );

CREATE TABLE preventiva (
    id_atencion NUMBER NOT NULL
);

ALTER TABLE preventiva ADD CONSTRAINT preventiva_pk PRIMARY KEY ( id_atencion );

CREATE TABLE region (
    id_region     NUMBER NOT NULL,
    nombre_region VARCHAR2(30) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( id_region );

ALTER TABLE region ADD CONSTRAINT region_nombre_region_un UNIQUE ( nombre_region );

CREATE TABLE solicitud (
    id_solicitud NUMBER NOT NULL
);

ALTER TABLE solicitud ADD CONSTRAINT solicitud_pk PRIMARY KEY ( id_solicitud );

CREATE TABLE urgencia (
    id_atencion NUMBER NOT NULL
);

ALTER TABLE urgencia ADD CONSTRAINT urgencia_pk PRIMARY KEY ( id_atencion );

ALTER TABLE atencion_medica
    ADD CONSTRAINT atencion_medica_medico_fk FOREIGN KEY ( medico_id_medico )
        REFERENCES medico ( id_medico );

ALTER TABLE atencion_medica
    ADD CONSTRAINT atencion_medica_paciente_fk FOREIGN KEY ( paciente_id_paciente )
        REFERENCES paciente ( id_paciente );

ALTER TABLE atencion_medica
    ADD CONSTRAINT atencion_medica_solicitud_fk FOREIGN KEY ( solicitud_id_solicitud )
        REFERENCES solicitud ( id_solicitud );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_region_fk FOREIGN KEY ( region_id_region )
        REFERENCES region ( id_region );

ALTER TABLE examen
    ADD CONSTRAINT examen_solicitud_fk FOREIGN KEY ( solicitud_id_solicitud )
        REFERENCES solicitud ( id_solicitud );

ALTER TABLE fonasa
    ADD CONSTRAINT fonasa_institucion_salud_fk FOREIGN KEY ( id_inst )
        REFERENCES institucion_salud ( id_inst );

ALTER TABLE general
    ADD CONSTRAINT general_atencion_medica_fk FOREIGN KEY ( id_atencion )
        REFERENCES atencion_medica ( id_atencion );

ALTER TABLE isapre
    ADD CONSTRAINT isapre_institucion_salud_fk FOREIGN KEY ( id_inst )
        REFERENCES institucion_salud ( id_inst );

ALTER TABLE medico
    ADD CONSTRAINT medico_afp_fk FOREIGN KEY ( afp_id_afp )
        REFERENCES afp ( id_afp );

ALTER TABLE medico
    ADD CONSTRAINT medico_especialidad_fk FOREIGN KEY ( especialidad_nomb_esp )
        REFERENCES especialidad ( nomb_esp );

ALTER TABLE medico
    ADD CONSTRAINT medico_institucion_salud_fk FOREIGN KEY ( institucion_salud_id_inst )
        REFERENCES institucion_salud ( id_inst );

ALTER TABLE medico
    ADD CONSTRAINT medico_medico_fk FOREIGN KEY ( medico_id_medico )
        REFERENCES medico ( id_medico );

ALTER TABLE paciente
    ADD CONSTRAINT paciente_comuna_fk FOREIGN KEY ( comuna_id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE paciente_femenino
    ADD CONSTRAINT paciente_femenino_paciente_fk FOREIGN KEY ( id_paciente )
        REFERENCES paciente ( id_paciente );

ALTER TABLE paciente_masculino
    ADD CONSTRAINT paciente_masculino_paciente_fk FOREIGN KEY ( id_paciente )
        REFERENCES paciente ( id_paciente );

ALTER TABLE pago
    ADD CONSTRAINT pago_atencion_medica_fk FOREIGN KEY ( atencion_medica_id_atencion )
        REFERENCES atencion_medica ( id_atencion );

ALTER TABLE pago_convenio
    ADD CONSTRAINT pago_convenio_pago_fk FOREIGN KEY ( id_pago )
        REFERENCES pago ( id_pago );

ALTER TABLE pago_credito
    ADD CONSTRAINT pago_credito_pago_tarjeta_fk FOREIGN KEY ( id_pago )
        REFERENCES pago_tarjeta ( id_pago );

ALTER TABLE pago_debito
    ADD CONSTRAINT pago_debito_pago_tarjeta_fk FOREIGN KEY ( id_pago )
        REFERENCES pago_tarjeta ( id_pago );

ALTER TABLE pago_efectivo
    ADD CONSTRAINT pago_efectivo_pago_fk FOREIGN KEY ( id_pago )
        REFERENCES pago ( id_pago );

ALTER TABLE pago_tarjeta
    ADD CONSTRAINT pago_tarjeta_pago_fk FOREIGN KEY ( id_pago )
        REFERENCES pago ( id_pago );

ALTER TABLE preparacion
    ADD CONSTRAINT preparacion_examen_fk FOREIGN KEY ( examen_id_examen )
        REFERENCES examen ( id_examen );

ALTER TABLE preventiva
    ADD CONSTRAINT preventiva_atencion_medica_fk FOREIGN KEY ( id_atencion )
        REFERENCES atencion_medica ( id_atencion );

ALTER TABLE urgencia
    ADD CONSTRAINT urgencia_atencion_medica_fk FOREIGN KEY ( id_atencion )
        REFERENCES atencion_medica ( id_atencion );

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_2 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_3 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_3 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_4 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_4 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_5 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_5 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_5 - constraint trigger for Arc cannot be generated



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            24
-- CREATE INDEX                             1
-- ALTER TABLE                             62
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                  12
-- WARNINGS                                 0
