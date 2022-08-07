#include <windows.h>
#include <iostream>
#include <tlhelp32.h>

unsigned long long lv = 0x7F; //  7C --> 7F

DWORD GetPID(const char* pn)
{
	DWORD procId = 0;
	HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

	if (hSnap != INVALID_HANDLE_VALUE)
	{
		PROCESSENTRY32 pE;
		pE.dwSize = sizeof(pE);

		if (Process32First(hSnap, &pE))
		{
			if (!pE.th32ProcessID)
				Process32Next(hSnap, &pE);
			do
			{
				if (!_stricmp(pE.szExeFile, pn))
				{
					procId = pE.th32ProcessID;
					break;
				}
			} while (Process32Next(hSnap, &pE));
		}
	}
	CloseHandle(hSnap);
	return procId;
}

uintptr_t GetBaseAddr(DWORD proid, const char* modName)
{
	uintptr_t modBaseAddr = 0;
	HANDLE hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE | TH32CS_SNAPMODULE32, proid);
	if (hSnap != INVALID_HANDLE_VALUE)
	{
		MODULEENTRY32 modEntry;
		modEntry.dwSize = sizeof(modEntry);
		if (Module32First(hSnap, &modEntry))
		{
			do
			{
				if (!_stricmp(modEntry.szModule, modName))
				{
					modBaseAddr = (uintptr_t)modEntry.modBaseAddr;
					break;
				}
			} while (Module32Next(hSnap, &modEntry));
		}
	}
	CloseHandle(hSnap);
	return modBaseAddr;
}

int wmain() {

	DWORD tpid = 0;
	HANDLE hw = OpenProcess(PROCESS_ALL_ACCESS, 0, tpid = GetPID("HackTheBox CubeMadness1.exe"));
	if (!hw)
	{
		printf("not found");
		exit(-1);
	}
	uintptr_t base = GetBaseAddr(tpid, "GameAssembly.dll");
	if (!hw)
	{
		printf("not found");
		CloseHandle(hw);
		exit(-1);
	}

	if (!WriteProcessMemory(hw, (LPVOID)(base + 0xA681FB), &lv, 1, 0))
	{
		CloseHandle(hw);
		exit(-1);
	}

	return 0;
}
