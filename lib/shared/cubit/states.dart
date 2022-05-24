abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangedTabState extends AppStates {}

class AppOpenDatabaseState extends AppStates {}

class AppGetDataFromDatabaseState extends AppStates {}

class AppGetDataFromDatabaseLoadingState extends AppStates {}

class AppUpdateDataFromDatabaseState extends AppStates {}

class AppDeleteDataFromDatabaseState extends AppStates {}

class AppInsertToDatabaseState extends AppStates {}
