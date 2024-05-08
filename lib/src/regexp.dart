// Match: @username
final usernamePattern = RegExp(r"\B@\w+\b(?!\')");

// Match: http://google.com, https://google.com, google.com, www.google.com
final urlPattern = RegExp(r'\b((https?:\/\/[^\s]+)|(www\.[^\s]+)|([^\s]+\.[^\s]+))\b');

// Matches email addresses
final emailPattern = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b');

// Matches hashtags that start with a “#” symbol
final hashtagPattern = RegExp(r'\B#\w\w+');

// Matches phone numbers.
final phoneNumberPattern = RegExp(r'\b\d{3}[-.]?\d{3}[-.]?\d{4}\b');

// Matches dates in the format MM/DD/YYYY.
final datePattern = RegExp(r'\b(0[1-9]|1[0-2])/(0[1-9]|1\d|2\d|3[01])/((19|20)\d\d)\b');
