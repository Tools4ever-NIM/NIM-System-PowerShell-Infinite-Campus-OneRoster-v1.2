#
# Infinite Campus OneRoster 1.2.ps1 - Infinite Campus OneRoster v1.2
#
$Log_MaskableKeys = @(
    'Password',
    'proxy_password',
    'client_secret'
)

$Global:AuthToken = $null
$Global:Proxy = @{}
$Global:ProxyInitialized = $false
$Global:Classes = [System.Collections.ArrayList]@()
$Global:Classes_Resources = [System.Collections.ArrayList]@()
$Global:Classes_Terms = [System.Collections.ArrayList]@()
$Global:Courses = [System.Collections.ArrayList]@()
$Global:Courses_Resources = [System.Collections.ArrayList]@()
$Global:Orgs = [System.Collections.ArrayList]@()
$Global:Orgs_Children = [System.Collections.ArrayList]@()
$Global:Users = [System.Collections.ArrayList]@()
$Global:Users_Roles = [System.Collections.ArrayList]@()
$Global:Users_UserIds = [System.Collections.ArrayList]@()
$Global:Users_UserProfiles = [System.Collections.ArrayList]@()
$Global:Users_Agents = [System.Collections.ArrayList]@()
$Global:Users_Resources = [System.Collections.ArrayList]@()
$Global:LineItems = [System.Collections.ArrayList]@()
$Global:LineItems_LearningObjectiveSets = [System.Collections.ArrayList]@()
$Global:Results = [System.Collections.ArrayList]@()
$Global:Results_LearningObjectiveSets = [System.Collections.ArrayList]@()

