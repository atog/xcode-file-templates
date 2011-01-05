//
//  «FILENAME»
//  «PROJECTNAME»
//
//  Created by «FULLUSERNAME» on «DATE».
//  Copyright «YEAR» «ORGANIZATIONNAME». All rights reserved.
//

«OPTIONALHEADERIMPORTLINE»

static DataConnector *singleton«FILEBASENAMEASIDENTIFIER» = nil;

@interface «FILEBASENAMEASIDENTIFIER» () {
	NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}
@end

@implementation «FILEBASENAMEASIDENTIFIER»

#pragma mark -
#pragma mark Initialization

+ («FILEBASENAMEASIDENTIFIER» *)sharedInstance {
	@synchronized(self) {
		if (!singleton«FILEBASENAMEASIDENTIFIER») {
			singleton«FILEBASENAMEASIDENTIFIER» = [[«FILEBASENAMEASIDENTIFIER» alloc] init];
		}
	}
	return singleton«FILEBASENAMEASIDENTIFIER»;
}

#pragma mark -
#pragma mark Core Data configuration

- (NSManagedObjectContext *)managedObjectContext {
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
		
		//Undo Support
        NSUndoManager *localUndoManager = [[NSUndoManager  alloc] init];
        [managedObjectContext_ setUndoManager:localUndoManager];
        [localUndoManager release];
		
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"«PROJECTNAME»" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return managedObjectModel_;
}

#pragma mark -
#pragma mark Undo manager

- (NSUndoManager *)undoManager {
	return [self.managedObjectContext undoManager];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"«PROJECTNAME».sqlite"];
    NSURL *storeURL = [NSURL fileURLWithPath:storePath];
    
    NSError *error = nil;
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return persistentStoreCoordinator_;
}


#pragma mark -
#pragma mark Application's Documents directory

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [managedObjectContext_ release];
    [managedObjectModel_ release];
    [persistentStoreCoordinator_ release];
    
	[super dealloc];
}

@end

