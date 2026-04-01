const gapsSchema = {
  'type': 'array',
  'description': 'List of missing components not in the kit',
  'items': {
    'type': 'object',
    'properties': {
      'widget_name': {'type': 'string'},
      'description': {'type': 'string'},
      'reason': {'type': 'string'},
      'suggested_component_name': {'type': 'string'},
      'priority': {'type': 'integer'},
      'proposed_implementation': {'type': 'string'},
    },
    'required': [
      'widget_name',
      'description',
      'reason',
      'suggested_component_name',
      'priority',
    ],
  },
};

const singleResponseSchema = {
  'type': 'object',
  'properties': {
    'screen_code': {
      'type': 'string',
      'description':
          'Complete Flutter Dart code for the requested screen',
    },
    'kit_gaps': gapsSchema,
  },
  'required': ['screen_code', 'kit_gaps'],
};

const archResponseSchema = {
  'type': 'object',
  'properties': {
    'files': {
      'type': 'array',
      'description': 'List of generated files',
      'items': {
        'type': 'object',
        'properties': {
          'path': {'type': 'string'},
          'code': {'type': 'string'},
        },
        'required': ['path', 'code'],
      },
    },
    'kit_gaps': gapsSchema,
  },
  'required': ['files', 'kit_gaps'],
};