$Properties = @{
    academicSession = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'endDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'schoolYear';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'sourcedId';            type = 'boolean';   objectfields = $null;             options = @('default') }
        @{ name = 'startDate';            type = 'boolean';   objectfields = $null;             options = @('default') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'parent';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'child';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
    )
    class = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'classCode';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'classType';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'location';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'grades';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'subjects';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'course';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'school';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'terms';            type = 'table';   objectfields = $null;             options = @('default') }
        @{ name = 'subjectCodes';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'periods';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'resources';            type = 'table';   objectfields = $null;             options = @('default') }
    )
    class_resource = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'classes_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'href';            type = 'string';   objectfields = $null;             options = @() }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    class_term = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'classes_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'href';            type = 'string';   objectfields = $null;             options = @() }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    course = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'schoolYear';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'courseCode';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'grades';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'subjects';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'org';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'subjectCodes';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'resources';            type = 'table';   objectfields = $null;             options = @('default') }
    )
    course_resource = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'courses_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'href';            type = 'string';   objectfields = $null;             options = @() }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    demographic = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'birthDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'sex';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'americanIndianOrAlaskaNative';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'asian';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'blackOrAfricanAmerican';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'nativeHawaiianOrOtherPacificIslander';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'white';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'demographicRaceTwoOrMoreRaces';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'hispanicOrLatinoEthnicity';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'countryOfBirthCode';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'stateOfBirthAbbreviation';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'cityOfBirth';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'publicSchoolResidenceStatus';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    enrollment = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'user';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'class';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'school';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'role';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'primary';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'beginDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'endDate';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    org = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'name';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'identifier';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'parent';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'children';            type = 'table';   objectfields = $null;             options = @('default') }
    )
    org_children = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'orgs_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'href';            type = 'string';   objectfields = $null;             options = @() }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    user = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'email';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'enabledUser';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'familyName';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'givenName';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'identifier';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'middleName';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'password';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'phone';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'preferredFirstName';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'preferredLastName';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'preferredMiddleName';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'roles';            type = 'table';   objectfields = $null;             options = @('default') }
        @{ name = 'sms';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'username';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'userIds';            type = 'table';   objectfields = $null;             options = @('default') }
        @{ name = 'userProfiles';            type = 'table';   objectfields = $null;             options = @('default') }
        @{ name = 'userMasterIdentifier';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'primaryOrg';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'grades';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'agents';            type = 'table';   objectfields = $null;             options = @('default') }
        @{ name = 'resources';            type = 'table';   objectfields = $null;             options = @('default') }
    )
    user_role = @(
        @{ name = 'user_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'org';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'role';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'roleType';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'beginDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'endDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'userProfile';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    user_userId = @(
        @{ name = 'user_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'identifier';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    user_userProfile = @(
        @{ name = 'user_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'applicationId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'description';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'profileId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'profileType';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'vendorId';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    user_agent = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'user_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'href';            type = 'string';   objectfields = $null;             options = @() }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    user_resource = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'user_sourcedId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'href';            type = 'string';   objectfields = $null;             options = @() }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    resource = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'roles';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'importance';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'vendorId';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'applicationId';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    category = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'weight';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    lineItem = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'description';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'assignDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dueDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'class';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'school';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'category';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'gradingPeriod';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'academicSession';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'scoreScale';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'resultValueMin';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'resultValueMax';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'learningObjectiveSet';            type = 'table';   objectfields = $null;             options = @('default') }
    )
    lineItem_learningObjectiveSet = @(
        @{ name = 'lineItem_sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'source';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'learningObjectiveIds';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    result = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'lineItem';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'student';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'class';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'scoreScale';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'scoreStatus';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'textScore';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'score';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'scoreDate';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'comment';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'learningObjectiveSet';            type = 'table';   objectfields = $null;             options = @('default') }
    )
    result_learningObjectiveSet = @(
        @{ name = 'lineItem_sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'source';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'learningObjectiveIds';            type = 'string';   objectfields = $null;             options = @('default') }
    )
    scoreScale = @(
        @{ name = 'sourcedId';            type = 'string';   objectfields = $null;             options = @('default','key') }
        @{ name = 'status';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'dateLastModified';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'course';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'class';            type = 'object';   objectfields = @('href','sourcedId','type');             options = @('default') }
        @{ name = 'scoreScaleValue';            type = 'object';   objectfields = @('itemValueLHS','itemValueRHS');             options = @('default') }
        @{ name = 'title';            type = 'string';   objectfields = $null;             options = @('default') }
        @{ name = 'type';            type = 'string';   objectfields = $null;             options = @('default') }
    )
}

#
# System functions
#
function Idm-SystemInfo {
    param (
        # Operations
        [switch] $Connection,
        [switch] $TestConnection,
        [switch] $Configuration,
        # Parameters
        [string] $ConnectionParams
    )

    Log info "-Connection=$Connection -TestConnection=$TestConnection -Configuration=$Configuration -ConnectionParams='$ConnectionParams'"

    if ($Connection) {
        @(
            @{
                name = 'heading_connect'
                type = 'text'
                text = 'Connection'
				tooltip = 'System Connection info'
            }
            @{
                name = 'tenant_id'
                type = 'textbox'
                label = 'Tenant URI '
                description = 'URI for OneRoster API'
                value = 'customername.infinitecampus.org/campus/api/oneroster/v1p2/customername'
                require = $true
            }
            @{
                name = 'token_uri'
                type = 'textbox'
                label = 'OAuth URI'
                tooltip = 'URI for the OAuth Token'
                value = 'customername.infinitecampus.org/campus/oauth2/token?appName=customername'
                require = $false
            }
            @{
                name = 'client_id'
                type = 'textbox'
                label = 'Client ID'
                tooltip = 'API Client ID'
                value = ''
                require = $true
            }
            @{
                name = 'client_secret'
                type = 'textbox'
                password = $true
                label = 'Client Secret'
                tooltip = 'API Client Secret'
                value = ''
                require = $true
            }
            @{
                name = 'page_size'
                type = 'textbox'
                label = 'Pagination Size'
                description = ''
                value = 1000
            }
            @{
                name = 'use_proxy'
                type = 'checkbox'
                label = 'Use Proxy'
                description = 'Use Proxy server for requests'
                value = $false # Default value of checkbox item
            }
            @{
                name = 'proxy_address'
                type = 'textbox'
                label = 'Proxy Address'
                description = 'Address of the proxy server'
                value = 'http://127.0.0.1:8888'
                disabled = '!use_proxy'
                hidden = '!use_proxy'
            }
            @{
                name = 'use_proxy_credentials'
                type = 'checkbox'
                label = 'Use Proxy Credentials'
                description = 'Use credentials for proxy'
                value = $false
                disabled = '!use_proxy'
                hidden = '!use_proxy'
            }
            @{
                name = 'proxy_username'
                type = 'textbox'
                label = 'Proxy Username'
                label_indent = $true
                description = 'Username account'
                value = ''
                disabled = '!use_proxy_credentials'
                hidden = '!use_proxy_credentials'
            }
            @{
                name = 'proxy_password'
                type = 'textbox'
                password = $true
                label = 'Proxy Password'
                label_indent = $true
                description = 'User account password'
                value = ''
                disabled = '!use_proxy_credentials'
                hidden = '!use_proxy_credentials'
            }
            @{
                name = 'heading_filters'
                type = 'text'
                text = 'Data Filters'
				tooltip = 'Data filters for each endpoint'
            }
            @{
                name = 'filter_academicSession'
                type = 'textbox'
                label = 'Academic Sessions'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'filter_demographic'
                type = 'textbox'
                label = 'Demographics'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'filter_class'
                type = 'textbox'
                label = 'Classes'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'filter_course'
                type = 'textbox'
                label = 'Courses'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'filter_enrollment'
                type = 'textbox'
                label = 'Enrollments'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'filter_org'
                type = 'textbox'
                label = 'Orgs'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'filter_users'
                type = 'textbox'
                label = 'Users'
                label_indent = $true
                description = ''
                value = "status='active'"
            }
            @{
                name = 'heading_service'
                type = 'text'
                text = 'Service Settings'
				tooltip = 'Settings for service'
            }
            @{
                name = 'nr_of_retries'
                type = 'textbox'
                label = 'Max. number of retry attempts'
                description = ''
                value = 5
            }
            @{
                name = 'retryDelay'
                type = 'textbox'
                label = 'Seconds to wait for retry'
                description = ''
                value = 2
            }
            @{
                name = 'request_timeout_seconds'
                type = 'textbox'
                label = 'Request timeout (seconds)'
                description = ''
                value = 100
            }
            @{
                name = 'nr_of_threads'
                type = 'textbox'
                label = 'Max. number of simultaneous requests'
                description = ''
                value = 20
            }
            @{
                name = 'nr_of_sessions'
                type = 'textbox'
                label = 'Max. number of simultaneous sessions'
                description = ''
                value = 1
            }
            @{
                name = 'sessions_idle_timeout'
                type = 'textbox'
                label = 'Session cleanup idle time (minutes)'
                description = ''
                value = 1
            }
        )
    }

    if ($TestConnection) {
        $system_params = ConvertFrom-Json2 $ConnectionParams
        #Execute-Request -SystemParams $system_params -Method "GET" -Uri "profile/identity/v4.1/Users?count=1" -BypassPagination $true | Out-Null
    }

    if ($Configuration) {
        @()
    }

    Log info "Done"
}

function Idm-OnUnload {
    $Global:AuthToken = $null
    $Global:Proxy = @{}
    $Global:ProxyInitialized = $false
    $Global:Classes.Clear()
    $Global:Classes_Resources.Clear()
    $Global:Classes_Terms.Clear()
    $Global:Courses.Clear()
    $Global:Courses_Resources.Clear()
    $Global:Orgs.Clear()
    $Global:Orgs_Children.Clear()
    $Global:Users.Clear()
    $Global:Users_Roles.Clear()
    $Global:Users_UserIds.Clear()
    $Global:Users_UserProfiles.Clear()
    $Global:Users_Agents.Clear()
    $Global:Users_Resources.Clear()
    $Global:LineItems.Clear()
    $Global:LineItems_LearningObjectiveSets.Clear()
    $Global:Results.Clear()
    $Global:Results_LearningObjectiveSets.Clear()
}

#
# Object CRUD functions
#
function Idm-academicSessionsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'academicSession'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/academicSessions"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_academicSession
                }
                Path = "academicSessions"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                $row
            }
        }
}

