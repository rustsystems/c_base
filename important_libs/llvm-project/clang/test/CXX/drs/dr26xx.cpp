// RUN: %clang_cc1 -std=c++20 -triple x86_64-unknown-unknown %s -verify

namespace dr2621 { // dr2621: yes
enum class E { a };
namespace One {
using E_t = E;
using enum E_t; // typedef ok
auto v = a;
}
namespace Two {
using dr2621::E;
int E; // we see this
using enum E; // expected-error {{unknown type name E}}
}
}

namespace dr2628 { // dr2628: no open
                   // this was reverted for the 16.x release
                   // due to regressions, see the issue for more details:
                   // https://github.com/llvm/llvm-project/issues/60777

template <bool A = false, bool B = false>
struct foo {
  // The expected notes below should be removed when dr2628 is fully implemented again
  constexpr foo() requires (!A && !B) = delete; // expected-note {{candidate function [with A = false, B = false]}} #DR2628_CTOR
  constexpr foo() requires (A || B) = delete; // expected-note {{candidate function [with A = false, B = false]}}
};

void f() {
  // The FIXME's below should be the expected errors when dr2628 is
  // fully implemented again.
  // FIXME-expected-error {{call to deleted}}
  foo fooable; // expected-error {{ambiguous deduction for template arguments of 'foo'}}
  // FIXME-expected-note@#DR2628_CTOR {{marked deleted here}}
}

}

namespace dr2631 { // dr2631: 16
  constexpr int g();
  consteval int f() {
    return g();
  }
  int k(int x = f()) {
    return x;
  }
  constexpr int g() {
    return 42;
  }
  int test() {
    return k();
  }
}

namespace dr2635 { // dr2635: 16
template<typename T>
concept UnaryC = true;
template<typename T, typename U>
concept BinaryC = true;

struct S{ int i, j; };
S get_S();

template<typename T>
T get_T();

void use() {
  // expected-error@+1{{decomposition declaration cannot be declared with constrained 'auto'}}
  UnaryC auto [a, b] = get_S();
  // expected-error@+1{{decomposition declaration cannot be declared with constrained 'auto'}}
  BinaryC<int> auto [c, d] = get_S();
}

template<typename T>
void TemplUse() {
  // expected-error@+1{{decomposition declaration cannot be declared with constrained 'auto'}}
  UnaryC auto [a, b] = get_T<T>();
  // expected-error@+1{{decomposition declaration cannot be declared with constrained 'auto'}}
  BinaryC<T> auto [c, d] = get_T<T>();
}
}

  // dr2636: na

namespace dr2640 { // dr2640: 16

int \N{Λ} = 0; //expected-error {{'Λ' is not a valid Unicode character name}} \
               //expected-error {{expected unqualified-id}}
const char* emoji = "\N{🤡}"; // expected-error {{'🤡' is not a valid Unicode character name}} \
                              // expected-note 5{{did you mean}}

#define z(x) 0
#define dr2640_a z(
int x = dr2640_a\N{abc}); // expected-error {{'abc' is not a valid Unicode character name}}
int y = dr2640_a\N{LOTUS}); // expected-error {{character <U+1FAB7> not allowed in an identifier}} \
                     // expected-error {{use of undeclared identifier 'dr2640_a🪷'}} \
                     // expected-error {{extraneous ')' before ';'}}
}

  // dr2642: na

namespace dr2644 { // dr2644: yes

auto z = [a = 42](int a) { // expected-error {{a lambda parameter cannot shadow an explicitly captured entity}} \
                           // expected-note {{variable 'a' is explicitly captured here}}
     return 1;
};

}

namespace dr2650 { // dr2650: yes
template <class T, T> struct S {};
template <class T> int f(S<T, T{}>*); // expected-note {{type 'X' of non-type template parameter is not a structural type}}
class X {
  int m;
};
int i0 = f<X>(0);   //expected-error {{no matching function for call to 'f'}}
}

namespace dr2654 { // dr2654: 16
void f() {
    int neck, tail;
    volatile int brachiosaur;
    brachiosaur += neck;                // OK
    brachiosaur -= neck;                // OK
    brachiosaur |= neck;                // OK
}
}

namespace dr2681 { // dr2681: 17
using size_t = decltype(sizeof(int));

template<class T, size_t N>
struct H {
  T array[N];
};
template<class T, size_t N>
struct I {
  volatile T array[N];
};
template<size_t N>
struct J {  // expected-note 3{{candidate}}
  unsigned char array[N];
};

H h = { "abc" };
I i = { "def" };
static_assert(__is_same(decltype(h), H<char, 4>));  // Not H<const char, 4>
static_assert(__is_same(decltype(i), I<char, 4>));

J j = { "ghi" };  // expected-error {{no viable constructor or deduction guide}}
}

namespace dr2672 { // dr2672: 18 open
template <class T>
void f(T) requires requires { []() { T::invalid; } (); }; // expected-error{{type 'int' cannot be used prior to '::'}}
                                                          // expected-note@-1{{while substituting into a lambda expression here}}
                                                          // expected-note@-2{{in instantiation of requirement here}}
                                                          // expected-note@-3{{while substituting template arguments into constraint expression here}}
void f(...);

template <class T>
void bar(T) requires requires {
   decltype([]() -> T {})::foo();
};
void bar(...);

void m() {
  f(0); // expected-note {{while checking constraint satisfaction for template 'f<int>' required here}}
        // expected-note@-1 {{in instantiation of function template specialization}}
  bar(0);
}
}
