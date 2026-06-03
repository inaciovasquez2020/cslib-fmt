import subprocess

def test_lean_zulip_validator_recommendation_request_posted():
    subprocess.run(
        ["python3", "tools/verify_lean_zulip_validator_recommendation_request_posted.py"],
        check=True,
    )