function Idm-classesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'class'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/classes"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_class
                }
                Path = "classes"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            $tableVarMap = @{
                'terms'         = $Global:Classes_Terms
                'resources'            = $Global:Classes_Resources
            }

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'table') {
                        $ucFirst = $prop.Name.Substring(0,1).ToUpper() + $prop.Name.Substring(1)
                        $globalVar = $tableVarMap[$ucFirst]
                            foreach($subItem in $prop.Value) {
                                $table_template = [ordered]@{}
                                $table_template['classes_sourcedId'] = $item.sourcedId
                                foreach($subProperty in $subItem.PSObject.Properties) {
                                    $table_template[$subProperty.Name] = $subProperty.Value
                                }
                                [void]$globalVar.Add([PSCustomObject]$table_template)
                            }
                        continue
                    }

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                [void]$Global:Classes.Add($row)
                $row
            }
        }
}

function Idm-classes_resourcesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'class_resource'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Classes.Count -eq 0) {
            Idm-classesRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Classes_Resources
}

function Idm-classes_termsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'class_term'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Classes.Count -eq 0) {
            Idm-classesRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Classes_Terms
}

function Idm-coursesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'course'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/courses"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_course
                }
                Path = "courses"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            $tableVarMap = @{
                'resources'            = $Global:Courses_Resources
            }

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'table') {
                        $ucFirst = $prop.Name.Substring(0,1).ToUpper() + $prop.Name.Substring(1)
                        $globalVar = $tableVarMap[$ucFirst]
                            foreach($subItem in $prop.Value) {
                                $table_template = [ordered]@{}
                                $table_template['courses_sourcedId'] = $item.sourcedId
                                foreach($subProperty in $subItem.PSObject.Properties) {
                                    $table_template[$subProperty.Name] = $subProperty.Value
                                }
                                [void]$globalVar.Add([PSCustomObject]$table_template)
                            }
                        continue
                    }

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                [void]$Global:Courses.Add($row)
                $row
            }
        }
}

function Idm-courses_resourcesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'course_resource'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Courses.Count -eq 0) {
            Idm-coursesRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Courses_Resources
}

function Idm-demographicsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'demographic'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/demographics"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_demographic
                }
                Path = "demographics"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)


            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                $row
            }
        }
}

function Idm-enrollmentsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'enrollment'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/enrollments"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_enrollment
                }
                Path = "enrollments"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)


            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                $row
            }
        }
}

function Idm-orgsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'org'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/orgs"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_org
                }
                Path = "orgs"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            $tableVarMap = @{
                'children'         = $Global:Orgs_Children
            }

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'table') {
                        $ucFirst = $prop.Name.Substring(0,1).ToUpper() + $prop.Name.Substring(1)
                        $globalVar = $tableVarMap[$ucFirst]
                            foreach($subItem in $prop.Value) {
                                $table_template = [ordered]@{}
                                $table_template['orgs_sourcedId'] = $item.sourcedId
                                foreach($subProperty in $subItem.PSObject.Properties) {
                                    $table_template[$subProperty.Name] = $subProperty.Value
                                }
                                [void]$globalVar.Add([PSCustomObject]$table_template)
                            }
                        continue
                    }

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                [void]$Global:Orgs.Add($row)
                $row
            }
        }
}

function Idm-orgs_childrenRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'org_children'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Orgs.Count -eq 0) {
            Idm-orgsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Orgs_Children
}

function Idm-usersRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'user'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/users"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_user
                }
                Path = "users"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            $tableVarMap = @{
                'roles'         = $Global:Users_Roles
                'userIds'       = $Global:Users_UserIds
                'userProfiles'  = $Global:Users_UserProfiles
                'agents'        = $Global:Users_Agents
                'resources'     = $Global:Users_Resources
            }

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'table') {
                        $ucFirst = $prop.Name.Substring(0,1).ToUpper() + $prop.Name.Substring(1)
                        $globalVar = $tableVarMap[$ucFirst]
                            foreach($subItem in $prop.Value) {
                                $table_template = [ordered]@{}
                                $table_template['orgs_sourcedId'] = $item.sourcedId
                                foreach($subProperty in $subItem.PSObject.Properties) {
                                    $table_template[$subProperty.Name] = $subProperty.Value
                                }
                                [void]$globalVar.Add([PSCustomObject]$table_template)
                            }
                        continue
                    }

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                [void]$Global:Users.Add($row)
                $row
            }
        }
}

function Idm-users_rolesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'user_role'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Users.Count -eq 0) {
            Idm-usersRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Users_Roles
}

function Idm-users_userIdsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'user_userId'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Users.Count -eq 0) {
            Idm-usersRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Users_UserIds
}

function Idm-users_userProfilesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'user_userProfile'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Users.Count -eq 0) {
            Idm-usersRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Users_UserProfiles
}

function Idm-users_agentsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'user_agent'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Users.Count -eq 0) {
            Idm-usersRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Users_Agents
}

function Idm-users_resourcesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'user_resource'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Users.Count -eq 0) {
            Idm-usersRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Users_Resources
}

function Idm-resourcesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'resource'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/resources"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_user
                }
                Path = "resources"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                $row
            }
        }
}

function Idm-categoriesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'category'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/categories"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Body = @{
                    filter = $system_params.filter_user
                }
                Path = "categories"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                $row
            }
        }
}

