// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

namespace cpp doris
namespace java org.apache.doris.thrift

include "Status.thrift"
include "Types.thrift"
include "PlanNodes.thrift"
include "AgentService.thrift"
include "PaloInternalService.thrift"
include "DorisExternalService.thrift"

struct TExportTaskRequest {
    1: required PaloInternalService.TExecPlanFragmentParams params
}

struct TTabletStat {
    1: required i64 tablet_id
    // local data size
    2: optional i64 data_size
    3: optional i64 row_num
    4: optional i64 version_count
    5: optional i64 remote_data_size 
}

struct TTabletStatResult {
    1: required map<i64, TTabletStat> tablets_stats
    2: optional list<TTabletStat> tablet_stat_list
}

struct TKafkaLoadInfo {
    1: required string brokers;
    2: required string topic;
    3: required map<i32, i64> partition_begin_offset;
    4: optional map<string, string> properties;
}

struct TRoutineLoadTask {
    1: required Types.TLoadSourceType type
    2: required i64 job_id
    3: required Types.TUniqueId id
    4: required i64 txn_id
    5: required i64 auth_code
    6: optional string db
    7: optional string tbl
    8: optional string label
    9: optional i64 max_interval_s
    10: optional i64 max_batch_rows
    11: optional i64 max_batch_size
    12: optional TKafkaLoadInfo kafka_load_info
    13: optional PaloInternalService.TExecPlanFragmentParams params
    14: optional PlanNodes.TFileFormatType format
    15: optional PaloInternalService.TPipelineFragmentParams pipeline_params
}

struct TKafkaMetaProxyRequest {
    1: optional TKafkaLoadInfo kafka_info
}

struct TKafkaMetaProxyResult {
    1: optional list<i32> partition_ids
}

struct TProxyRequest {
    1: optional TKafkaMetaProxyRequest kafka_meta_request;
}

struct TProxyResult {
    1: required Status.TStatus status;
    2: optional TKafkaMetaProxyResult kafka_meta_result;
}

struct TStreamLoadRecord {
    1: optional string cluster
    2: required string user
    3: required string passwd
    4: required string db
    5: required string tbl
    6: optional string user_ip
    7: required string label
    8: required string status
    9: required string message
    10: optional string url
    11: optional i64 auth_code;
    12: required i64 total_rows
    13: required i64 loaded_rows
    14: required i64 filtered_rows
    15: required i64 unselected_rows
    16: required i64 load_bytes
    17: required i64 start_time
    18: required i64 finish_time
    19: optional string comment
}

struct TStreamLoadRecordResult {
    1: required map<string, TStreamLoadRecord> stream_load_record
}

struct TDiskTrashInfo {
    1: required string root_path
    2: required string state
    3: required i64 trash_used_capacity
}

struct TCheckStorageFormatResult {
    1: optional list<i64> v1_tablets;
    2: optional list<i64> v2_tablets;
}

struct TIngestBinlogRequest {
    1: optional i64 txn_id;
    2: optional i64 remote_tablet_id;
    3: optional i64 binlog_version;
    4: optional string remote_host;
    5: optional string remote_port;
    6: optional i64 partition_id;
    7: optional i64 local_tablet_id;
    8: optional Types.TUniqueId load_id;
}

struct TIngestBinlogResult {
    1: optional Status.TStatus status;
}

service BackendService {
    // Called by coord to start asynchronous execution of plan fragment in backend.
    // Returns as soon as all incoming data streams have been set up.
    PaloInternalService.TExecPlanFragmentResult exec_plan_fragment(1:PaloInternalService.TExecPlanFragmentParams params);

    // Called by coord to cancel execution of a single plan fragment, which this
    // coordinator initiated with a prior call to ExecPlanFragment.
    // Cancellation is asynchronous.
    PaloInternalService.TCancelPlanFragmentResult cancel_plan_fragment(
        1:PaloInternalService.TCancelPlanFragmentParams params);

    // Called by sender to transmit single row batch. Returns error indication
    // if params.fragmentId or params.destNodeId are unknown or if data couldn't be read.
    PaloInternalService.TTransmitDataResult transmit_data(
        1:PaloInternalService.TTransmitDataParams params);

    AgentService.TAgentResult submit_tasks(1:list<AgentService.TAgentTaskRequest> tasks);

    AgentService.TAgentResult make_snapshot(1:AgentService.TSnapshotRequest snapshot_request);

    AgentService.TAgentResult release_snapshot(1:string snapshot_path);

    AgentService.TAgentResult publish_cluster_state(1:AgentService.TAgentPublishRequest request);

    Status.TStatus submit_export_task(1:TExportTaskRequest request);

    PaloInternalService.TExportStatusResult get_export_status(1:Types.TUniqueId task_id);

    Status.TStatus erase_export_task(1:Types.TUniqueId task_id);

    TTabletStatResult get_tablet_stat();
    
    i64 get_trash_used_capacity();
    
    list<TDiskTrashInfo> get_disk_trash_used_capacity();

    Status.TStatus submit_routine_load_task(1:list<TRoutineLoadTask> tasks);

    // doris will build  a scan context for this session, context_id returned if success
    DorisExternalService.TScanOpenResult open_scanner(1: DorisExternalService.TScanOpenParams params);

    // return the batch_size of data
    DorisExternalService.TScanBatchResult get_next(1: DorisExternalService.TScanNextBatchParams params);

    // release the context resource associated with the context_id
    DorisExternalService.TScanCloseResult close_scanner(1: DorisExternalService.TScanCloseParams params);

    TStreamLoadRecordResult get_stream_load_record(1: i64 last_stream_record_time);

    oneway void clean_trash();

    // check tablet rowset type
    TCheckStorageFormatResult check_storage_format();

    TIngestBinlogResult ingest_binlog(1: TIngestBinlogRequest ingest_binlog_request);
}
