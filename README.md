Airflow learning project.

### Command to generate the Security Key:

```python
python3 -c "import secrets; print(secrets.token_urlsafe(32))"
```

### Command to generate the Fernet Key:

```python
python3 -c "import base64, os; print(base64.urlsafe_b64encode(os.urandom(32)).decode())"
```