function Idm-lineItemsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'lineItem'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/lineItems"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Path = "lineItems"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            $tableVarMap = @{
                'learningObjectiveSet'            = $Global:LineItems_LearningObjectiveSets
            }

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'table') {
                        $ucFirst = $prop.Name.Substring(0,1).ToUpper() + $prop.Name.Substring(1)
                        $globalVar = $tableVarMap[$ucFirst]
                            foreach($subItem in $prop.Value) {
                                $table_template = [ordered]@{}
                                $table_template['courses_sourcedId'] = $item.sourcedId
                                foreach($subProperty in $subItem.PSObject.Properties) {
                                    $table_template[$subProperty.Name] = $subProperty.Value
                                }
                                [void]$globalVar.Add([PSCustomObject]$table_template)
                            }
                        continue
                    }

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                [void]$Global:LineItems.Add($row)
                $row
            }
        }
}

function Idm-lineItems_learningObjectiveSetRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'lineItem_learningObjectiveSet'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:LineItems.Count -eq 0) {
            Idm-lineItemsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:LineItems_LearningObjectiveSets
}

function Idm-resultsRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'result'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/results"             
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Path = "results"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            $tableVarMap = @{
                'learningObjectiveSet'            = $Global:LineItems_LearningObjectiveSets
            }

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'table') {
                        $ucFirst = $prop.Name.Substring(0,1).ToUpper() + $prop.Name.Substring(1)
                        $globalVar = $tableVarMap[$ucFirst]
                            foreach($subItem in $prop.Value) {
                                $table_template = [ordered]@{}
                                $table_template['courses_sourcedId'] = $item.sourcedId
                                foreach($subProperty in $subItem.PSObject.Properties) {
                                    $table_template[$subProperty.Name] = $subProperty.Value
                                }
                                [void]$globalVar.Add([PSCustomObject]$table_template)
                            }
                        continue
                    }

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                [void]$Global:Results.Add($row)
                $row
            }
        }
}

function Idm-results_learningObjectiveSetRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'result_learningObjectiveSet'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            return
        }

        # Refresh cache if needed
        if ($Global:Results.Count -eq 0) {
            Idm-resultsRead -SystemParams $SystemParams -FunctionParams $FunctionParams | Out-Null
        }

        $Global:Results_LearningObjectiveSets
}

function Idm-scoreScalesRead {
    param (
        # Mode
        [switch] $GetMeta,    
        # Parameters
        [string] $SystemParams,
        [string] $FunctionParams

    )
        $system_params   = ConvertFrom-Json2 $SystemParams
        $function_params = ConvertFrom-Json2 $FunctionParams
        $Class = 'scoreScale'
        
        if ($GetMeta) {
            Get-ClassMetaData -SystemParams $SystemParams -Class $Class
            
        } else {

            $uri = "ims/oneroster/rostering/v1p2/scoreScales"
        
            $splat = @{
                SystemParams = $system_params
                Method = "GET"
                Uri = $uri                    
                Path = "scoreSales"
            }

            $response = Get-CachedReadData -ReadFunctionName $MyInvocation.MyCommand.Name -RequestSplat $splat

            # Precompute property template
            $properties = $Global:Properties.$Class | Where-Object { ('hidden' -notin $_.options ) }
            
            $propertiesHT = @{}; $Global:Properties.$Class | ForEach-Object { $propertiesHT[$_.name] = $_ }

            $template = [ordered]@{}
            foreach ($prop in $properties.Name) {
                if($propertiesHT[$prop].Type -eq 'object') {
                    $colPrefix = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                    foreach($path in $propertiesHT[$prop].objectfields) {
                        $template["$($colPrefix)_$($path.Replace('.','_'))"] = $null
                    }
                    continue
                }

                $colName = if ($propertiesHT[$prop].alias) { $propertiesHT[$prop].alias } else { $prop }
                $template[$colName] = $null
            }

            $propertyNameSet = [System.Collections.Generic.HashSet[string]]::new([string[]]$properties.Name, [System.StringComparer]::Ordinal)

            foreach($item in $response) {
                $row = [PSCustomObject]([ordered]@{} + $template)
                foreach($prop in $item.PSObject.Properties) {
                    $schemaProp = $propertiesHT[$prop.Name]

                    if($schemaProp.Type -eq 'object') {
                        $colPrefix = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        foreach($path in $schemaProp.objectfields) {
                            $colName = "$($colPrefix)_$($path.Replace('.','_'))"
                            $val = Resolve-NestedValue $prop.Value $path
                            $rowProp = $row.PSObject.Properties[$colName]
                            if ($null -ne $rowProp) {
                                $rowProp.Value = $val
                            } else {
                                $row | Add-Member -NotePropertyName $colName -NotePropertyValue $val
                            }
                        }
                        continue
                    }

                    if ($null -ne $schemaProp -and $propertyNameSet.Contains($prop.Name)) {
                        $colName = if ($schemaProp.alias) { $schemaProp.alias } else { $prop.Name }
                        $row.($colName) = $prop.Value
                    }
                }

                $row
            }
        }
}

#
#   Internal Functions
#
function Initialize-Proxy {
    param (
        [hashtable] $SystemParams
    )

    if($SystemParams.use_proxy)
                {
                    Add-Type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
                    
        $Global:Proxy['ProxyAddress'] = $SystemParams.proxy_address

        if($SystemParams.use_proxy_credentials)
        {
            $Global:Proxy["ProxyCredential"] = New-Object System.Management.Automation.PSCredential ($SystemParams.proxy_username, (ConvertTo-SecureString $SystemParams.proxy_password -AsPlainText -Force) )
        }
    } else {
        $Global:Proxy = $null
    }


}

function Get-IntSetting {
    param (
        [hashtable] $Settings,
        [string] $Name,
        [int] $Default,
        [int] $Minimum = 1,
        [int] $Maximum = [int]::MaxValue
    )

    $value = $null
    if ($null -ne $Settings -and $Settings.ContainsKey($Name)) {
        $value = $Settings[$Name]
    }

    $parsed = 0
    if ($null -eq $value -or -not [int]::TryParse(([string]$value), [ref]$parsed)) {
        $parsed = $Default
    }

    if ($parsed -lt $Minimum) { return $Minimum }
    if ($parsed -gt $Maximum) { return $Maximum }
    return $parsed
}

