enum InputEventType {
    IEMouseButtonUp;
    IEMouseButtonDown;
    IEMouseMove;
    IEMouseButtonWheel;
    IEMouseVisible;
    IEKeyUp;
    IEKeyDown;
    IEExitRequested;
}

enum InputEventHandler {
    DefaultEventHandler;
    SpecificEventHandler List(InputEventType);
}

id64 InputEventHandler = 0xfc0edefcebcb5878

type ExitRequestedEvent = Null
id64 ExitRequestedEvent = 0x824517eb48d5c653