# All the command below are specific for HBase please change as needed for other clients/databases

DB_HOST="192.168.10.68"

DB_PORT="6667"

CLI_PATH="/data/tpc/iotdb-cli-0.11.0-SNAPSHOT"

IOT_DATA_TABLE=usertable

CHECK_IF_TABLE_EXISTS="Table $IOT_DATA_TABLE doesnot exist"

TRUNCATE_TABLE="cat iotdb_scripts/delete.sql | xargs -i sh $CLI_PATH/sbin/start-cli.sh -h $DB_HOST -p $DB_PORT -u root -pw root -e '{}'"

CREATE_TABLE="cat iotdb_scripts/create.sql | xargs -i sh $CLI_PATH/sbin/start-cli.sh -h $DB_HOST -p $DB_PORT -u root -pw root -e '{}'"

CHECK_STATS_DB="status 'simple'"

#COUNT_ROWS_IN_TABLE="count 'usertable', INTERVAL=>1000000"

COUNT_ROWS_IN_TABLE="sh $CLI_PATH/sbin/start-cli.sh -h $DB_HOST -p $DB_PORT -u root -pw root -e 'select count(*) from root group by level=0'"

SUT_TABLE_PATH="/hbase/data/default/usertable/*/.regioninfo"

ROW_COUNT="ROWS="

SUT_SHELL="cat"

SUT_PARAMETERS="iotdbendpoint=$DB_HOST:$DB_PORT"