function Execute-Authorization {
    param (
        [hashtable] $SystemParams
    )

        $requestTimeoutSeconds = Get-IntSetting -Settings $SystemParams -Name 'request_timeout_seconds' -Default 100 -Minimum 1 -Maximum 3600

        $splat = @{
            Headers = @{
                "Accept" = "application/json"
            }
            body = @{
                grant_type     = "client_credentials"
                client_id      = $SystemParams.client_id
                client_secret  = $SystemParams.client_secret
                scope          = 'https://purl.imsglobal.org/spec/or/v1p2/scope/roster.readonly https://purl.imsglobal.org/spec/or/v1p2/scope/roster-demographics.readonly https://purl.imsglobal.org/spec/or/v1p2/scope/gradebook.readonly https://purl.imsglobal.org/spec/or/v1p2/scope/gradebook-core.readonly https://purl.imsglobal.org/spec/or/v1p2/scope/resource.readonly'
            }
            Method = 'POST'
            Uri = ("https://{0}" -f $SystemParams.token_uri)
            ContentType = "application/x-www-form-urlencoded"
            TimeoutSec = $requestTimeoutSeconds
        }

        if($SystemParams.use_proxy) {
            $splat["Proxy"] = $Global:Proxy['ProxyAddress']
            if($SystemParams.use_proxy_credentials) {
                $splat["proxyCredential"] = $Global:Proxy["ProxyCredential"]
            }
        }

        $Global:AuthToken = (Invoke-RestMethod @splat).access_token
}

