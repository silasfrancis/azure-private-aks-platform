import bcrypt


def _truncate_password_bytes(password: str) -> bytes:
    """
    Safely truncate password to 72 bytes without breaking UTF-8 encoding.
    Returns bytes ready for bcrypt.
    """
    password_bytes = password.encode('utf-8')
    
    # If within limit, return as-is
    if len(password_bytes) <= 72:
        return password_bytes
    
    # Truncate character by character from the end until we're under 72 bytes
    # This ensures we never break a multi-byte UTF-8 character
    truncated = password
    while len(truncated.encode('utf-8')) > 72:
        truncated = truncated[:-1]
    
    return truncated.encode('utf-8')


def get_password_hash(password: str) -> str:
    """
    Convert user password to hash string.
    Truncate to 72 bytes for bcrypt compatibility.
    """
    password_bytes = _truncate_password_bytes(password)
    hashed = bcrypt.hashpw(password_bytes, bcrypt.gensalt())
    return hashed.decode('utf-8')


def verify_password(plain_password: str, hashed_password: str) -> bool:
    """
    Verify password against hash.
    Truncate to 72 bytes using the same logic as hashing.
    """
    password_bytes = _truncate_password_bytes(plain_password)
    hashed_bytes = hashed_password.encode('utf-8')
    return bcrypt.checkpw(password_bytes, hashed_bytes)