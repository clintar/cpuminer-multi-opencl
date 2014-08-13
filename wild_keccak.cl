// Written by mbk, improved on Nvidia by Wolf (50%+ better on 750Ti)

inline ulong ROTL641(const ulong x) { return (x << 1 | x >> 63); }
inline ulong ROTL64_1(const ulong x, const uint y) { return (x << y | x >> (64-y)); }

#define state0 vstate0.s0
#define state1 vstate0.s1
#define state2 vstate0.s2
#define state3 vstate0.s3

#define state4 vstate4.s0
#define state5 vstate4.s1
#define state6 vstate4.s2
#define state7 vstate4.s3

#define state8 vstate8.s0
#define state9 vstate8.s1
#define state10 vstate8.s2
#define state11 vstate8.s3

#define state12 vstate12.s0
#define state13 vstate12.s1
#define state14 vstate12.s2
#define state15 vstate12.s3

#define state16 vstate16.s0
#define state17 vstate16.s1
#define state18 vstate16.s2
#define state19 vstate16.s3

#define state20 vstate20.s0
#define state21 vstate20.s1
#define state22 vstate20.s2
#define state23 vstate20.s3

#define m0 m.s0
#define m1 m.s1
#define m2 m.s2
#define m3 m.s3


#define RND() \
		m0 = state0 ^ state5 ^ state10 * state15 * state20 ^ ROTL641(state2 ^ state7 ^ state12 * state17 * state22);\
		m1 = state1 ^ state6 ^ state11 * state16 * state21 ^ ROTL641(state3 ^ state8 ^ state13 * state18 * state23);\
		m2 = state2 ^ state7 ^ state12 * state17 * state22 ^ ROTL641(state4 ^ state9 ^ state14 * state19 * state24);\
		m3 = state3 ^ state8 ^ state13 * state18 * state23 ^ ROTL641(state0 ^ state5 ^ state10 * state15 * state20);\
		m4 = state4 ^ state9 ^ state14 * state19 * state24 ^ ROTL641(state1 ^ state6 ^ state11 * state16 * state21);\
\
		m5 = state1^m0;\
\
		state0 ^= m4;\
		state1 = ROTL64_1(state6^m0, 44);\
		state6 = ROTL64_1(state9^m3, 20);\
		state9 = ROTL64_1(state22^m1, 61);\
		state22 = ROTL64_1(state14^m3, 39);\
		state14 = ROTL64_1(state20^m4, 18);\
		state20 = ROTL64_1(state2^m1, 62);\
		state2 = ROTL64_1(state12^m1, 43);\
		state12 = ROTL64_1(state13^m2, 25);\
		state13 = ROTL64_1(state19^m3,  8);\
		state19 = ROTL64_1(state23^m2, 56);\
		state23 = ROTL64_1(state15^m4, 41);\
		state15 = ROTL64_1(state4^m3, 27);\
		state4 = ROTL64_1(state24^m3, 14);\
		state24 = ROTL64_1(state21^m0,  2);\
		state21 = ROTL64_1(state8^m2, 55);\
		state8 = ROTL64_1(state16^m0, 45);\
		state16 = ROTL64_1(state5^m4, 36);\
		state5 = ROTL64_1(state3^m2, 28);\
		state3 = ROTL64_1(state18^m2, 21);\
		state18 = ROTL64_1(state17^m1, 15);\
		state17 = ROTL64_1(state11^m0, 10);\
		state11 = ROTL64_1(state7^m1,  6);\
		state7 = ROTL64_1(state10^m4,  3);\
		state10 = ROTL64_1(      m5,  1);\
\
		m5 = state0; m6 = state1; state0 = bitselect(state0^state2,state0,state1); state1 = bitselect(state1^state3,state1,state2); state2 = bitselect(state2^state4,state2,state3); state3 = bitselect(state3^m5,state3,state4); state4 = bitselect(state4^m6,state4,m5);\
		m5 = state5; m6 = state6; state5 = bitselect(state5^state7,state5,state6); state6 = bitselect(state6^state8,state6,state7); state7 = bitselect(state7^state9,state7,state8); state8 = bitselect(state8^m5,state8,state9); state9 = bitselect(state9^m6,state9,m5);\
		m5 = state10; m6 = state11; state10 = bitselect(state10^state12,state10,state11); state11 = bitselect(state11^state13,state11,state12); state12 = bitselect(state12^state14,state12,state13); state13 = bitselect(state13^m5,state13,state14); state14 = bitselect(state14^m6,state14,m5);\
		m5 = state15; m6 = state16; state15 = bitselect(state15^state17,state15,state16); state16 = bitselect(state16^state18,state16,state17); state17 = bitselect(state17^state19,state17,state18); state18 = bitselect(state18^m5,state18,state19); state19 = bitselect(state19^m6,state19,m5);\
		m5 = state20; m6 = state21; state20 = bitselect(state20^state22,state20,state21); state21 = bitselect(state21^state23,state21,state22); state22 = bitselect(state22^state24,state22,state23); state23 = bitselect(state23^m5,state23,state24); state24 = bitselect(state24^m6,state24,m5);\