function Execute-Request {
    param (
        [hashtable] $SystemParams,
        [string] $Method,
        [object] $Body,
        [string] $Uri,
        [string] $Path = $null,
        [boolean] $LoggingEnabled = $true,
        [boolean] $BypassPagination = $false
    )

    if (-not $Global:ProxyInitialized) {
        Initialize-Proxy -SystemParams $SystemParams
        $Global:ProxyInitialized = $true
    }

    if ($Global:AuthToken.length -lt 1) {
        Execute-Authorization $SystemParams
    }

    $requestTimeoutSeconds = Get-IntSetting -Settings $SystemParams -Name 'request_timeout_seconds' -Default 100 -Minimum 1 -Maximum 3600
    $maxRetries = Get-IntSetting -Settings $SystemParams -Name 'nr_of_retries' -Default 5 -Minimum 1 -Maximum 20
    $defaultRetryDelay = Get-IntSetting -Settings $SystemParams -Name 'retryDelay' -Default 2 -Minimum 1 -Maximum 3600

    # Build base request
    $splat = @{
        Headers = @{
            "Authorization" = ("Bearer {0}" -f $Global:AuthToken)
            "Accept"        = "application/json"
            "Content-Type"  = "application/json"
        }
        Method = $Method
        Uri    = ("https://{0}/{1}" -f $SystemParams.tenant_id, $Uri)
        TimeoutSec = $requestTimeoutSeconds
    }
 
    if ($Body) {
        $splat.Body = $Body
    }

    if ($SystemParams.use_proxy) {
        $splat["Proxy"] = $Global:Proxy['ProxyAddress']
        if ($SystemParams.use_proxy_credentials) {
            $splat["ProxyCredential"] = $Global:Proxy["ProxyCredential"]
        }
    }

    if ($PSVersionTable.PSVersion.Major -lt 6) {
        $splat["UseBasicParsing"] = $true
    }

    function ConvertTo-QueryValue {
        param([string] $Value)

        return [Uri]::EscapeDataString($Value).Replace("'", "%27")
    }

    function Get-NormalizedPaginationUri {
        param([string] $UriValue)

        try {
            $normalizedUriValue = $UriValue -replace '\?&', '?'
            $uriObject = [Uri]$normalizedUriValue
            $queryParts = [System.Collections.Generic.List[string]]::new()

            foreach ($part in $uriObject.Query.TrimStart('?').Split('&')) {
                if ([string]::IsNullOrWhiteSpace($part)) { continue }

                $keyValue = $part.Split('=', 2)
                $key = [Uri]::UnescapeDataString($keyValue[0].Replace('+', ' '))
                $value = if ($keyValue.Count -gt 1) { [Uri]::UnescapeDataString($keyValue[1].Replace('+', ' ')) } else { "" }
                $queryParts.Add(("{0}={1}" -f (ConvertTo-QueryValue $key), (ConvertTo-QueryValue $value)))
            }

            $sortedQuery = [string[]]$queryParts
            [array]::Sort($sortedQuery, [System.StringComparer]::OrdinalIgnoreCase)
            $queryString = $sortedQuery -join "&"

            if ($queryString.Length -gt 0) {
                return ("{0}://{1}{2}?{3}" -f $uriObject.Scheme.ToLowerInvariant(), $uriObject.Authority.ToLowerInvariant(), $uriObject.AbsolutePath, $queryString)
            }

            return ("{0}://{1}{2}" -f $uriObject.Scheme.ToLowerInvariant(), $uriObject.Authority.ToLowerInvariant(), $uriObject.AbsolutePath)
        } catch {
            return ($UriValue -replace '\?&', '?')
        }
    }

    # Convert Body → query parameters for GET requests
    if ($Method -eq "GET" -and $Body) {

        # Ensure Body is a hashtable before treating it as query params
        if ($Body -is [hashtable]) {

            $queryParts = [System.Collections.Generic.List[string]]::new()
            foreach ($entry in $Body.GetEnumerator()) {
                if ($null -eq $entry.Value) { continue }

                $encodedKey = ConvertTo-QueryValue ([string]$entry.Key)
                if ($entry.Value -is [System.Array]) {
                    foreach ($value in $entry.Value) {
                        if ($null -eq $value) { continue }
                        $queryParts.Add(("{0}={1}" -f $encodedKey, (ConvertTo-QueryValue ([string]$value))))
                    }
                } else {
                    $queryParts.Add(("{0}={1}" -f $encodedKey, (ConvertTo-QueryValue ([string]$entry.Value))))
                }
            }

            $queryString = $queryParts -join "&"

            if ($queryString.Length -gt 0) {
                if ($splat.Uri -notmatch "\?") {
                    $splat.Uri = "$($splat.Uri)?$queryString"
                }
                else {
                    $splat.Uri = "$($splat.Uri)&$queryString"
                }
            }
        }

        # GET requests cannot send a body
        if ($splat.ContainsKey("Body")) {
            $splat.Remove("Body")
        }
    }

    if ($Method -eq "GET" -and -not $BypassPagination) {
        $pageSize = Get-IntSetting -Settings $SystemParams -Name 'page_size' -Default 1000 -Minimum 1 -Maximum 10000
        $paginationQueryParts = [System.Collections.Generic.List[string]]::new()

        if ($splat.Uri -notmatch '(\?|&)limit=') {
            $paginationQueryParts.Add(("limit={0}" -f $pageSize))
        }
        if ($splat.Uri -notmatch '(\?|&)offset=') {
            $paginationQueryParts.Add("offset=0")
        }

        if ($paginationQueryParts.Count -gt 0) {
            $paginationQueryString = $paginationQueryParts -join "&"
            if ($splat.Uri -notmatch "\?") {
                $splat.Uri = "$($splat.Uri)?$paginationQueryString"
            } else {
                $splat.Uri = "$($splat.Uri)&$paginationQueryString"
            }
        }
    }

    # Header link pagination accumulator
    $allData = [System.Collections.Generic.List[object]]::new()
    $nextUri = $splat.Uri
    $visitedUris = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

    do {
        $splat.Uri = $nextUri
        $currentUriKey = Get-NormalizedPaginationUri $splat.Uri
        [void]$visitedUris.Add($currentUriKey)

        $attempt = 0
        $retryDelay = $defaultRetryDelay
        $responseHeaders = $null

        do {
            try {
                $attemptSuffix = if ($attempt -gt 0) { " (Attempt $($attempt + 1))" } else { "" }
                if($LoggingEnabled) { Log verbose "$($splat.Method) Call: $($splat.Uri)$attemptSuffix" }

                $webResponse = Invoke-WebRequest @splat -ErrorAction Stop
                $responseHeaders = $webResponse.Headers
                $response = if ([string]::IsNullOrWhiteSpace($webResponse.Content)) { $null } else { $webResponse.Content | ConvertFrom-Json }
                break
            }
            catch {
                $errorRecord = $_
                $statusCode = $errorRecord.Exception.Response.StatusCode.value__

                switch ($statusCode) {

                    { $_ -eq 401 -or $_ -eq 403 } {
                        if($LoggingEnabled) { Log warning "Received $statusCode. Attempting reauthentication..." }

                        # Re-authenticate under a process-wide lock to avoid runspace refresh stampedes.
                        $authRefreshMutex = New-Object System.Threading.Mutex($false, "NIMConcurSapAuthRefresh")
                        $authRefreshLockAcquired = $false
                        try {
                            $authRefreshLockAcquired = $authRefreshMutex.WaitOne(($requestTimeoutSeconds * 1000))
                            if (-not $authRefreshLockAcquired) {
                                throw "Timed out waiting for token refresh lock."
                            }
                            Execute-Authorization $SystemParams
                        } finally {
                            if ($authRefreshLockAcquired) {
                                $authRefreshMutex.ReleaseMutex()
                            }
                            $authRefreshMutex.Dispose()
                        }

                        # Update Authorization header with new token
                        $splat.Headers["Authorization"] = ("Bearer {0}" -f $Global:AuthToken)

                        # Retry once immediately
                        try {
                            $webResponse = Invoke-WebRequest @splat -ErrorAction Stop
                            $responseHeaders = $webResponse.Headers
                            $response = if ([string]::IsNullOrWhiteSpace($webResponse.Content)) { $null } else { $webResponse.Content | ConvertFrom-Json }
                            break
                        }
                        catch {
                            throw "$statusCode persisted after reauthentication. Aborting request."
                        }
                    }

                    429 {
                        $attempt++
                        if ($attempt -ge $maxRetries) {
                            throw "Max retry attempts reached for $Uri"
                        }
                        $retryAfter = $errorRecord.Exception.Response.Headers["Retry-After"]
                        if ($retryAfter) {
                            $retryAfterSeconds = 0
                            if ([int]::TryParse($retryAfter, [ref]$retryAfterSeconds) -and $retryAfterSeconds -gt 0) {
                                $retryDelay = $retryAfterSeconds
                            } else {
                                $retryAfterDate = [datetime]::MinValue
                                if ([datetime]::TryParse($retryAfter, [ref]$retryAfterDate)) {
                                    $retryAfterSeconds = [math]::Ceiling(($retryAfterDate.ToUniversalTime() - [datetime]::UtcNow).TotalSeconds)
                                    if ($retryAfterSeconds -gt 0) {
                                        $retryDelay = $retryAfterSeconds
                                    }
                                }
                            }
                        }
                        if($LoggingEnabled) { Log warning "Received 429. Retrying in $retryDelay seconds..." }
                        Start-Sleep -Seconds $retryDelay
                        $retryDelay *= 2
                    }

                    default {
                        throw $errorRecord
                    }
                }
            }
        } while ($true)

        # Append data
        if ($Path.length -lt 1) {
            if ($null -ne $response) {
                $allData.Add($response)
            }
        } else {
            if ($response.$Path) {
                $allData.AddRange([object[]]@($response.$Path))
            }
        }

        if($BypassPagination) { break }

        $nextUri = $null
        $linkHeader = $responseHeaders["Link"]
        if (-not $linkHeader) {
            $linkHeader = $responseHeaders["link"]
        }

        if ($linkHeader) {
            $linkHeaderValue = [string]($linkHeader -join ",")
            $relLinks = @{}
            foreach ($match in [regex]::Matches($linkHeaderValue, '<([^>]+)>\s*;\s*rel=["'']?([^"'',;\s]+)["'']?', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
                $relLinks[$match.Groups[2].Value.ToLowerInvariant()] = $match.Groups[1].Value
            }

            if ($relLinks.ContainsKey("last") -and $currentUriKey -eq (Get-NormalizedPaginationUri $relLinks["last"])) {
                $nextUri = $null
            } elseif ($relLinks.ContainsKey("next")) {
                $candidateNextUri = $relLinks["next"]
                $candidateNextUriKey = Get-NormalizedPaginationUri $candidateNextUri
                if ($candidateNextUriKey -ne $currentUriKey -and -not $visitedUris.Contains($candidateNextUriKey)) {
                    $nextUri = $candidateNextUri
                }
            }
        }

    } while ($nextUri)

    return $allData
}

function Resolve-NestedValue {
    param($obj, [string]$path)
    $current = $obj
    foreach ($segment in $path.Split('.')) {
        if ($null -eq $current) { return $null }
        $current = $current.$segment
    }
    return $current
}

function Get-ReadCacheDirectory {
    $nimConfigPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NIM\Config"
    $workingPath = (Get-ItemProperty -Path $nimConfigPath -Name "workingPath" -ErrorAction Stop).workingPath

    if ([string]::IsNullOrWhiteSpace($workingPath)) {
        throw "NIM workingPath registry value is empty at $nimConfigPath."
    }

    $cacheDirectory = Join-Path -Path $workingPath -ChildPath "sysdata\temp"

    if (-not (Test-Path -LiteralPath $cacheDirectory)) {
        New-Item -Path $cacheDirectory -ItemType Directory -Force | Out-Null
    }

    return $cacheDirectory
}

function Get-ReadCachePath {
    param([string] $ReadFunctionName)

    $safeName = $ReadFunctionName -replace '[^a-zA-Z0-9_.-]', '_'
    return (Join-Path -Path (Get-ReadCacheDirectory) -ChildPath ("{0}.cache" -f $safeName))
}

function ConvertTo-EncryptionKeyBytes {
    param($EncryptionKey)

    if ($EncryptionKey -is [securestring]) {
        $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($EncryptionKey)
        try {
            $EncryptionKey = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr)
        } finally {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
        }
    }

    if ($EncryptionKey -is [byte[]]) {
        $keyBytes = $EncryptionKey
    } else {
        $keyBytes = [Text.Encoding]::UTF8.GetBytes([string]$EncryptionKey)
    }

    $sha256 = [Security.Cryptography.SHA256]::Create()
    try {
        return $sha256.ComputeHash($keyBytes)
    } finally {
        $sha256.Dispose()
    }
}

