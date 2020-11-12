DB_HOST="192.168.10.68"

DB_PORT="6667"

CLI_PATH="/data/tpc/iotdb-cli-0.11.0-SNAPSHOT"

CLI_SHELL="xargs -i sh $CLI_PATH/sbin/start-cli.sh -h $DB_HOST -p $DB_PORT -u root -pw root -e '{}'"

CHECK_IF_TABLE_EXISTS="Table IoTDB does exist"

TRUNCATE_TABLE="echo 'delete storage group root.*' |  $CLI_SHELL"

CREATE_TABLE="There is no need to create table in IoTDB"

CHECK_STATS_DB=""

COUNT_ROWS_IN_TABLE="echo 'flush;select count(*) from root group by level=0' | $CLI_SHELL"

SUT_TABLE_PATH="/hbase/data/default/usertable/*/.regioninfo"

SUT_SHELL="cat"

SUT_PARAMETERS="iotdbendpoint=$DB_HOST:$DB_PORT"
