namespace CslibFmt
namespace FormalContent

theorem nat_add_comm_core (a b : Nat) : a + b = b + a :=
  Nat.add_comm a b

theorem nat_add_assoc_core (a b c : Nat) : (a + b) + c = a + (b + c) :=
  Nat.add_assoc a b c

theorem nat_add_right_cancel_core {a b c : Nat} (h : a + c = b + c) : a = b :=
  Nat.add_right_cancel h

end FormalContent
end CslibFmt
