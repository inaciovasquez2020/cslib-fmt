import subprocess


def test_full_formula_radius_construction():
    subprocess.run(
        ["python3", "-B", "tools/verify_full_formula_radius_construction.py"],
        check=True,
    )
