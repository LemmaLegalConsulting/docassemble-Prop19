from docassemble.base.util import get_config, space_to_underscore, Individual
from docassemble.AssemblyLine.al_document import ALDocument, ALDocumentBundle
import os
from boxsdk import Client, OAuth2
from datetime import datetime
from typing import Union

__all__ = ["publish_to_box", "get_new_bundle_path_name"]

def get_new_bundle_path_name(bundle:ALDocumentBundle, user:Union[Individual, str]) -> str:
  """Create a folder name from the bundle and user provided. Folder name will
  have a datetime prefix with iso compact format."""
  current_datetimestamp = datetime.utcnow().strftime("%Y%m%dT%H%M%S.%fZ")
  if isinstance(user, Individual):
    if hasattr(user.name, 'last'):
      user_string = user.name.lastfirst()                
    else:
      user_string = user.name.first
  else:
    user_string = user
  return space_to_underscore(f"{os.path.splitext(bundle.filename)[0]}_{current_datetimestamp}_{user_string}")

def publish_to_box(bundle:ALDocumentBundle, 
                      parent_folder:str = 195859802455,
                      new_folder:str = None,
                      key:str = "final",
                      config:str = "box.com",
                      client_id:str = None, 
                      client_secret:str = "",
                      access_token:str = None) -> None:
  """Uploads the contents of an ALDocumentBundle to Box.com with a Service Account token.
  Optionally, specify the key and either the name of a dictionary in the
  docassemble global config or the authentication details.
  May raise exceptions if the credentials or path are incorrect.
  
  Example configuration entry:
  ```
  box.com:
    client_id: 1234
    client_secret: ""
    access_token: 5678
  ```  
  """
  # Prevent Docassemble from running this multiple times (idempotency)
  for document in bundle:
    document[key].path()
    document.filename
    
  if not client_id and config:
    config = get_config(config, {})    
    default_parent_folder = config.get("default_parent_folder", "0")
    if config.get("default_parent_folder"):
      del config["default_parent_folder"]
  else:
    config = {"client_id": client_id,
              "client_secret": client_secret,
              "access_token": access_token
             }
    default_path = "0"
  
  if not parent_folder:
    parent_folder = default_parent_folder
    
  auth = OAuth2(**config)    
  client = Client(auth)
  if new_folder:
    parent_folder = client.folder(parent_folder).create_subfolder(new_folder).object_id  
  
  for document in bundle:
    file_path = document[key].path()
    base_name = os.path.splitext(os.path.basename(document.filename))[0]
    base_extension = os.path.splitext(file_path)[1]    
    client.folder(parent_folder).upload(file_path, file_name = f"{base_name}.{base_extension}")
