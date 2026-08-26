
func TestGenerateCases(t *testing.T) {
	type testcase struct {
		head uint64
		want ID
	}
	tests := []struct {
		name    string
		config  ctypes.ChainConfigurator
		genesis common.Hash
	}{
		{"Ethereum Classic Mainnet (ETC)",
			params.ClassicChainConfig,
			params.MainnetGenesisHash,
		},
		{
			"Kotti",
			params.KottiChainConfig,
			params.KottiGenesisHash,
		},
		{
			"Mordor",
			params.MordorChainConfig,
			params.MordorGenesisHash,
		},
		{
			"Morden",
			&paramtypes.MultiGethChainConfig{
				EIP2FBlock: big.NewInt(494000),
				EIP150Block: big.NewInt(1783000),
				EIP155Block: big.NewInt(1915000),
				ECIP1017FBlock: big.NewInt(2000000),
				ECIP1017EraRounds: big.NewInt(2000000),
				DisposalBlock: big.NewInt(2300000),
				EIP198FBlock: big.NewInt(4729274), // Atlantis
				EIP1052FBlock: big.NewInt(5000381), // Agharta
			},
			common.HexToHash("0cd786a2425d16f152c658316c423e6ce1181e15c3295826d7c9904cba9ce303"),
		},
	}
	for _, tt := range tests {
		cs := []uint64{0}
		for _, f := range gatherForks(tt.config) {
			cs = append(cs, f-1, f, f+1)
		}
		fmt.Printf("##### %s\n", tt.name)
		fmt.Println()
		fmt.Printf("- Genesis Hash: `0x%x`\n", tt.genesis)
		forks := gatherForks(tt.config)
		forksS := []string{}
		for _, fi := range forks {
			forksS = append(forksS, strconv.Itoa(int(fi)))
		}
		fmt.Printf("- Forks: `%s`\n", strings.Join(forksS, "`,`"))
		fmt.Println()
		fmt.Println("| Head Block Number | `FORK_HASH` | `FORK_NEXT` | RLP Encoded (Hex) |")
		fmt.Println("| --- | --- | --- | --- |")
		for _, c := range cs {
			id := newID(tt.config, tt.genesis, c)
			isCanonical := false
			for _, fi := range forks {
				if c == fi {
					isCanonical = true
				}
			}
			r, _ := rlp.EncodeToBytes(id)
			if isCanonical {
				fmt.Printf("| __head=%d__ | FORK_HASH=%x | FORK_NEXT=%d | %x |\n", c, id.Hash, id.Next, r)

			} else {
				fmt.Printf("| head=%d | FORK_HASH=%x | FORK_NEXT=%d | %x |\n", c, id.Hash, id.Next, r)
			}
		}
		fmt.Println()
		fmt.Println()
	}
}