//
//  Folder.h
//  Puttio
//
//  Created by orta therox on 29/03/2012.
//  Copyright (c) 2012 ortatherox.com. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ORDisplayItemProtocol.h"

@interface Folder : NSManagedObject <ORDisplayItemProtocol>

@property (nonatomic, retain) NSString * displayName;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * parentID;
@property (nonatomic, retain) NSString * screenShotURL;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSSet *files;
@property (nonatomic, retain) Folder *parentFolder;
@property (nonatomic, retain) NSSet *subFolders;
@end

@interface Folder (CoreDataGeneratedAccessors)

- (void)addFilesObject:(File *)value;
- (void)removeFilesObject:(File *)value;
- (void)addFiles:(NSSet *)values;
- (void)removeFiles:(NSSet *)values;

- (void)addSubFoldersObject:(Folder *)value;
- (void)removeSubFoldersObject:(Folder *)value;
- (void)addSubFolders:(NSSet *)values;
- (void)removeSubFolders:(NSSet *)values;

@end
