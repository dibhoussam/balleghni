# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# This file is included in the final Docker image and SHOULD be overridden when
# deploying the image to prod. Settings configured here are intended for use in local
# development environments. Also note that superset_config_docker.py is imported
# as a final step as a means to override "defaults" configured here
#
import logging
import os
from datetime import timedelta
from typing import Optional

from cachelib.file import FileSystemCache
from celery.schedules import crontab

PUBLIC_ROLE_LIKE = "Gamma"

#WTF_CSRF_ENABLED = True
#WTF_CSRF_EXEMPT_LIST = ["superset.dashboards.api.import"]

# Flask-WTF flag for CSRF
WTF_CSRF_ENABLED = False

# Add endpoints that need to be exempt from CSRF protection
#WTF_CSRF_EXEMPT_LIST = ["superset.views.core.log", "superset.charts.api.data", "superset.dashboards.api.import_"]

#SECRET_KEY = 'F1976tvd7DRZT/FJctWMaFCOZRKkfFDZfqOXtlFSG/E1SdWhV9zhR4z2'
#WTF_CSRF_SECRET_KEY = 'F1976tvd7DRZT/FJctWMaFCOZRKkfFDZfqOXtlFSG/E1SdWhV9zhR4z2'

WTF_CSRF_HEADERS = ['X-CSRFToken']

SESSION_COOKIE_SAMESITE = None
SESSION_COOKIE_HTTPONLY = False
SESSION_COOKIE_SECURE = False

#FEATURE_FLAGS = {
#    'VERSIONED_EXPORT': True,
#    'CLIENT_CACHE': False,
#    'ENABLE_EXPLORE_JSON_CSRF_PROTECTION': False
#}
#FEATURE_FLAGS: {
#    "VERSIONED_EXPORT": True,
#}

logger = logging.getLogger()


def get_env_variable(var_name: str, default: Optional[str] = None) -> str:
    """Get the environment variable or raise exception."""
    try:
        return os.environ[var_name]
    except KeyError:
        if default is not None:
            return default
        else:
            error_msg = "The environment variable {} was missing, abort...".format(
                var_name
            )
            raise EnvironmentError(error_msg)


DATABASE_DIALECT = get_env_variable("DATABASE_DIALECT", "postgresql")
DATABASE_USER = get_env_variable("DATABASE_USER", "superset")
DATABASE_PASSWORD = get_env_variable("DATABASE_PASSWORD", "superset")
DATABASE_HOST = get_env_variable("DATABASE_HOST", "superset_db")
DATABASE_PORT = get_env_variable("DATABASE_PORT", 5432)
DATABASE_DB = get_env_variable("DATABASE_DB", "superset")

# The SQLAlchemy connection string.
SQLALCHEMY_DATABASE_URI = "%s://%s:%s@%s:%s/%s" % (
    DATABASE_DIALECT,
    DATABASE_USER,
    DATABASE_PASSWORD,
    DATABASE_HOST,
    DATABASE_PORT,
    DATABASE_DB,
)

REDIS_HOST = get_env_variable("REDIS_HOST", "superset_redis")
REDIS_PORT = get_env_variable("REDIS_PORT", 6379)
REDIS_CELERY_DB = get_env_variable("REDIS_CELERY_DB", "0")
REDIS_RESULTS_DB = get_env_variable("REDIS_RESULTS_DB", "1")

RESULTS_BACKEND = FileSystemCache("/app/superset_home/sqllab")


class CeleryConfig(object):
    BROKER_URL = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_CELERY_DB}"
    CELERY_IMPORTS = ("superset.sql_lab", "superset.tasks")
    CELERY_RESULT_BACKEND = f"redis://{REDIS_HOST}:{REDIS_PORT}/{REDIS_RESULTS_DB}"
    CELERYD_LOG_LEVEL = "DEBUG"
    CELERYD_PREFETCH_MULTIPLIER = 1
    CELERY_ACKS_LATE = False
    CELERYBEAT_SCHEDULE = {
        "reports.scheduler": {
            "task": "reports.scheduler",
            "schedule": crontab(minute="*", hour="*"),
        },
        "reports.prune_log": {
            "task": "reports.prune_log",
            "schedule": crontab(minute=10, hour=0),
        },
    }


CELERY_CONFIG = CeleryConfig

FEATURE_FLAGS = {"ALERT_REPORTS": True}
ALERT_REPORTS_NOTIFICATION_DRY_RUN = True
WEBDRIVER_BASEURL = "http://superset:8088/"
# The base URL for the email report hyperlinks.
WEBDRIVER_BASEURL_USER_FRIENDLY = WEBDRIVER_BASEURL

SQLLAB_CTAS_NO_LIMIT = True

#
# Optionally import superset_config_docker.py (which will have been included on
# the PYTHONPATH) in order to allow for local settings to be overridden
#
try:
    import superset_config_docker
    from superset_config_docker import *  # noqa

    logger.info(
        f"Loaded your Docker configuration at " f"[{superset_config_docker.__file__}]"
    )
except ImportError:
    logger.info("Using default Docker config...")
