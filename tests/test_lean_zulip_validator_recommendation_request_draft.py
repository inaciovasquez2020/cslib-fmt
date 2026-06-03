import subprocess

def test_lean_zulip_validator_recommendation_request_draft():
    subprocess.run(
        ["python3", "tools/verify_lean_zulip_validator_recommendation_request_draft.py"],
        check=True,
    )
