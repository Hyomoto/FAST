// Handles the creation and assignement of Gamepad objects. You can safely comment this code out, the
// manager will be instantiated on-demand if a new Gamepad is created.
//	related functions: Gamepad
	GamepadManager();
	
// Assists with storing and processing FAST database files. You can safely comment this code out, the
// manager will be instantiated on-demand if database_load is called.
//	related functions: database_load
	DatabaseManager();
// Provides extra rendering features such as automatic resolution scaling.  You can safely comment this code
// out, and the manager simply will not instantiate.  Calling RenderManager() later will attempt to instantiate
// it during gameplay but it is best to do it before the game begins.  Additionally, while the FASTRender
// object is expected, it can be inherited and extended, or even outright replaced here.
//	related functions: none
	RenderManager()
	