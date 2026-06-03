import subprocess

def test_vardi_directional_referral():
    subprocess.run(
        ["python3", "tools/verify_vardi_directional_referral.py"],
        check=True,
    )
