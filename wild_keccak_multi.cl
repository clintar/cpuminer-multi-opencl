#define ARGS_25(x) x ## 0, x ## 1, x ## 2, x ## 3, x ## 4, x ## 5, x ## 6, x ## 7, x ## 8, x ## 9, x ## 10, x ## 11, x ## 12, x ## 13, x ## 14, x ## 15, x ## 16, x ## 17, x ## 18, x ## 19, x ## 20, x ## 21, x ## 22, x ## 23, x ## 24

uint2 ROTL64_1(const uint2 x, const uint y)
{
	return (uint2)((x.x<<y)^(x.y>>(32-y)),(x.y<<y)^(x.x>>(32-y)));
}
uint2 ROTL64_2(const uint2 x, const uint y)
{
	return (uint2)((x.y<<y)^(x.x>>(32-y)),(x.x<<y)^(x.y>>(32-y)));
}
ulong ROTL641(const ulong x) { return (x << 1 | x >> 63); }

#define UL(x) *((ulong*)x)

#define RND(i) \
		UL(&m0) = UL(&state0) ^ UL(&state5) ^ UL(&state10) * UL(&state15) * UL(&state20) ^ ROTL641(UL(&state2) ^ UL(&state7) ^ UL(&state12) * UL(&state17) * UL(&state22));\
		UL(&m1) = UL(&state1) ^ UL(&state6) ^ UL(&state11) * UL(&state16) * UL(&state21) ^ ROTL641(UL(&state3) ^ UL(&state8) ^ UL(&state13) * UL(&state18) * UL(&state23));\
		UL(&m2) = UL(&state2) ^ UL(&state7) ^ UL(&state12) * UL(&state17) * UL(&state22) ^ ROTL641(UL(&state4) ^ UL(&state9) ^ UL(&state14) * UL(&state19) * UL(&state24));\
		UL(&m3) = UL(&state3) ^ UL(&state8) ^ UL(&state13) * UL(&state18) * UL(&state23) ^ ROTL641(UL(&state0) ^ UL(&state5) ^ UL(&state10) * UL(&state15) * UL(&state20));\
		UL(&m4) = UL(&state4) ^ UL(&state9) ^ UL(&state14) * UL(&state19) * UL(&state24) ^ ROTL641(UL(&state1) ^ UL(&state6) ^ UL(&state11) * UL(&state16) * UL(&state21));\
\
		m5 = state1^m0;\
\
		state0 ^= m4;\
		state1 = ROTL64_2(state6^m0, 12);\
		state6 = ROTL64_1(state9^m3, 20);\
		state9 = ROTL64_2(state22^m1, 29);\
		state22 = ROTL64_2(state14^m3, 7);\
		state14 = ROTL64_1(state20^m4, 18);\
		state20 = ROTL64_2(state2^m1, 30);\
		state2 = ROTL64_2(state12^m1, 11);\
		state12 = ROTL64_1(state13^m2, 25);\
		state13 = ROTL64_1(state19^m3,  8);\
		state19 = ROTL64_2(state23^m2, 24);\
		state23 = ROTL64_2(state15^m4, 9);\
		state15 = ROTL64_1(state4^m3, 27);\
		state4 = ROTL64_1(state24^m3, 14);\
		state24 = ROTL64_1(state21^m0,  2);\
		state21 = ROTL64_2(state8^m2, 23);\
		state8 = ROTL64_2(state16^m0, 13);\
		state16 = ROTL64_2(state5^m4, 4);\
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
		state0.x ^= 0x00000001;

#define WRITE_DBL(num, x, y) buf[num*threads+thread] = (uint2)(x,y)

__kernel void init(__global const uint* in, __global uint2* buf)
{
	uint nounce = get_global_id(0);
	uint thread = get_global_id(0) - get_global_offset(0);
	uint threads = get_global_size(0);

	uchar r[12];
	r[0] = ((__global uchar*)in)[0];
	*(ulong*)(&r[1]) = nounce;
	r[9] = ((__global uchar*)in)[9];
	r[10] = ((__global uchar*)in)[10];
	r[11] = ((__global uchar*)in)[11];

	WRITE_DBL(0, ((uint*)r)[0], ((uint*)r)[1]);
	WRITE_DBL(1, ((uint*)r)[2], in[3]);
	WRITE_DBL(2, in[4], in[5]);
	WRITE_DBL(3, in[6], in[7]);
	WRITE_DBL(4, in[8], in[9]);
	WRITE_DBL(5, in[10], in[11]);
	WRITE_DBL(6, in[12], in[13]);
	WRITE_DBL(7, in[14], in[15]);
	WRITE_DBL(8, in[16], in[17]);
	WRITE_DBL(9, in[18], in[19]);
	uchar4 last = (uchar4)(((__global uchar*)in)[80], 1, 0, 0);
	WRITE_DBL(10, *((uint*)&last), 0);
	WRITE_DBL(11, 0, 0);
	WRITE_DBL(12, 0, 0);
	WRITE_DBL(13, 0, 0);
	WRITE_DBL(14, 0, 0);
	WRITE_DBL(15, 0, 0);
	WRITE_DBL(16, 0, 0x80000000U);
	WRITE_DBL(17, 0, 0);
	WRITE_DBL(18, 0, 0);
	WRITE_DBL(19, 0, 0);
	WRITE_DBL(20, 0, 0);
	WRITE_DBL(21, 0, 0);
	WRITE_DBL(22, 0, 0);
	WRITE_DBL(23, 0, 0);
	WRITE_DBL(24, 0, 0);
}

