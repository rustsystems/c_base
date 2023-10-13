//********************************************************
// The following code example is taken from the book
//  C++20 - The Complete Guide
//  by Nicolai M. Josuttis (www.josuttis.com)
//  http://www.cppstd20.com
//
// The code is licensed under a
//  Creative Commons Attribution 4.0 International License
//  http://creativecommons.org/licenses/by/4.0/
//********************************************************


#include <iostream>
#include <coroutine>

// coroutine interface to deal with a simple task
// - providing resume() to resume it
class CoroTask {
 public:
  // native coroutine handle and its promise type:
  struct promise_type;
  using CoroHdl = std::coroutine_handle<promise_type>;
  CoroHdl hdl;          // coroutine handle

  // helper type for state and customization:
  struct promise_type {
    promise_type() {
      std::cout << "       promise: constructor\n";
    }
    auto get_return_object() {       // init and return the coroutine interface
      std::cout << "       promise: get_return_object()\n";
      return CoroTask{CoroHdl::from_promise(*this)};
    }
    auto initial_suspend() {         // initial suspend point
      std::cout << "       promise: initial_suspend()\n";
      return std::suspend_always{};  // - suspend immediately
    }
    void unhandled_exception() {     // deal with exceptions
      std::cout << "       promise: unhandled_exception()\n";
      std::terminate();              // - terminate the program
    }
    void return_void() {             // deal with the end or co_return;
      std::cout << "       promise: return_void()\n";
    }
    auto final_suspend() noexcept {  // final suspend point
      std::cout << "       promise: final_suspend()\n";
      return std::suspend_always{};  // - suspend immediately
    }
  };

  // constructor and destructor:
  CoroTask(auto h)
   : hdl{h} {           // store coroutine handle in interface
      std::cout << "         CoroTask: construct\n";
  }
  ~CoroTask() {
    std::cout << "         CoroTask: destruct\n";
    if (hdl) {
      hdl.destroy();    // destroy coroutine handle
    }
  }
  // don't copy or move:
  CoroTask(const CoroTask&) = delete;
  CoroTask& operator=(const CoroTask&) = delete;

  // API to resume the coroutine
  // - returns whether there is still something to process
  bool resume() const {
    std::cout << "         CoroTask: resume()\n";
    if (!hdl || hdl.done()) {
      return false;                     // nothing (more) to process
    }
    hdl.resume();                       // RESUME
    return !hdl.done();
  }
};

class Awaiter {
  inline static int maxId = 0;
  int id;
 public:
  Awaiter() : id{++maxId} {
    std::cout << "        AWAITER" << id << ": ==> constructor\n";
  }
  ~Awaiter() {
    std::cout << "        AWAITER" << id << ": <== destructor\n";
  }
  // don't copy or move:
  Awaiter(const Awaiter&) = delete;
  Awaiter& operator=(const Awaiter&) = delete;

  //constexpr
  bool await_ready() const noexcept {
    std::cout << "        AWAITER" << id << ": await_ready()\n";
    return false; // true: do NOT (try to) suspend
  }

  // - void: do suspend
  // - bool: true: do suspend
  // - handle: resume coro of the handle
  //constexpr
  void await_suspend(auto) const noexcept {
    std::cout << "        AWAITER" << id << ": await_suspend()\n";
  }

  //constexpr
  void await_resume() const noexcept {
    std::cout << "        AWAITER" << id << ": await_resume()\n";
  }
};

CoroTask coro(int max)
{
  std::cout << "  START coro(" << max << ")\n";
  for (int i = 1; i <= max; ++i) {
    std::cout << "   CORO: " << i << '/' << max << '\n';
    co_await Awaiter{};                 // SUSPEND
    std::cout << "  CONTINUE coro(" << max << ")\n";
  }
  std::cout << "  END coro(" << max << ")\n";
}

int main()
{
  // start coroutine:
  std::cout << "**** start coro()\n";
  auto coroTask = coro(3);              // init coroutine
  std::cout << "**** coro() started\n";

  // loop to resume the coroutine until it is done:
  std::cout << "\n**** resume coro() in loop\n";
  while (coroTask.resume()) {           // RESUME
    std::cout << "**** coro() suspended\n";
    //...
    std::cout << "\n**** resume coro() in loop\n";
  }

  std::cout << "\n**** coro() loop done\n";
}