function Protect-ReadCacheContent {
    param([string] $PlainText)

    $aes = [Security.Cryptography.Aes]::Create()
    $encryptor = $null
    try {
        $aes.Key = ConvertTo-EncryptionKeyBytes (Get-EncryptionKey)
        $aes.GenerateIV()
        $encryptor = $aes.CreateEncryptor()
        $plainBytes = [Text.Encoding]::UTF8.GetBytes($PlainText)
        $cipherBytes = $encryptor.TransformFinalBlock($plainBytes, 0, $plainBytes.Length)

        return (@{
            version = 1
            iv = [Convert]::ToBase64String($aes.IV)
            data = [Convert]::ToBase64String($cipherBytes)
        } | ConvertTo-Json -Depth 5)
    } finally {
        if ($null -ne $encryptor) { $encryptor.Dispose() }
        $aes.Dispose()
    }
}

function Unprotect-ReadCacheContent {
    param([string] $ProtectedText)

    $cacheEnvelope = $ProtectedText | ConvertFrom-Json
    $aes = [Security.Cryptography.Aes]::Create()
    $decryptor = $null
    try {
        $aes.Key = ConvertTo-EncryptionKeyBytes (Get-EncryptionKey)
        $aes.IV = [Convert]::FromBase64String($cacheEnvelope.iv)
        $decryptor = $aes.CreateDecryptor()
        $cipherBytes = [Convert]::FromBase64String($cacheEnvelope.data)
        $plainBytes = $decryptor.TransformFinalBlock($cipherBytes, 0, $cipherBytes.Length)

        return [Text.Encoding]::UTF8.GetString($plainBytes)
    } finally {
        if ($null -ne $decryptor) { $decryptor.Dispose() }
        $aes.Dispose()
    }
}

function Get-ReadCache {
    param([string] $ReadFunctionName)

    $cachePath = Get-ReadCachePath -ReadFunctionName $ReadFunctionName
    if (-not (Test-Path -LiteralPath $cachePath)) { return $null }

    try {
        $cacheText = Get-Content -LiteralPath $cachePath -Raw
        $plainText = Unprotect-ReadCacheContent -ProtectedText $cacheText
        $cache = $plainText | ConvertFrom-Json

        if ([datetime]$cache.expiresAt -le [datetime]::Now) { return $null }
        Log verbose "Cache for $ReadFunctionName was created at $($cache.createdAt) and expires at $($cache.expiresAt)."
        return $cache
    } catch {
        Log warning "Ignoring unreadable cache for $ReadFunctionName. $_"
        return $null
    }
}

function Set-ReadCache {
    param(
        [string] $ReadFunctionName,
        [object[]] $Data
    )

    $now = [datetime]::Now
    $cache = @{
        createdAt = $now.ToString("o")
        expiresAt = $now.Date.AddDays(1).AddTicks(-1).ToString("o")
        data = @($Data)
    }

    $cachePath = Get-ReadCachePath -ReadFunctionName $ReadFunctionName
    $plainText = $cache | ConvertTo-Json -Depth 25
    $protectedText = Protect-ReadCacheContent -PlainText $plainText
    Set-Content -LiteralPath $cachePath -Value $protectedText -Encoding UTF8
    Log verbose "Cache for $ReadFunctionName was created at $($cache.createdAt) and expires at $($cache.expiresAt)."
}

