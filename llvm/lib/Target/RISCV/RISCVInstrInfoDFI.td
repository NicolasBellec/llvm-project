let hasSideEffects = 1, mayLoad = 0, mayStore = 1 in
def PseudoDFI_STORE : Pseudo<(outs), (ins simm12:$tag, GPR:$rs1, simm12:$imm12), [],
          "dfi_s", "$tag, ${imm12}(${rs1})" >;

let hasSideEffects = 1, mayLoad = 1, mayStore = 0 in
def PseudoDFI_LOAD : Pseudo<(outs GPR:$add), (ins simm12:$tag, GPR:$rs1, simm12:$imm12), [],
          "dfi_l", "$add, $tag, ${imm12}(${rs1})" >;

def : Pat<(int_dfi_store_tag imm:$tag, GPR:$mem),
          (PseudoDFI_STORE simm12:$tag, GPR:$mem, 0)>;
def : Pat<(int_dfi_store_tag imm:$tag, AddrFI:$mem),
          (PseudoDFI_STORE simm12:$tag, AddrFI:$mem, 0)>;
def : Pat<(int_dfi_store_tag imm:$tag, (add GPR:$mem, simm12:$imm12)),
          (PseudoDFI_STORE simm12:$tag, GPR:$mem, simm12:$imm12)>;
def : Pat<(int_dfi_store_tag imm:$tag, (add AddrFI:$rs1, simm12:$imm12)),
          (PseudoDFI_STORE simm12:$tag, AddrFI:$rs1, simm12:$imm12)>;
def : Pat<(int_dfi_store_tag imm:$tag, (IsOrAdd AddrFI:$rs1, simm12:$imm12)),
          (PseudoDFI_STORE simm12:$tag, AddrFI:$rs1, simm12:$imm12)>;

def : Pat<(int_dfi_load_tag imm:$tag, GPR:$mem),
          (PseudoDFI_LOAD simm12:$tag, GPR:$mem, 0)>;
def : Pat<(int_dfi_load_tag imm:$tag, AddrFI:$mem),
          (PseudoDFI_LOAD simm12:$tag, AddrFI:$mem, 0)>;
def : Pat<(int_dfi_load_tag imm:$tag, (add GPR:$mem, simm12:$imm12)),
          (PseudoDFI_LOAD simm12:$tag, GPR:$mem, simm12:$imm12)>;
def : Pat<(int_dfi_load_tag imm:$tag, (add AddrFI:$rs1, simm12:$imm12)),
          (PseudoDFI_LOAD simm12:$tag, AddrFI:$rs1, simm12:$imm12)>;
def : Pat<(int_dfi_load_tag imm:$tag, (IsOrAdd AddrFI:$rs1, simm12:$imm12)),
          (PseudoDFI_LOAD simm12:$tag, AddrFI:$rs1, simm12:$imm12)>;
