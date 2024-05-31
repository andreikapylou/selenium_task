1. Create python venv and activate it:
```bash
python -m venv venv
source venv/bin/activate
```
2. Install the packages:
```bash
pip install robotframework selenium robotframework-selenium2library webdrivermanager
```
3. Execute the tests
```bash
robot test_suites/test_submit.robot
```