import subprocess


def test_full_formula_radius_downstream_old_boundary_audit():
    subprocess.run(
        ["python3", "-B", "tools/verify_full_formula_radius_downstream_old_boundary_audit.py"],
        check=True,
    )
