import logging
import os
from datetime import datetime
from typing import Any, Dict
from pythonjsonlogger import jsonlogger

class _AwsLambdaJsonFormatter(jsonlogger.JsonFormatter):  # type: ignore
    '''Custom json log formatter that adds lambda context information.'''

    def __init__(self) -> None:
        super().__init__()

    def add_fields(self, log_record: Dict[str, Any], record: logging.LogRecord, message_dict: Dict[str, Any]) -> None:
        super().add_fields(log_record, record, message_dict)

        log_record['timestamp'] = datetime.now().isoformat()
        log_record['level'] = record.levelname

def setup_logger() -> None:
    '''Configure json logging'''
    root_logger = logging.getLogger()
    root_logger.setLevel(os.getenv('LOG_LEVEL', 'INFO'))

    # Write logs as json
    formatter = _AwsLambdaJsonFormatter()
    if root_logger.hasHandlers():
        for handler in root_logger.handlers:
            handler.setFormatter(formatter)
    else:
        __log_handler = logging.StreamHandler()
        root_logger.addHandler(__log_handler)
        __log_handler.setFormatter(formatter)

setup_logger()
_logger = logging.getLogger(__name__)

def on_file_created(event, context) -> None:
    _logger.info('handle s3 event', extra=event)
