import subprocess


def test_full_formula_radius_historical_boundary_supersession_notes():
    subprocess.run(
        ["python3", "-B", "tools/verify_full_formula_radius_historical_boundary_supersession_notes.py"],
        check=True,
    )