function Merge-ReadDataBySourcedId {
    param(
        [object[]] $FullData,
        [object[]] $PartialData
    )

    $merged = [ordered]@{}

    foreach ($item in @($FullData)) {
        if ($null -eq $item -or [string]::IsNullOrWhiteSpace([string]$item.sourcedId)) { continue }
        $merged[[string]$item.sourcedId] = $item
    }

    foreach ($item in @($PartialData)) {
        if ($null -eq $item -or [string]::IsNullOrWhiteSpace([string]$item.sourcedId)) { continue }
        $merged[[string]$item.sourcedId] = $item
    }

    return @($merged.Values)
}

function Get-CachedReadData {
    param(
        [string] $ReadFunctionName,
        [hashtable] $RequestSplat
    )

    $cache = Get-ReadCache -ReadFunctionName $ReadFunctionName

    if ($null -eq $cache) {
        Log verbose "No valid cache found for $ReadFunctionName. Performing full data pull."
        $fullData = @(Execute-Request @RequestSplat)
        Set-ReadCache -ReadFunctionName $ReadFunctionName -Data $fullData
        return $fullData
    }

    Log verbose "Valid cache found for $ReadFunctionName. Performing partial data pull."
    $partialSplat = $RequestSplat.Clone()
    $partialBody = @{}

    if ($partialSplat.ContainsKey("Body") -and $partialSplat.Body -is [hashtable]) {
        foreach ($entry in $partialSplat.Body.GetEnumerator()) {
            $partialBody[$entry.Key] = $entry.Value
        }
    }

    $partialBody.filter = ("dateLastModified>'{0}'" -f ([datetime]::Today.ToString("yyyy-MM-ddT00:00:00.000Z")))
    $partialSplat.Body = $partialBody

    $partialData = @(Execute-Request @partialSplat)
    if ($partialData.Count -eq 0) {
        Log verbose "Partial data pull for $ReadFunctionName returned no records. Using cached data."
        return @($cache.data)
    }

    $partialDataWithSourcedId = @($partialData | Where-Object { $null -ne $_ -and -not [string]::IsNullOrWhiteSpace([string]$_.sourcedId) })
    if ($partialDataWithSourcedId.Count -eq 0) {
        Log verbose "Partial data pull for $ReadFunctionName returned no records with sourcedId. Using cached data."
        return @($cache.data)
    }

    $mergedData = Merge-ReadDataBySourcedId -FullData @($cache.data) -PartialData $partialDataWithSourcedId
    Set-ReadCache -ReadFunctionName $ReadFunctionName -Data $mergedData

    return $mergedData
}

function Get-ClassMetaData {
    param (
        [string] $SystemParams,
        [string] $Class
    )

    @(
        @{
            name = 'properties'
            type = 'grid'
            label = 'Properties'
            table = @{
                rows = @( $Global:Properties.$Class | ForEach-Object {
                    $prop = $_
                    $usageHint = @( @(
                        foreach ($opt in $prop.options) {
                            if ($opt -notin @('default', 'idm', 'key')) { continue }
                            if ($opt -eq 'idm') { $opt.ToUpper() }
                            else { $opt.Substring(0,1).ToUpper() + $opt.Substring(1) }
                        }
                    ) | Sort-Object) -join ' | '

                    if ($prop.type -eq 'object' -and $prop.objectfields) {
                        $colPrefix = if ($prop.alias) { $prop.alias } else { $prop.name }
                        foreach ($path in $prop.objectfields) {
                            @{
                                name = "$($colPrefix)_$($path.Replace('.','_'))"
                                usage_hint = $usageHint
                            }
                        }
                    } else {
                        @{
                            name = if ($prop.alias) { $prop.alias } else { $prop.name }
                            usage_hint = $usageHint
                        }
                    }
                })
                settings_grid = @{
                    selection = 'multiple'
                    key_column = 'name'
                    checkbox = $true
                    filter = $true
                    columns = @(
                        @{
                            name = 'name'
                            display_name = 'Name'
                        }
                        @{
                            name = 'usage_hint'
                            display_name = 'Usage hint'
                        }
                    )
                }
            }
            value = @( $Global:Properties.$Class | Where-Object { $_.options.Contains('default') } | ForEach-Object {
                if ($_.type -eq 'object' -and $_.objectfields) {
                    $colPrefix = if ($_.alias) { $_.alias } else { $_.name }
                    foreach ($path in $_.objectfields) { "$($colPrefix)_$($path.Replace('.','_'))" }
                } else {
                    if ($_.alias) { $_.alias } else { $_.name }
                }
            })
        }
    )
}

function Get-ObjectHash {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Object,

        [ValidateSet("SHA256","SHA1","SHA384","SHA512","MD5")]
        [string]$Algorithm = "SHA256",

        [ValidateSet("Base64","Hex")]
        [string]$Encoding = "Base64"
    )

    # Convert object → JSON → UTF8 bytes
    $json  = $Object | ConvertTo-Json -Depth 10
    $bytes = [Text.Encoding]::UTF8.GetBytes($json)

    # Compute hash
    $hasher = [Security.Cryptography.HashAlgorithm]::Create($Algorithm)
    try {
        $hashBytes = $hasher.ComputeHash($bytes)
    } finally {
        $hasher.Dispose()
    }

    # Output format
    switch ($Encoding) {
        "Base64" { return [Convert]::ToBase64String($hashBytes) }
        "Hex"    { return -join ($hashBytes | ForEach-Object { $_.ToString("x2") }) }
    }
}

function Get-EncryptionKey {
    if (-not $Global:EncryptionKey) {
        $file = "$PSScriptRoot\..\..\pse.key"

        if (-not (Test-Path $file)) {
            # Generate 24 x 8 = 192 bits for AES algorithm
            0..255 | Get-Random -Count 24 | Out-File $file
        }

        $Global:EncryptionKey = Get-Content $file
    }

    $Global:EncryptionKey
}
