//
//  CommonMacros.h
//  «PROJECTNAME»
//
//  Created by «FULLUSERNAME» on «DATE».
//  Copyright «YEAR» «ORGANIZATIONNAME». Some Rights Reserved.
//


// Blatantly picked up from: http://blog.wilshipley.com/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL IsEmpty(id thing) {
    return thing == nil
	|| ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
	|| ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}


// A check to see if we're running on an iPad.
// Blatantly picked up from: http://cocoawithlove.com/2010/07/tips-tricks-for-conditional-ios3-ios32.html
static inline BOOL IsIPad() {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
    if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)] && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
		return YES;
	} else
#endif
    {
       	return NO;
    }
}
