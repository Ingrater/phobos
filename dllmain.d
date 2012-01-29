module dllmain;
import core.sys.windows.windows;
import core.stdc.stdio;

extern (Windows) 
BOOL DllMain(HINSTANCE hInstance, ULONG ulReason, LPVOID pvReserved) 
{
  switch(ulReason)
  {
    case DLL_PROCESS_ATTACH:
      printf("phobos loaded\n");
      break;
    case DLL_PROCESS_DETACH:
      printf("phobos unloaded\n");
      break;
    default:
      return false;
  }
  return true;
}