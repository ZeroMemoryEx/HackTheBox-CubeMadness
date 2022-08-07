[ENABLE]
aobscanmodule(INJECT,GameAssembly.dll,7C 14 48 85 C9) // should be unique
alloc(newmem,$1000,INJECT)
label(code)
label(return)
newmem:
code:
    add rsp,20
    pop rbx
    jmp GameAssembly.dll+214F10
    test rcx,rcx
    jmp return

INJECT:
  jmp newmem
return:
registersymbol(INJECT)

[DISABLE]

INJECT:
  db 7C 14 48 85 C9
unregistersymbol(INJECT)
dealloc(newmem)

{

GameAssembly.dll+A681CC: F6 80 33 01 00 00 04  - test byte ptr [rax+00000133],04
GameAssembly.dll+A681D3: 74 18                 - je GameAssembly.dll+A681ED
GameAssembly.dll+A681D5: 83 B8 E0 00 00 00 00  - cmp dword ptr [rax+000000E0],00
GameAssembly.dll+A681DC: 75 0F                 - jne GameAssembly.dll+A681ED
GameAssembly.dll+A681DE: 48 8B C8              - mov rcx,rax
GameAssembly.dll+A681E1: E8 3A 84 67 FF        - call GameAssembly.il2cpp_runtime_class_init
GameAssembly.dll+A681E6: 48 8B 05 7B 3A 29 00  - mov rax,[GameAssembly.dll+CFBC68]
GameAssembly.dll+A681ED: 48 8B 80 B8 00 00 00  - mov rax,[rax+000000B8]
GameAssembly.dll+A681F4: 48 8B 4B 18           - mov rcx,[rbx+18]
GameAssembly.dll+A681F8: 83 38 14              - cmp dword ptr [rax],14
GameAssembly.dll+A681FB: 7C 14                 - jl GameAssembly.dll+A68211
GameAssembly.dll+A681FD: 48 85 C9              - test rcx,rcx
GameAssembly.dll+A68200: 74 23                 - je GameAssembly.dll+A68225
GameAssembly.dll+A68202: 45 33 C0              - xor r8d,r8d
GameAssembly.dll+A68205: B2 01                 - mov dl,01
GameAssembly.dll+A68207: 48 83 C4 20           - add rsp,20
GameAssembly.dll+A6820B: 5B                    - pop rbx
GameAssembly.dll+A6820C: E9 FF CC 7A FF        - jmp GameAssembly.dll+214F10
GameAssembly.dll+A68211: 48 85 C9              - test rcx,rcx
GameAssembly.dll+A68214: 74 0F                 - je GameAssembly.dll+A68225
GameAssembly.dll+A68216: 45 33 C0              - xor r8d,r8d
}
