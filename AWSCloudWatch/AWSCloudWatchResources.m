//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSCloudWatchResources.h"
#import <AWSCore/AWSLogging.h>

@interface AWSCloudWatchResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSCloudWatchResources

+ (instancetype)sharedInstance {
    static AWSCloudWatchResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSCloudWatchResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2010-08-01\",\
    \"endpointPrefix\":\"monitoring\",\
    \"protocol\":\"query\",\
    \"serviceAbbreviation\":\"CloudWatch\",\
    \"serviceFullName\":\"Amazon CloudWatch\",\
    \"signatureVersion\":\"v4\",\
    \"xmlNamespace\":\"http://monitoring.amazonaws.com/doc/2010-08-01/\"\
  },\
  \"operations\":{\
    \"DeleteAlarms\":{\
      \"name\":\"DeleteAlarms\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DeleteAlarmsInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFound\"}\
      ],\
      \"documentation\":\"<p>Deletes all specified alarms. In the event of an error, no alarms are deleted.</p>\"\
    },\
    \"DescribeAlarmHistory\":{\
      \"name\":\"DescribeAlarmHistory\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeAlarmHistoryInput\"},\
      \"output\":{\
        \"shape\":\"DescribeAlarmHistoryOutput\",\
        \"resultWrapper\":\"DescribeAlarmHistoryResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidNextToken\"}\
      ],\
      \"documentation\":\"<p>Retrieves history for the specified alarm. Filter alarms by date range or item type. If an alarm name is not specified, Amazon CloudWatch returns histories for all of the owner's alarms.</p> <note> <p>Amazon CloudWatch retains the history of an alarm for two weeks, whether or not you delete the alarm.</p> </note>\"\
    },\
    \"DescribeAlarms\":{\
      \"name\":\"DescribeAlarms\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeAlarmsInput\"},\
      \"output\":{\
        \"shape\":\"DescribeAlarmsOutput\",\
        \"resultWrapper\":\"DescribeAlarmsResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidNextToken\"}\
      ],\
      \"documentation\":\"<p>Retrieves alarms with the specified names. If no name is specified, all alarms for the user are returned. Alarms can be retrieved by using only a prefix for the alarm name, the alarm state, or a prefix for any action.</p>\"\
    },\
    \"DescribeAlarmsForMetric\":{\
      \"name\":\"DescribeAlarmsForMetric\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DescribeAlarmsForMetricInput\"},\
      \"output\":{\
        \"shape\":\"DescribeAlarmsForMetricOutput\",\
        \"resultWrapper\":\"DescribeAlarmsForMetricResult\"\
      },\
      \"documentation\":\"<p>Retrieves all alarms for a single metric. Specify a statistic, period, or unit to filter the set of alarms further.</p>\"\
    },\
    \"DisableAlarmActions\":{\
      \"name\":\"DisableAlarmActions\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"DisableAlarmActionsInput\"},\
      \"documentation\":\"<p>Disables actions for the specified alarms. When an alarm's actions are disabled the alarm's state may change, but none of the alarm's actions will execute.</p>\"\
    },\
    \"EnableAlarmActions\":{\
      \"name\":\"EnableAlarmActions\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"EnableAlarmActionsInput\"},\
      \"documentation\":\"<p>Enables actions for the specified alarms.</p>\"\
    },\
    \"GetMetricStatistics\":{\
      \"name\":\"GetMetricStatistics\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"GetMetricStatisticsInput\"},\
      \"output\":{\
        \"shape\":\"GetMetricStatisticsOutput\",\
        \"resultWrapper\":\"GetMetricStatisticsResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InvalidParameterValueException\"},\
        {\"shape\":\"MissingRequiredParameterException\"},\
        {\"shape\":\"InvalidParameterCombinationException\"},\
        {\"shape\":\"InternalServiceFault\"}\
      ],\
      \"documentation\":\"<p>Gets statistics for the specified metric.</p> <p> The maximum number of data points that can be queried is 50,850, whereas the maximum number of data points returned from a single <code>GetMetricStatistics</code> request is 1,440. If you make a request that generates more than 1,440 data points, Amazon CloudWatch returns an error. In such a case, you can alter the request by narrowing the specified time range or increasing the specified period. A period can be as short as one minute (60 seconds) or as long as one day (86,400 seconds). Alternatively, you can make multiple requests across adjacent time ranges. <code>GetMetricStatistics</code> does not return the data in chronological order. </p> <p> Amazon CloudWatch aggregates data points based on the length of the <code>period</code> that you specify. For example, if you request statistics with a one-minute granularity, Amazon CloudWatch aggregates data points with time stamps that fall within the same one-minute period. In such a case, the data points queried can greatly outnumber the data points returned. </p> <p> The following examples show various statistics allowed by the data point query maximum of 50,850 when you call <code>GetMetricStatistics</code> on Amazon EC2 instances with detailed (one-minute) monitoring enabled: </p> <ul> <li> <p>Statistics for up to 400 instances for a span of one hour</p> </li> <li> <p>Statistics for up to 35 instances over a span of 24 hours</p> </li> <li> <p>Statistics for up to 2 instances over a span of 2 weeks</p> </li> </ul> <p> For information about the namespace, metric names, and dimensions that other Amazon Web Services products use to send metrics to CloudWatch, go to <a href=\\\"http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/CW_Support_For_AWS.html\\\">Amazon CloudWatch Metrics, Namespaces, and Dimensions Reference</a> in the <i>Amazon CloudWatch Developer Guide</i>. </p>\"\
    },\
    \"ListMetrics\":{\
      \"name\":\"ListMetrics\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"ListMetricsInput\"},\
      \"output\":{\
        \"shape\":\"ListMetricsOutput\",\
        \"resultWrapper\":\"ListMetricsResult\"\
      },\
      \"errors\":[\
        {\"shape\":\"InternalServiceFault\"},\
        {\"shape\":\"InvalidParameterValueException\"}\
      ],\
      \"documentation\":\"<p> Returns a list of valid metrics stored for the AWS account owner. Returned metrics can be used with <a>GetMetricStatistics</a> to obtain statistical data for a given metric. </p> <note> <p> Up to 500 results are returned for any one call. To retrieve further results, use returned <code>NextToken</code> values with subsequent <code>ListMetrics</code> operations.</p> </note> <note> <p> If you create a metric with <a>PutMetricData</a>, allow up to fifteen minutes for the metric to appear in calls to <code>ListMetrics</code>. Statistics about the metric, however, are available sooner using <a>GetMetricStatistics</a>.</p> </note>\"\
    },\
    \"PutMetricAlarm\":{\
      \"name\":\"PutMetricAlarm\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutMetricAlarmInput\"},\
      \"errors\":[\
        {\"shape\":\"LimitExceededFault\"}\
      ],\
      \"documentation\":\"<p>Creates or updates an alarm and associates it with the specified Amazon CloudWatch metric. Optionally, this operation can associate one or more Amazon SNS resources with the alarm.</p> <p> When this operation creates an alarm, the alarm state is immediately set to <code>INSUFFICIENT_DATA</code>. The alarm is evaluated and its <code>StateValue</code> is set appropriately. Any actions associated with the <code>StateValue</code> are then executed. </p> <note> <p>When updating an existing alarm, its <code>StateValue</code> is left unchanged, but it completely overwrites the alarm's previous configuration.</p> </note> <note> <p>If you are using an AWS Identity and Access Management (IAM) account to create or modify an alarm, you must have the following Amazon EC2 permissions:</p> <ul> <li> <p> <code>ec2:DescribeInstanceStatus</code> and <code>ec2:DescribeInstances</code> for all alarms on Amazon EC2 instance status metrics.</p> </li> <li> <p> <code>ec2:StopInstances</code> for alarms with stop actions.</p> </li> <li> <p> <code>ec2:TerminateInstances</code> for alarms with terminate actions.</p> </li> <li> <p> <code>ec2:DescribeInstanceRecoveryAttribute</code>, and <code>ec2:RecoverInstances</code> for alarms with recover actions.</p> </li> </ul> <p>If you have read/write permissions for Amazon CloudWatch but not for Amazon EC2, you can still create an alarm but the stop or terminate actions won't be performed on the Amazon EC2 instance. However, if you are later granted permission to use the associated Amazon EC2 APIs, the alarm actions you created earlier will be performed. For more information about IAM permissions, see <a href=\\\"http://docs.aws.amazon.com/IAM/latest/UserGuide/PermissionsAndPolicies.html\\\">Permissions and Policies</a> in <i>Using IAM</i>.</p> <p>If you are using an IAM role (e.g., an Amazon EC2 instance profile), you cannot stop or terminate the instance using alarm actions. However, you can still see the alarm state and perform any other actions such as Amazon SNS notifications or Auto Scaling policies.</p> <p>If you are using temporary security credentials granted using the AWS Security Token Service (AWS STS), you cannot stop or terminate an Amazon EC2 instance using alarm actions.</p> </note>\"\
    },\
    \"PutMetricData\":{\
      \"name\":\"PutMetricData\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"PutMetricDataInput\"},\
      \"errors\":[\
        {\"shape\":\"InvalidParameterValueException\"},\
        {\"shape\":\"MissingRequiredParameterException\"},\
        {\"shape\":\"InvalidParameterCombinationException\"},\
        {\"shape\":\"InternalServiceFault\"}\
      ],\
      \"documentation\":\"<p> Publishes metric data points to Amazon CloudWatch. Amazon CloudWatch associates the data points with the specified metric. If the specified metric does not exist, Amazon CloudWatch creates the metric. When Amazon CloudWatch creates a metric, it can take up to fifteen minutes for the metric to appear in calls to <a>ListMetrics</a>. </p> <p> Each <code>PutMetricData</code> request is limited to 8 KB in size for HTTP GET requests and is limited to 40 KB in size for HTTP POST requests. </p> <important> <p>Although the <code>Value</code> parameter accepts numbers of type <code>Double</code>, Amazon CloudWatch rejects values that are either too small or too large. Values must be in the range of 8.515920e-109 to 1.174271e+108 (Base 10) or 2e-360 to 2e360 (Base 2). In addition, special values (e.g., NaN, +Infinity, -Infinity) are not supported.</p> </important> <p>Data that is timestamped 24 hours or more in the past may take in excess of 48 hours to become available from submission time using <code>GetMetricStatistics</code>.</p>\"\
    },\
    \"SetAlarmState\":{\
      \"name\":\"SetAlarmState\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/\"\
      },\
      \"input\":{\"shape\":\"SetAlarmStateInput\"},\
      \"errors\":[\
        {\"shape\":\"ResourceNotFound\"},\
        {\"shape\":\"InvalidFormatFault\"}\
      ],\
      \"documentation\":\"<p> Temporarily sets the state of an alarm for testing purposes. When the updated <code>StateValue</code> differs from the previous value, the action configured for the appropriate state is invoked. For example, if your alarm is configured to send an Amazon SNS message when an alarm is triggered, temporarily changing the alarm's state to <b>ALARM</b> sends an Amazon SNS message. The alarm returns to its actual state (often within seconds). Because the alarm state change happens very quickly, it is typically only visible in the alarm's <b>History</b> tab in the Amazon CloudWatch console or through <code>DescribeAlarmHistory</code>. </p>\"\
    }\
  },\
  \"shapes\":{\
    \"ActionPrefix\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":1\
    },\
    \"ActionsEnabled\":{\"type\":\"boolean\"},\
    \"AlarmArn\":{\
      \"type\":\"string\",\
      \"max\":1600,\
      \"min\":1\
    },\
    \"AlarmDescription\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":0\
    },\
    \"AlarmHistoryItem\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AlarmName\":{\
          \"shape\":\"AlarmName\",\
          \"documentation\":\"<p>The descriptive name for the alarm.</p>\"\
        },\
        \"Timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp for the alarm history item.</p>\"\
        },\
        \"HistoryItemType\":{\
          \"shape\":\"HistoryItemType\",\
          \"documentation\":\"<p>The type of alarm history item.</p>\"\
        },\
        \"HistorySummary\":{\
          \"shape\":\"HistorySummary\",\
          \"documentation\":\"<p>A human-readable summary of the alarm history.</p>\"\
        },\
        \"HistoryData\":{\
          \"shape\":\"HistoryData\",\
          \"documentation\":\"<p>Machine-readable data about the alarm in JSON format.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>AlarmHistoryItem</code> data type contains descriptive information about the history of a specific alarm. If you call <a>DescribeAlarmHistory</a>, Amazon CloudWatch returns this data type as part of the DescribeAlarmHistoryResult data type. </p>\"\
    },\
    \"AlarmHistoryItems\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AlarmHistoryItem\"}\
    },\
    \"AlarmName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"AlarmNamePrefix\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"AlarmNames\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"AlarmName\"},\
      \"max\":100\
    },\
    \"AwsQueryErrorMessage\":{\"type\":\"string\"},\
    \"ComparisonOperator\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"GreaterThanOrEqualToThreshold\",\
        \"GreaterThanThreshold\",\
        \"LessThanThreshold\",\
        \"LessThanOrEqualToThreshold\"\
      ]\
    },\
    \"Datapoint\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp used for the datapoint.</p>\"\
        },\
        \"SampleCount\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The number of metric values that contributed to the aggregate value of this datapoint.</p>\"\
        },\
        \"Average\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The average of metric values that correspond to the datapoint.</p>\"\
        },\
        \"Sum\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The sum of metric values used for the datapoint.</p>\"\
        },\
        \"Minimum\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The minimum metric value used for the datapoint.</p>\"\
        },\
        \"Maximum\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The maximum of the metric value used for the datapoint.</p>\"\
        },\
        \"Unit\":{\
          \"shape\":\"StandardUnit\",\
          \"documentation\":\"<p>The standard unit used for the datapoint.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>Datapoint</code> data type encapsulates the statistical data that Amazon CloudWatch computes from metric data. </p>\",\
      \"xmlOrder\":[\
        \"Timestamp\",\
        \"SampleCount\",\
        \"Average\",\
        \"Sum\",\
        \"Minimum\",\
        \"Maximum\",\
        \"Unit\"\
      ]\
    },\
    \"DatapointValue\":{\"type\":\"double\"},\
    \"Datapoints\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Datapoint\"}\
    },\
    \"DeleteAlarmsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"AlarmNames\"],\
      \"members\":{\
        \"AlarmNames\":{\
          \"shape\":\"AlarmNames\",\
          \"documentation\":\"<p>A list of alarms to be deleted.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for DeleteAlarms.</p>\"\
    },\
    \"DescribeAlarmHistoryInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AlarmName\":{\
          \"shape\":\"AlarmName\",\
          \"documentation\":\"<p>The name of the alarm.</p>\"\
        },\
        \"HistoryItemType\":{\
          \"shape\":\"HistoryItemType\",\
          \"documentation\":\"<p>The type of alarm histories to retrieve.</p>\"\
        },\
        \"StartDate\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The starting date to retrieve alarm history.</p>\"\
        },\
        \"EndDate\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The ending date to retrieve alarm history.</p>\"\
        },\
        \"MaxRecords\":{\
          \"shape\":\"MaxRecords\",\
          \"documentation\":\"<p>The maximum number of alarm history records to retrieve.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token returned by a previous call to indicate that there is more data available.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for DescribeAlarmHistory.</p>\"\
    },\
    \"DescribeAlarmHistoryOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AlarmHistoryItems\":{\
          \"shape\":\"AlarmHistoryItems\",\
          \"documentation\":\"<p>A list of alarm histories in JSON format.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>A string that marks the start of the next batch of returned results.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The output for <a>DescribeAlarmHistory</a>. </p>\"\
    },\
    \"DescribeAlarmsForMetricInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"MetricName\",\
        \"Namespace\"\
      ],\
      \"members\":{\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the metric.</p>\"\
        },\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace of the metric.</p>\"\
        },\
        \"Statistic\":{\
          \"shape\":\"Statistic\",\
          \"documentation\":\"<p>The statistic for the metric.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"Dimensions\",\
          \"documentation\":\"<p>The list of dimensions associated with the metric. If the metric has any associated dimensions, you must specify them in order for the DescribeAlarmsForMetric to succeed.</p>\"\
        },\
        \"Period\":{\
          \"shape\":\"Period\",\
          \"documentation\":\"<p>The period in seconds over which the statistic is applied.</p>\"\
        },\
        \"Unit\":{\
          \"shape\":\"StandardUnit\",\
          \"documentation\":\"<p>The unit for the metric.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for DescribeAlarmsForMetric.</p>\"\
    },\
    \"DescribeAlarmsForMetricOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MetricAlarms\":{\
          \"shape\":\"MetricAlarms\",\
          \"documentation\":\"<p>A list of information for each alarm with the specified metric.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The output for <a>DescribeAlarmsForMetric</a>. </p>\"\
    },\
    \"DescribeAlarmsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AlarmNames\":{\
          \"shape\":\"AlarmNames\",\
          \"documentation\":\"<p>A list of alarm names to retrieve information for.</p>\"\
        },\
        \"AlarmNamePrefix\":{\
          \"shape\":\"AlarmNamePrefix\",\
          \"documentation\":\"<p>The alarm name prefix. <code>AlarmNames</code> cannot be specified if this parameter is specified.</p>\"\
        },\
        \"StateValue\":{\
          \"shape\":\"StateValue\",\
          \"documentation\":\"<p>The state value to be used in matching alarms.</p>\"\
        },\
        \"ActionPrefix\":{\
          \"shape\":\"ActionPrefix\",\
          \"documentation\":\"<p>The action name prefix.</p>\"\
        },\
        \"MaxRecords\":{\
          \"shape\":\"MaxRecords\",\
          \"documentation\":\"<p>The maximum number of alarm descriptions to retrieve.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token returned by a previous call to indicate that there is more data available.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for DescribeAlarms.</p>\"\
    },\
    \"DescribeAlarmsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"MetricAlarms\":{\
          \"shape\":\"MetricAlarms\",\
          \"documentation\":\"<p>A list of information for the specified alarms.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>A string that marks the start of the next batch of returned results.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The output for <a>DescribeAlarms</a>.</p>\"\
    },\
    \"Dimension\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Name\",\
        \"Value\"\
      ],\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"DimensionName\",\
          \"documentation\":\"<p>The name of the dimension.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"DimensionValue\",\
          \"documentation\":\"<p>The value representing the dimension measurement</p>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>Dimension</code> data type further expands on the identity of a metric using a Name, Value pair. </p> <p>For examples that use one or more dimensions, see <a>PutMetricData</a>.</p>\",\
      \"xmlOrder\":[\
        \"Name\",\
        \"Value\"\
      ]\
    },\
    \"DimensionFilter\":{\
      \"type\":\"structure\",\
      \"required\":[\"Name\"],\
      \"members\":{\
        \"Name\":{\
          \"shape\":\"DimensionName\",\
          \"documentation\":\"<p>The dimension name to be matched.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"DimensionValue\",\
          \"documentation\":\"<p>The value of the dimension to be matched.</p> <note> <p>Specifying a <code>Name</code> without specifying a <code>Value</code> returns all values associated with that <code>Name</code>.</p> </note>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>DimensionFilter</code> data type is used to filter <a>ListMetrics</a> results. </p>\"\
    },\
    \"DimensionFilters\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"DimensionFilter\"},\
      \"max\":10\
    },\
    \"DimensionName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"DimensionValue\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"Dimensions\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Dimension\"},\
      \"max\":10\
    },\
    \"DisableAlarmActionsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"AlarmNames\"],\
      \"members\":{\
        \"AlarmNames\":{\
          \"shape\":\"AlarmNames\",\
          \"documentation\":\"<p>The names of the alarms to disable actions for.</p>\"\
        }\
      },\
      \"documentation\":\"<p/>\"\
    },\
    \"EnableAlarmActionsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\"AlarmNames\"],\
      \"members\":{\
        \"AlarmNames\":{\
          \"shape\":\"AlarmNames\",\
          \"documentation\":\"<p>The names of the alarms to enable actions for.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for EnableAlarmActions.</p>\"\
    },\
    \"ErrorMessage\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"EvaluationPeriods\":{\
      \"type\":\"integer\",\
      \"min\":1\
    },\
    \"FaultDescription\":{\"type\":\"string\"},\
    \"GetMetricStatisticsInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Namespace\",\
        \"MetricName\",\
        \"StartTime\",\
        \"EndTime\",\
        \"Period\",\
        \"Statistics\"\
      ],\
      \"members\":{\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace of the metric, with or without spaces.</p>\"\
        },\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the metric, with or without spaces.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"Dimensions\",\
          \"documentation\":\"<p>A list of dimensions describing qualities of the metric.</p>\"\
        },\
        \"StartTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp to use for determining the first datapoint to return. The value specified is inclusive; results include datapoints with the time stamp specified. The time stamp must be in ISO 8601 UTC format (e.g., 2014-09-03T23:00:00Z).</p> <note> <p>The specified start time is rounded down to the nearest value. Datapoints are returned for start times up to two weeks in the past. Specified start times that are more than two weeks in the past will not return datapoints for metrics that are older than two weeks.</p> <p>Data that is timestamped 24 hours or more in the past may take in excess of 48 hours to become available from submission time using <code>GetMetricStatistics</code>.</p> </note>\"\
        },\
        \"EndTime\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp to use for determining the last datapoint to return. The value specified is exclusive; results will include datapoints up to the time stamp specified. The time stamp must be in ISO 8601 UTC format (e.g., 2014-09-03T23:00:00Z).</p>\"\
        },\
        \"Period\":{\
          \"shape\":\"Period\",\
          \"documentation\":\"<p> The granularity, in seconds, of the returned datapoints. A <code>Period</code> can be as short as one minute (60 seconds) or as long as one day (86,400 seconds), and must be a multiple of 60. The default value is 60. </p>\"\
        },\
        \"Statistics\":{\
          \"shape\":\"Statistics\",\
          \"documentation\":\"<p> The metric statistics to return. For information about specific statistics returned by GetMetricStatistics, see <a href=\\\"http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/cloudwatch_concepts.html#Statistic\\\">Statistics</a> in the <i>Amazon CloudWatch Developer Guide</i>. </p>\"\
        },\
        \"Unit\":{\
          \"shape\":\"StandardUnit\",\
          \"documentation\":\"<p>The specific unit for a given metric. Metrics may be reported in multiple units. Not supplying a unit results in all units being returned. If the metric only ever reports one unit, specifying a unit will have no effect.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for GetMetricStatistics.</p>\"\
    },\
    \"GetMetricStatisticsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Label\":{\
          \"shape\":\"MetricLabel\",\
          \"documentation\":\"<p>A label describing the specified metric.</p>\"\
        },\
        \"Datapoints\":{\
          \"shape\":\"Datapoints\",\
          \"documentation\":\"<p>The datapoints for the specified metric.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The output for <a>GetMetricStatistics</a>. </p>\"\
    },\
    \"HistoryData\":{\
      \"type\":\"string\",\
      \"max\":4095,\
      \"min\":1\
    },\
    \"HistoryItemType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ConfigurationUpdate\",\
        \"StateUpdate\",\
        \"Action\"\
      ]\
    },\
    \"HistorySummary\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"InternalServiceFault\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\
          \"shape\":\"FaultDescription\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>Indicates that the request processing has failed due to some unknown error, exception, or failure.</p>\",\
      \"error\":{\
        \"code\":\"InternalServiceError\",\
        \"httpStatusCode\":500\
      },\
      \"exception\":true,\
      \"xmlOrder\":[\"Message\"]\
    },\
    \"InvalidFormatFault\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>Data was not syntactically valid JSON.</p>\",\
      \"error\":{\
        \"code\":\"InvalidFormat\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidNextToken\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>The next token specified is invalid.</p>\",\
      \"error\":{\
        \"code\":\"InvalidNextToken\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidParameterCombinationException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"AwsQueryErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>Parameters that must not be used together were used together.</p>\",\
      \"error\":{\
        \"code\":\"InvalidParameterCombination\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"InvalidParameterValueException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"AwsQueryErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>Bad or out-of-range value was supplied for the input parameter.</p>\",\
      \"error\":{\
        \"code\":\"InvalidParameterValue\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"LimitExceededFault\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>The quota for alarms for this customer has already been reached.</p>\",\
      \"error\":{\
        \"code\":\"LimitExceeded\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"ListMetricsInput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace to filter against.</p>\"\
        },\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the metric to filter against.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"DimensionFilters\",\
          \"documentation\":\"<p>A list of dimensions to filter against.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>The token returned by a previous call to indicate that there is more data available.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for ListMetrics.</p>\"\
    },\
    \"ListMetricsOutput\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Metrics\":{\
          \"shape\":\"Metrics\",\
          \"documentation\":\"<p>A list of metrics used to generate statistics for an AWS account.</p>\"\
        },\
        \"NextToken\":{\
          \"shape\":\"NextToken\",\
          \"documentation\":\"<p>A string that marks the start of the next batch of returned results.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The output for <a>ListMetrics</a>. </p>\",\
      \"xmlOrder\":[\
        \"Metrics\",\
        \"NextToken\"\
      ]\
    },\
    \"MaxRecords\":{\
      \"type\":\"integer\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"Metric\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace of the metric.</p>\"\
        },\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the metric.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"Dimensions\",\
          \"documentation\":\"<p>A list of dimensions associated with the metric.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>Metric</code> data type contains information about a specific metric. If you call <a>ListMetrics</a>, Amazon CloudWatch returns information contained by this data type. </p> <p>The example in the Examples section publishes two metrics named buffers and latency. Both metrics are in the examples namespace. Both metrics have two dimensions, InstanceID and InstanceType.</p>\",\
      \"xmlOrder\":[\
        \"Namespace\",\
        \"MetricName\",\
        \"Dimensions\"\
      ]\
    },\
    \"MetricAlarm\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"AlarmName\":{\
          \"shape\":\"AlarmName\",\
          \"documentation\":\"<p>The name of the alarm.</p>\"\
        },\
        \"AlarmArn\":{\
          \"shape\":\"AlarmArn\",\
          \"documentation\":\"<p>The Amazon Resource Name (ARN) of the alarm.</p>\"\
        },\
        \"AlarmDescription\":{\
          \"shape\":\"AlarmDescription\",\
          \"documentation\":\"<p>The description for the alarm.</p>\"\
        },\
        \"AlarmConfigurationUpdatedTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp of the last update to the alarm configuration.</p>\"\
        },\
        \"ActionsEnabled\":{\
          \"shape\":\"ActionsEnabled\",\
          \"documentation\":\"<p>Indicates whether actions should be executed during any changes to the alarm's state.</p>\"\
        },\
        \"OKActions\":{\
          \"shape\":\"ResourceList\",\
          \"documentation\":\"<p> The list of actions to execute when this alarm transitions into an <code>OK</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN). </p>\"\
        },\
        \"AlarmActions\":{\
          \"shape\":\"ResourceList\",\
          \"documentation\":\"<p> The list of actions to execute when this alarm transitions into an <code>ALARM</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN). </p>\"\
        },\
        \"InsufficientDataActions\":{\
          \"shape\":\"ResourceList\",\
          \"documentation\":\"<p> The list of actions to execute when this alarm transitions into an <code>INSUFFICIENT_DATA</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN). </p> <important> <p>The current WSDL lists this attribute as <code>UnknownActions</code>.</p> </important>\"\
        },\
        \"StateValue\":{\
          \"shape\":\"StateValue\",\
          \"documentation\":\"<p>The state value for the alarm.</p>\"\
        },\
        \"StateReason\":{\
          \"shape\":\"StateReason\",\
          \"documentation\":\"<p>A human-readable explanation for the alarm's state.</p>\"\
        },\
        \"StateReasonData\":{\
          \"shape\":\"StateReasonData\",\
          \"documentation\":\"<p>An explanation for the alarm's state in machine-readable JSON format</p>\"\
        },\
        \"StateUpdatedTimestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp of the last update to the alarm's state.</p>\"\
        },\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the alarm's metric.</p>\"\
        },\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace of alarm's associated metric.</p>\"\
        },\
        \"Statistic\":{\
          \"shape\":\"Statistic\",\
          \"documentation\":\"<p>The statistic to apply to the alarm's associated metric.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"Dimensions\",\
          \"documentation\":\"<p>The list of dimensions associated with the alarm's associated metric.</p>\"\
        },\
        \"Period\":{\
          \"shape\":\"Period\",\
          \"documentation\":\"<p>The period in seconds over which the statistic is applied.</p>\"\
        },\
        \"Unit\":{\
          \"shape\":\"StandardUnit\",\
          \"documentation\":\"<p>The unit of the alarm's associated metric.</p>\"\
        },\
        \"EvaluationPeriods\":{\
          \"shape\":\"EvaluationPeriods\",\
          \"documentation\":\"<p>The number of periods over which data is compared to the specified threshold.</p>\"\
        },\
        \"Threshold\":{\
          \"shape\":\"Threshold\",\
          \"documentation\":\"<p>The value against which the specified statistic is compared.</p>\"\
        },\
        \"ComparisonOperator\":{\
          \"shape\":\"ComparisonOperator\",\
          \"documentation\":\"<p> The arithmetic operation to use when comparing the specified <code>Statistic</code> and <code>Threshold</code>. The specified <code>Statistic</code> value is used as the first operand. </p>\"\
        }\
      },\
      \"documentation\":\"<p> The <a>MetricAlarm</a> data type represents an alarm. You can use <a>PutMetricAlarm</a> to create or update an alarm. </p>\",\
      \"xmlOrder\":[\
        \"AlarmName\",\
        \"AlarmArn\",\
        \"AlarmDescription\",\
        \"AlarmConfigurationUpdatedTimestamp\",\
        \"ActionsEnabled\",\
        \"OKActions\",\
        \"AlarmActions\",\
        \"InsufficientDataActions\",\
        \"StateValue\",\
        \"StateReason\",\
        \"StateReasonData\",\
        \"StateUpdatedTimestamp\",\
        \"MetricName\",\
        \"Namespace\",\
        \"Statistic\",\
        \"Dimensions\",\
        \"Period\",\
        \"Unit\",\
        \"EvaluationPeriods\",\
        \"Threshold\",\
        \"ComparisonOperator\"\
      ]\
    },\
    \"MetricAlarms\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricAlarm\"}\
    },\
    \"MetricData\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"MetricDatum\"}\
    },\
    \"MetricDatum\":{\
      \"type\":\"structure\",\
      \"required\":[\"MetricName\"],\
      \"members\":{\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name of the metric.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"Dimensions\",\
          \"documentation\":\"<p>A list of dimensions associated with the metric. Note, when using the Dimensions value in a query, you need to append .member.N to it (e.g., Dimensions.member.N).</p>\"\
        },\
        \"Timestamp\":{\
          \"shape\":\"Timestamp\",\
          \"documentation\":\"<p>The time stamp used for the metric in ISO 8601 Universal Coordinated Time (UTC) format. If not specified, the default value is set to the time the metric data was received.</p>\"\
        },\
        \"Value\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The value for the metric.</p> <important> <p>Although the <code>Value</code> parameter accepts numbers of type <code>Double</code>, Amazon CloudWatch rejects values that are either too small or too large. Values must be in the range of 8.515920e-109 to 1.174271e+108 (Base 10) or 2e-360 to 2e360 (Base 2). In addition, special values (e.g., NaN, +Infinity, -Infinity) are not supported.</p> </important>\"\
        },\
        \"StatisticValues\":{\
          \"shape\":\"StatisticSet\",\
          \"documentation\":\"<p>A set of statistical values describing the metric.</p>\"\
        },\
        \"Unit\":{\
          \"shape\":\"StandardUnit\",\
          \"documentation\":\"<p>The unit of the metric.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>MetricDatum</code> data type encapsulates the information sent with <a>PutMetricData</a> to either create a new metric or add new values to be aggregated into an existing metric. </p>\"\
    },\
    \"MetricLabel\":{\"type\":\"string\"},\
    \"MetricName\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1\
    },\
    \"Metrics\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Metric\"}\
    },\
    \"MissingRequiredParameterException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"AwsQueryErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>An input parameter that is mandatory for processing the request is not supplied.</p>\",\
      \"error\":{\
        \"code\":\"MissingParameter\",\
        \"httpStatusCode\":400,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"Namespace\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1,\
      \"pattern\":\"[^:].*\"\
    },\
    \"NextToken\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":0\
    },\
    \"Period\":{\
      \"type\":\"integer\",\
      \"min\":60\
    },\
    \"PutMetricAlarmInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AlarmName\",\
        \"MetricName\",\
        \"Namespace\",\
        \"Statistic\",\
        \"Period\",\
        \"EvaluationPeriods\",\
        \"Threshold\",\
        \"ComparisonOperator\"\
      ],\
      \"members\":{\
        \"AlarmName\":{\
          \"shape\":\"AlarmName\",\
          \"documentation\":\"<p>The descriptive name for the alarm. This name must be unique within the user's AWS account</p>\"\
        },\
        \"AlarmDescription\":{\
          \"shape\":\"AlarmDescription\",\
          \"documentation\":\"<p>The description for the alarm.</p>\"\
        },\
        \"ActionsEnabled\":{\
          \"shape\":\"ActionsEnabled\",\
          \"documentation\":\"<p>Indicates whether or not actions should be executed during any changes to the alarm's state.</p>\"\
        },\
        \"OKActions\":{\
          \"shape\":\"ResourceList\",\
          \"documentation\":\"<p> The list of actions to execute when this alarm transitions into an <code>OK</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN). </p> <p>Valid Values: arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:stop | arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:terminate | arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:recover</p> <p>Valid Values (for use with IAM roles): arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Stop/1.0 | arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Terminate/1.0 | arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Reboot/1.0</p> <p> <b>Note:</b> You must create at least one stop, terminate, or reboot alarm using the Amazon EC2 or CloudWatch console to create the <b>EC2ActionsAccess</b> IAM role for the first time. After this IAM role is created, you can create stop, terminate, or reboot alarms using the CLI.</p>\"\
        },\
        \"AlarmActions\":{\
          \"shape\":\"ResourceList\",\
          \"documentation\":\"<p> The list of actions to execute when this alarm transitions into an <code>ALARM</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN). </p> <p>Valid Values: arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:stop | arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:terminate | arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:recover</p> <p>Valid Values (for use with IAM roles): arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Stop/1.0 | arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Terminate/1.0 | arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Reboot/1.0</p> <p> <b>Note:</b> You must create at least one stop, terminate, or reboot alarm using the Amazon EC2 or CloudWatch console to create the <b>EC2ActionsAccess</b> IAM role for the first time. After this IAM role is created, you can create stop, terminate, or reboot alarms using the CLI.</p>\"\
        },\
        \"InsufficientDataActions\":{\
          \"shape\":\"ResourceList\",\
          \"documentation\":\"<p> The list of actions to execute when this alarm transitions into an <code>INSUFFICIENT_DATA</code> state from any other state. Each action is specified as an Amazon Resource Name (ARN). </p> <p>Valid Values: arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:stop | arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:terminate | arn:aws:automate:<i>region (e.g., us-east-1)</i>:ec2:recover</p> <p>Valid Values (for use with IAM roles): arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Stop/1.0 | arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Terminate/1.0 | arn:aws:swf:us-east-1:{<i>customer-account</i>}:action/actions/AWS_EC2.InstanceId.Reboot/1.0</p> <p> <b>Note:</b> You must create at least one stop, terminate, or reboot alarm using the Amazon EC2 or CloudWatch console to create the <b>EC2ActionsAccess</b> IAM role for the first time. After this IAM role is created, you can create stop, terminate, or reboot alarms using the CLI.</p>\"\
        },\
        \"MetricName\":{\
          \"shape\":\"MetricName\",\
          \"documentation\":\"<p>The name for the alarm's associated metric.</p>\"\
        },\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace for the alarm's associated metric.</p>\"\
        },\
        \"Statistic\":{\
          \"shape\":\"Statistic\",\
          \"documentation\":\"<p>The statistic to apply to the alarm's associated metric.</p>\"\
        },\
        \"Dimensions\":{\
          \"shape\":\"Dimensions\",\
          \"documentation\":\"<p>The dimensions for the alarm's associated metric.</p>\"\
        },\
        \"Period\":{\
          \"shape\":\"Period\",\
          \"documentation\":\"<p>The period in seconds over which the specified statistic is applied.</p>\"\
        },\
        \"Unit\":{\
          \"shape\":\"StandardUnit\",\
          \"documentation\":\"<p>The statistic's unit of measure. For example, the units for the Amazon EC2 NetworkIn metric are Bytes because NetworkIn tracks the number of bytes that an instance receives on all network interfaces. You can also specify a unit when you create a custom metric. Units help provide conceptual meaning to your data. Metric data points that specify a unit of measure, such as Percent, are aggregated separately.</p> <p> <b>Note:</b> If you specify a unit, you must use a unit that is appropriate for the metric. Otherwise, this can cause an Amazon CloudWatch alarm to get stuck in the INSUFFICIENT DATA state. </p>\"\
        },\
        \"EvaluationPeriods\":{\
          \"shape\":\"EvaluationPeriods\",\
          \"documentation\":\"<p>The number of periods over which data is compared to the specified threshold.</p>\"\
        },\
        \"Threshold\":{\
          \"shape\":\"Threshold\",\
          \"documentation\":\"<p>The value against which the specified statistic is compared.</p>\"\
        },\
        \"ComparisonOperator\":{\
          \"shape\":\"ComparisonOperator\",\
          \"documentation\":\"<p> The arithmetic operation to use when comparing the specified <code>Statistic</code> and <code>Threshold</code>. The specified <code>Statistic</code> value is used as the first operand. </p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for PutMetricAlarm.</p>\"\
    },\
    \"PutMetricDataInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"Namespace\",\
        \"MetricData\"\
      ],\
      \"members\":{\
        \"Namespace\":{\
          \"shape\":\"Namespace\",\
          \"documentation\":\"<p>The namespace for the metric data.</p> <note> <p>You cannot specify a namespace that begins with \\\"AWS/\\\". Namespaces that begin with \\\"AWS/\\\" are reserved for other Amazon Web Services products that send metrics to Amazon CloudWatch.</p> </note>\"\
        },\
        \"MetricData\":{\
          \"shape\":\"MetricData\",\
          \"documentation\":\"<p>A list of data describing the metric.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for PutMetricData.</p>\"\
    },\
    \"ResourceList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ResourceName\"},\
      \"max\":5\
    },\
    \"ResourceName\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":1\
    },\
    \"ResourceNotFound\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\
          \"shape\":\"ErrorMessage\",\
          \"documentation\":\"<p/>\"\
        }\
      },\
      \"documentation\":\"<p>The named resource does not exist.</p>\",\
      \"error\":{\
        \"code\":\"ResourceNotFound\",\
        \"httpStatusCode\":404,\
        \"senderFault\":true\
      },\
      \"exception\":true\
    },\
    \"SetAlarmStateInput\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"AlarmName\",\
        \"StateValue\",\
        \"StateReason\"\
      ],\
      \"members\":{\
        \"AlarmName\":{\
          \"shape\":\"AlarmName\",\
          \"documentation\":\"<p>The descriptive name for the alarm. This name must be unique within the user's AWS account. The maximum length is 255 characters.</p>\"\
        },\
        \"StateValue\":{\
          \"shape\":\"StateValue\",\
          \"documentation\":\"<p>The value of the state.</p>\"\
        },\
        \"StateReason\":{\
          \"shape\":\"StateReason\",\
          \"documentation\":\"<p>The reason that this alarm is set to this specific state (in human-readable text format)</p>\"\
        },\
        \"StateReasonData\":{\
          \"shape\":\"StateReasonData\",\
          \"documentation\":\"<p>The reason that this alarm is set to this specific state (in machine-readable JSON format)</p>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the inputs for SetAlarmState.</p>\"\
    },\
    \"StandardUnit\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Seconds\",\
        \"Microseconds\",\
        \"Milliseconds\",\
        \"Bytes\",\
        \"Kilobytes\",\
        \"Megabytes\",\
        \"Gigabytes\",\
        \"Terabytes\",\
        \"Bits\",\
        \"Kilobits\",\
        \"Megabits\",\
        \"Gigabits\",\
        \"Terabits\",\
        \"Percent\",\
        \"Count\",\
        \"Bytes/Second\",\
        \"Kilobytes/Second\",\
        \"Megabytes/Second\",\
        \"Gigabytes/Second\",\
        \"Terabytes/Second\",\
        \"Bits/Second\",\
        \"Kilobits/Second\",\
        \"Megabits/Second\",\
        \"Gigabits/Second\",\
        \"Terabits/Second\",\
        \"Count/Second\",\
        \"None\"\
      ]\
    },\
    \"StateReason\":{\
      \"type\":\"string\",\
      \"max\":1023,\
      \"min\":0\
    },\
    \"StateReasonData\":{\
      \"type\":\"string\",\
      \"max\":4000,\
      \"min\":0\
    },\
    \"StateValue\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"OK\",\
        \"ALARM\",\
        \"INSUFFICIENT_DATA\"\
      ]\
    },\
    \"Statistic\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"SampleCount\",\
        \"Average\",\
        \"Sum\",\
        \"Minimum\",\
        \"Maximum\"\
      ]\
    },\
    \"StatisticSet\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"SampleCount\",\
        \"Sum\",\
        \"Minimum\",\
        \"Maximum\"\
      ],\
      \"members\":{\
        \"SampleCount\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The number of samples used for the statistic set.</p>\"\
        },\
        \"Sum\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The sum of values for the sample set.</p>\"\
        },\
        \"Minimum\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The minimum value of the sample set.</p>\"\
        },\
        \"Maximum\":{\
          \"shape\":\"DatapointValue\",\
          \"documentation\":\"<p>The maximum value of the sample set.</p>\"\
        }\
      },\
      \"documentation\":\"<p> The <code>StatisticSet</code> data type describes the <code>StatisticValues</code> component of <a>MetricDatum</a>, and represents a set of statistics that describes a specific metric. </p>\"\
    },\
    \"Statistics\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Statistic\"},\
      \"max\":5,\
      \"min\":1\
    },\
    \"Threshold\":{\"type\":\"double\"},\
    \"Timestamp\":{\"type\":\"timestamp\"}\
  },\
  \"documentation\":\"<p>Amazon CloudWatch monitors your Amazon Web Services (AWS) resources and the applications you run on AWS in real-time. You can use CloudWatch to collect and track metrics, which are the variables you want to measure for your resources and applications.</p> <p>CloudWatch alarms send notifications or automatically make changes to the resources you are monitoring based on rules that you define. For example, you can monitor the CPU usage and disk reads and writes of your Amazon Elastic Compute Cloud (Amazon EC2) instances and then use this data to determine whether you should launch additional instances to handle increased load. You can also use this data to stop under-used instances to save money.</p> <p>In addition to monitoring the built-in metrics that come with AWS, you can monitor your own custom metrics. With CloudWatch, you gain system-wide visibility into resource utilization, application performance, and operational health.</p>\"\
}";
}

@end
