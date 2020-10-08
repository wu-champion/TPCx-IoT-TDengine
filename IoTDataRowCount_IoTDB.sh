#!/bin/bash
source ./Benchmark_Macros_IoTDB.sh
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#  @author Chinmayi Narasimhadevara
#
#

line=$(eval "$COUNT_ROWS_IN_TABLE | head -n 4 | tail -n 1 | awk '{print \$2}'")
num_rows=echo $line | tr -cd 0-9
`export num_rows=$num_rows`
