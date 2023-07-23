import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";
actor DBank {
  stable var currentValue : Float = 300;
  // currentValue := 300;
  // start time
  stable var startTime = Time.now();
  // Debug.print(debug_show(currentValue));
  Debug.print(debug_show (startTime));
  public func topUp(amount : Float) {
    currentValue += amount;
    // Debug.print(debug_show (currentValue));
  };
  public func withdraw(amount : Float) {
    let tempValue : Float = currentValue -amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("amount will be negative");
    };
  };
  // topUp();
  public query func checkBalance() : async Float {
    return currentValue;
  };

  // compoind interest rate function
  public func compound() {
    // to calculate the difference in time
    let currentTime = Time.now();
    // how many nanoseconds have elapsed
    let timeElapsedNS = currentTime - startTime;
    // time elapsed in seconds
    let timeElapsedS = timeElapsedNS / 1000000000;
    // calculate the compound interest value
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    // reset th start time to calculate the compound interest
    startTime := currentTime;
  };
};
