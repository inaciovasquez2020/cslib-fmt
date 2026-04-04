from dataclasses import dataclass

@dataclass(frozen=True)
class EXNILIOConfig:
    path_mode: str = "quick"