__kernel void init2(__global uint2* buf)
{
	uint thread = get_global_id(0) - get_global_offset(0);
	uint threads = get_global_size(0);

	WRITE_DBL(4, 1, 0);
	WRITE_DBL(5, 0, 0);
	WRITE_DBL(6, 0, 0);
	WRITE_DBL(7, 0, 0);
	WRITE_DBL(8, 0, 0);
	WRITE_DBL(9, 0, 0);
	WRITE_DBL(10, 0, 0);
	WRITE_DBL(11, 0, 0);
	WRITE_DBL(12, 0, 0);
	WRITE_DBL(13, 0, 0);
	WRITE_DBL(14, 0, 0);
	WRITE_DBL(15, 0, 0);
	WRITE_DBL(16, 0, 0x80000000U);
	WRITE_DBL(17, 0, 0);
	WRITE_DBL(18, 0, 0);
	WRITE_DBL(19, 0, 0);
	WRITE_DBL(20, 0, 0);
	WRITE_DBL(21, 0, 0);
	WRITE_DBL(22, 0, 0);
	WRITE_DBL(23, 0, 0);
	WRITE_DBL(24, 0, 0);
}

#define READ_S(x) state ## x = buf[x*threads+thread]
#define READ_25 \
		READ_S(0); READ_S(1); READ_S(2); READ_S(3); READ_S(4); READ_S(5); READ_S(6); READ_S(7); READ_S(8); READ_S(9);\
		READ_S(10); READ_S(11); READ_S(12); READ_S(13); READ_S(14); READ_S(15); READ_S(16); READ_S(17); READ_S(18); READ_S(19);\
		READ_S(20); READ_S(21); READ_S(22); READ_S(23); READ_S(24);
#define WRITE_S(x) buf[x*threads+thread] = state ## x
#define WRITE_25 \
		WRITE_S(0); WRITE_S(1); WRITE_S(2); WRITE_S(3); WRITE_S(4); WRITE_S(5); WRITE_S(6); WRITE_S(7); WRITE_S(8); WRITE_S(9);\
		WRITE_S(10); WRITE_S(11); WRITE_S(12); WRITE_S(13); WRITE_S(14); WRITE_S(15); WRITE_S(16); WRITE_S(17); WRITE_S(18); WRITE_S(19);\
		WRITE_S(20); WRITE_S(21); WRITE_S(22); WRITE_S(23); WRITE_S(24);

__kernel void rnd(__global uint2* buf, const uint round)
{
	uint thread = get_global_id(0) - get_global_offset(0);
	uint threads = get_global_size(0);

	uint2 ARGS_25(state);
	uint2 m0,m1,m2,m3,m4,m5,m6;

	READ_25;
	RND(round);
	WRITE_25;
}

#define READ(x, state) state = buf[(x)*threads+thread]
#define WRITE(x, state) buf[(x)*threads+thread] = state
#define GET(s,i) sp[(s % size) * 4 + i]

__kernel void mixin(__global ulong* buf, __global const ulong4* sp, const uint size)
{
	uint threads = get_global_size(0) / 6;
	uint thread = get_global_id(0) % threads;
	uint step = get_global_id(0) / threads * 4;

	ulong s0, s1, s2, s3;
	READ(step, s0);
	READ(step + 1, s1);
	READ(step + 2, s2);
	READ(step + 3, s3);

	ulong4 m = sp[s0 % size] ^ sp[s1 % size] ^ sp[s2 % size] ^ sp[s3 % size];

	WRITE(step, s0 ^ m.s0);
	WRITE(step + 1, s1 ^ m.s1);
	WRITE(step + 2, s2 ^ m.s2);
	WRITE(step + 3, s3 ^ m.s3);

}

__kernel void result(__global ulong*restrict output, __global uint2* buf, const ulong target)
{
	ulong nonce = get_global_id(0);
	uint thread = get_global_id(0) - get_global_offset(0);
	uint threads = get_global_size(0);

	uint2 state3;
	READ(3, state3);
    if (UL(&state3) <= target)
	    output[output[0x0F]++] = nonce;
}
