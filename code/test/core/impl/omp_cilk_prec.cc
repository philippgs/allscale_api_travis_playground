
#define OMP_CILK_IMPL
#include "../prec.cc"

TEST(Parec,ImplCheck) {
	EXPECT_EQ("OpenMP/Cilk", PAREC_IMPL);
}