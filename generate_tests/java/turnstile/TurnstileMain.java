import thejava.turnstile.*;

public class TurnstileMain implements JavaTurnstileContext
{
  public void unlock()
  {
    System.out.println("unlock");
  }

  public void alarm()
  {
    System.out.println("alarm");
  }

  public void thanks()
  {
    System.out.println("thanks");
  }

  public void lock()
  {
    System.out.println("lock");
  }

  public static void main(String[] args)
  {
    JavaTurnstile sm = new JavaTurnstile(new TurnstileMain());
    sm.pass();
    sm.coin();
    sm.coin();
    sm.coin();
    sm.pass();
  }
}