\
		state0 ^= 1;

#define LASTRND1() \
		m0 = state0 ^ state5 ^ state10 * state15 * state20 ^ ROTL641(state2 ^ state7 ^ state12 * state17 * state22);\
		m1 = state1 ^ state6 ^ state11 * state16 * state21 ^ ROTL641(state3 ^ state8 ^ state13 * state18 * state23);\
		m2 = state2 ^ state7 ^ state12 * state17 * state22 ^ ROTL641(state4 ^ state9 ^ state14 * state19 * state24);\
		m3 = state3 ^ state8 ^ state13 * state18 * state23 ^ ROTL641(state0 ^ state5 ^ state10 * state15 * state20);\
		m4 = state4 ^ state9 ^ state14 * state19 * state24 ^ ROTL641(state1 ^ state6 ^ state11 * state16 * state21);\
\
		state0 ^= m4;\
		state1 = ROTL64_1(state6^m0, 44);\
		state2 = ROTL64_1(state12^m1, 43);\
		state4 = ROTL64_1(state24^m3, 14);\
		state3 = ROTL64_1(state18^m2, 21);\
\
		m5 = state0; state0 = bitselect(state0^state2,state0,state1); state1 = bitselect(state1^state3,state1,state2); state2 = bitselect(state2^state4,state2,state3); state3 = bitselect(state3^m5,state3,state4);\
		state0 ^= 1;

#define LASTRND2() \
		m5 = state4 ^ state9 ^ state14 * state19 * state24; \
		m2 = state2 ^ state7 ^ state12 * state17 * state22 ^ ROTL641(m5);\
		m3 = state3 ^ state8 ^ state13 * state18 * state23 ^ ROTL641(state0 ^ state5 ^ state10 * state15 * state20);\
		m4 = m5 ^ ROTL641(state1 ^ state6 ^ state11 * state16 * state21);\
		\
		state0 ^= m4;\
		state4 = ROTL64_1(state24^m3, 14);\
		state3 = ROTL64_1(state18^m2, 21);\
		state3 = bitselect(state3^state0,state3,state4);
	
#define MIX(vstate) vstate ^= sp[vstate.s0 % size] ^ sp[vstate.s1 % size] ^ sp[vstate.s2 % size] ^ sp[vstate.s3 % size];

#define MIX_ALL MIX(vstate0); MIX(vstate4); MIX(vstate8); MIX(vstate12); MIX(vstate16); MIX(vstate20);

__kernel void search(__global const ulong *restrict in, __global ulong *restrict output, __global const ulong4 *restrict sp, const uint size, const ulong target)
{
	ulong nonce = get_global_id(0);
	
	ulong4 vstate0 = (ulong4)((nonce << 8) + (in[0] & 0xFF), (in[1] & 0xFFFFFFFFFFFFFF00U), in[2], in[3]);
	ulong4 vstate4 = (ulong4)(in[4], in[5], in[6], in[7]);
	ulong4 vstate8 = (ulong4)(in[8], in[9], (in[10] & 0xFF) + 256, 0);
	ulong4 vstate12 = 0;
	ulong4 vstate16 = (ulong4)(0x8000000000000000U, 0, 0, 0);
	ulong4 vstate20 = 0;
	ulong state24 = 0;
		
	ulong4 m;
	ulong m4,m5, m6;
	
	for(int i = 0; i < 23; ++i) 
	{
		RND();
		MIX_ALL;
	}
	
	LASTRND1();

	vstate4 = (ulong4)(1, 0, 0, 0);
	vstate8 = 0;
	vstate12 = 0;
	vstate16 = (ulong4)(0x8000000000000000U, 0, 0, 0);
	vstate20 = 0;
	state24 = 0;
	
	for(int i = 0; i < 23; ++i) 
	{
		RND();
		MIX_ALL;
	}
	
	LASTRND2();

    if (state3 <= target)
	    output[output[0x0F]++] = nonce;
}