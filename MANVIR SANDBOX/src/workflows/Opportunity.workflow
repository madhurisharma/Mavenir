<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>BidApprovalEmailAM</fullName>
        <description>Bid Approval Email - AM</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BidApprovalRequest</template>
    </alerts>
    <alerts>
        <fullName>BidApprovalEmailAndyReed</fullName>
        <description>Bid Approval Email - Andy Reed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>andy.reed@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BidApprovalRequest</template>
    </alerts>
    <alerts>
        <fullName>BidApprovalEmailVChen</fullName>
        <description>Bid Approval Email - V Chen</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>vincent.chen@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BidApprovalRequest</template>
    </alerts>
    <alerts>
        <fullName>BidTemplateAMChannelManagerAReed</fullName>
        <description>Bid Template - AM &amp; Channel Manager = A Reed</description>
        <protected>false</protected>
        <recipients>
            <recipient>andy.reed@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BidApprovalRequest</template>
    </alerts>
    <alerts>
        <fullName>BidTemplateAMChannelManagerVChen</fullName>
        <description>Bid Template - AM &amp; Channel Manager = V Chen</description>
        <protected>false</protected>
        <recipients>
            <recipient>vincent.chen@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/BidApprovalRequest</template>
    </alerts>
    <alerts>
        <fullName>ChangeAlerttoProgramManagerATayler</fullName>
        <description>Change Alert to Program Manager - A Tayler</description>
        <protected>false</protected>
        <recipients>
            <recipient>andy.tayler@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PROGMGRChangeAlert</template>
    </alerts>
    <alerts>
        <fullName>Change_of_closed_booked_revenue</fullName>
        <description>Change of closed booked revenue</description>
        <protected>false</protected>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Revenue_change_after_close</template>
    </alerts>
    <alerts>
        <fullName>ExecnotificationofMajorWin</fullName>
        <description>Exec notification of Major Win</description>
        <protected>false</protected>
        <recipients>
            <recipient>AmericaExec</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>AsiaExec</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>AustraliaExec</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>EMEAExec</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>GlobalExecutives</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>trevor.hornby@airwidesolutions.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/MajorWinnotification</template>
    </alerts>
    <alerts>
        <fullName>NewEMEAOpportunityUnqualified</fullName>
        <description>New EMEA Opportunity - Unqualified</description>
        <protected>false</protected>
        <recipients>
            <recipient>paul.burton@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/NewEMEAOpportunityUnqualified</template>
    </alerts>
    <alerts>
        <fullName>NewEMEAOpportunityqualified</fullName>
        <description>New EMEA Opportunity (qualified)</description>
        <protected>false</protected>
        <recipients>
            <recipient>paul.burton@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/NewEMEAOpportunity</template>
    </alerts>
    <alerts>
        <fullName>NewGlobalWin</fullName>
        <description>New Global Win</description>
        <protected>false</protected>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/GlobalWinNotification</template>
    </alerts>
    <alerts>
        <fullName>New_Australia_booking</fullName>
        <ccEmails>eliza.budniak@mavenir.com</ccEmails>
        <description>New Australia booking</description>
        <protected>false</protected>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dave.brown@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/x99Notification</template>
    </alerts>
    <alerts>
        <fullName>NonStandardPaymentTermsNotification</fullName>
        <description>Non-Standard Payment Terms Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>nora.curtis@airwidesolutions.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Non_standard_Payment_Terms_Notification</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Close_Date_is_in_the_past</fullName>
        <description>Opportunity Close Date is in the past</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Close_Date_in_the_past</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_moved_out_of_current_quarter</fullName>
        <description>Opportunity moved out of current quarter</description>
        <protected>false</protected>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>paul.burton@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EMEA_Opportunity_moved_out_of_CFQ</template>
    </alerts>
    <alerts>
        <fullName>x99Notification</fullName>
        <ccEmails>SalesforceNewWin@mavenir.com</ccEmails>
        <description>99% Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>anand@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>andy.reed@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>barbara@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bj@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>brinda@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>carolyn.turner@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>clive.innes@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>crispin.swan@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fabien.delanaud@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mahesh@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>matthew.dunnett@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pardeep@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>paul.burton@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>priya.sukul@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sam@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>terry@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>veronique.dussault@mavenir.com.mp1</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/x99Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Completeupdatedto100</fullName>
        <field>Complete__c</field>
        <formula>1</formula>
        <name>%Complete updated to 100%</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ForecastCatUpdatetoClosed</fullName>
        <field>AWS_Forecast_Category__c</field>
        <literalValue>Closed</literalValue>
        <name>Forecast Cat - Update to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ForecastCatUpdatetoCommit</fullName>
        <field>AWS_Forecast_Category__c</field>
        <literalValue>Prime</literalValue>
        <name>Forecast Cat - Update to Prime</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ForecastCatUpdatetoOmitted</fullName>
        <field>AWS_Forecast_Category__c</field>
        <literalValue>Omitted</literalValue>
        <name>Forecast Cat - Update to Omitted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ForecastCatUpdatetoPipeline</fullName>
        <field>AWS_Forecast_Category__c</field>
        <literalValue>Pipeline</literalValue>
        <name>Forecast Cat - Update to Pipeline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ForecastCatUpdatetoStretch</fullName>
        <field>AWS_Forecast_Category__c</field>
        <literalValue>Stretch</literalValue>
        <name>Forecast Cat - Update to Stretch</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Loss_Date_to_today</fullName>
        <description>When Stage is set to Lost, update field with &quot;today&apos;s&quot; date</description>
        <field>Loss_Date__c</field>
        <formula>TODAY()</formula>
        <name>Loss Date to today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LostOrderChangeRecordTypetoLocked</fullName>
        <field>RecordTypeId</field>
        <lookupValue>LockedOpportunityRecordType</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Lost Order-Change Record Type to Locked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>POorContractSignedUpdated</fullName>
        <description>PO or Contract Signed field updated to &apos;Pending&apos; when Opp stage changed to 6.</description>
        <field>PO_or_Contract_Approved__c</field>
        <literalValue>Pending</literalValue>
        <name>PO or Contract Signed Updated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ProposalStatusupdatedtoCompleted</fullName>
        <field>Proposal_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Proposal Status updated to Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TruncateComments</fullName>
        <field>Truncated_Comments__c</field>
        <formula>LEFT(Comments__c, 120)</formula>
        <name>Truncate Comments</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateCMEmployeeIDforAReed</fullName>
        <field>CM_Employee_ID__c</field>
        <literalValue>SFX00076</literalValue>
        <name>Update CM Employee ID for A Reed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateCMEmployeeIDforSHall</fullName>
        <field>CM_Employee_ID__c</field>
        <literalValue>SFX00032</literalValue>
        <name>Update CM Employee ID for S Hall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdateCMEmployeeIDforVChen</fullName>
        <field>CM_Employee_ID__c</field>
        <literalValue>SFX00600T</literalValue>
        <name>Update CM Employee ID for V Chen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WinProcessStarted</fullName>
        <description>Opportunity Stage has gone to 7 task sent to Operation Manager to review the Win Process and move to Yes.</description>
        <field>Win_Processed__c</field>
        <literalValue>Pending</literalValue>
        <name>Win Process Started</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>%25Complete updated to 100%25</fullName>
        <actions>
            <name>Completeupdatedto100</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Proposal_Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>This rule updates the % Complete field when the Proposal Status field is set to Completed.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Australia opp at 99%25</fullName>
        <actions>
            <name>New_Australia_booking</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>6. ATP or PO Received</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Region__c</field>
            <operation>equals</operation>
            <value>Australia</value>
        </criteriaItems>
        <description>To alert Ops in Australia of a new booking</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Bid Template - Andy Reed Owner %26 Channel</fullName>
        <actions>
            <name>BidTemplateAMChannelManagerAReed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>A Reed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>A Reed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bid_Approval_Email_Template__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Bid Template - V Chen Owner %26 Channel</fullName>
        <actions>
            <name>BidTemplateAMChannelManagerVChen</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>V Chen</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>equals</operation>
            <value>V Chen</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bid_Approval_Email_Template__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Bid template - AM</fullName>
        <actions>
            <name>BidApprovalEmailAM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Bid_Approval_Email_Template__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>notEqual</operation>
            <value>A Reed,V Chen</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Bid template - AM %26 Andy Reed</fullName>
        <actions>
            <name>BidApprovalEmailAndyReed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Bid_Approval_Email_Template__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>A Reed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>notEqual</operation>
            <value>A Reed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Bid template - AM %26 V Chen</fullName>
        <actions>
            <name>BidApprovalEmailVChen</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Bid_Approval_Email_Template__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>V Chen</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>notEqual</operation>
            <value>V Chen</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Booked revenue change</fullName>
        <actions>
            <name>Change_of_closed_booked_revenue</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>The closed book value has been changed after the opportunity is set to stage 6</description>
        <formula>AND(PRIORVALUE(Amount) &lt;&gt; Amount, IsClosed)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Close Date past</fullName>
        <actions>
            <name>Opportunity_Close_Date_is_in_the_past</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CloseDate</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <description>Opportunity close date is in the past.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Opportunity.CloseDate</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Forecast Cat - Update to Closed</fullName>
        <actions>
            <name>ForecastCatUpdatetoClosed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>6. ATP or PO Received,7. Purchase Order Accepted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Forecast Cat - Update to Omitted</fullName>
        <actions>
            <name>ForecastCatUpdatetoOmitted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Lost Order,Quota</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Forecast Cat - Update to Pipeline</fullName>
        <actions>
            <name>ForecastCatUpdatetoPipeline</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>2. Believe Opp Exists,1. Suspect,3. Customer-Quote; Prospect-Shortlist</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Forecast Cat - Update to Prime</fullName>
        <actions>
            <name>ForecastCatUpdatetoCommit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>&quot;5. Preferred Supplier, Negotiating Terms&quot;</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Forecast Cat - Update to Stretch</fullName>
        <actions>
            <name>ForecastCatUpdatetoStretch</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>4. N.Channel-Shortlist; Channel-Best Off</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lost Order - Change Record Type to Locked</fullName>
        <actions>
            <name>LostOrderChangeRecordTypetoLocked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Lost Order</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New EMEA Opportunity - Qualified</fullName>
        <actions>
            <name>NewEMEAOpportunityqualified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>greaterOrEqual</operation>
            <value>12/31/2006 5:30 AM</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Region__c</field>
            <operation>equals</operation>
            <value>EMEA</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bid_Stage__c</field>
            <operation>equals</operation>
            <value>Qualified</value>
        </criteriaItems>
        <description>Notification of when a new qualified EMEA Opportunity is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>New EMEA Opportunity - Unqualified</fullName>
        <actions>
            <name>NewEMEAOpportunityUnqualified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>greaterOrEqual</operation>
            <value>12/31/2006 5:30 AM</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Region__c</field>
            <operation>equals</operation>
            <value>EMEA</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Bid_Stage__c</field>
            <operation>equals</operation>
            <value>Unqualified</value>
        </criteriaItems>
        <description>Notification of when a new unqualified EMEA Opportunity is created</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Op at 99%25%2C win process started</fullName>
        <actions>
            <name>x99Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>POorContractSignedUpdated</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>WinProcessStarted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>6. ATP or PO Received</value>
        </criteriaItems>
        <description>Win Authorised field updated to &apos;Pending&apos; when Opp stage changes to 6.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity moved out of current quarter</fullName>
        <actions>
            <name>Opportunity_moved_out_of_current_quarter</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Region__c</field>
            <operation>equals</operation>
            <value>EMEA</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.CloseDate</field>
            <operation>greaterThan</operation>
            <value>9/30/2012</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>notEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Proposal Status updated to %27Completed%27 at 100%25</fullName>
        <actions>
            <name>ProposalStatusupdatedtoCompleted</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Complete__c</field>
            <operation>equals</operation>
            <value>100</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Loss Date</fullName>
        <actions>
            <name>Loss_Date_to_today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Lost Order</value>
        </criteriaItems>
        <description>When Stage is set to Closed Lost, input date automatically</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Standard Payment Terms Notification</fullName>
        <actions>
            <name>NonStandardPaymentTermsNotification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>4. N.Channel-Shortlist; Channel-Best Off,6. ATP or PO Received,&quot;5. Preferred Supplier, Negotiating Terms&quot;</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Standard_commercial_payment_terms__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update CM Employee ID for A Reed</fullName>
        <actions>
            <name>UpdateCMEmployeeIDforAReed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>A Reed</value>
        </criteriaItems>
        <description>Updates the CM Employee ID field with Andy Reed&apos;s Employee ID when Andy is indicated as the Channel Manager.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update CM Employee ID for S Hall</fullName>
        <actions>
            <name>UpdateCMEmployeeIDforSHall</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>S Hall</value>
        </criteriaItems>
        <description>Updates the CM Employee ID field with Simon Hall&apos;s Employee ID when Simon is indicated as the Channel Manager.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update CM Employee ID for V Chen</fullName>
        <actions>
            <name>UpdateCMEmployeeIDforVChen</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Channel_Manager__c</field>
            <operation>equals</operation>
            <value>V Chen</value>
        </criteriaItems>
        <description>Updates the CM Employee ID field with Vincent Chen&apos;s Employee ID when Vincent is indicated as the Channel Manager.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Truncated Opp</fullName>
        <actions>
            <name>TruncateComments</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Comments__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>AlertQualifiedBid</fullName>
        <assignedTo>clive.innes@mavenir.com.mp1</assignedTo>
        <assignedToType>user</assignedToType>
        <description>Notification that this Opportunity Bid has been Set to Qualified.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Alert: Qualified Bid</subject>
    </tasks>
</Workflow>
