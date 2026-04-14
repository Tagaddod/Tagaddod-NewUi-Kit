// Shared JSON schemas used by both Gemini (responseSchema) and
// Anthropic (tool input_schema) to enforce structured generation output.

const _gapsSchema = {
  'type': 'array',
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

const _screenSpecSchema = {
  'type': 'object',
  'properties': {
    'screen_type': {'type': 'string'},
    'title': {'type': 'string'},
    'subtitle': {'type': 'string'},
    'top_bar_title': {'type': 'string'},
    'use_logo': {'type': 'boolean'},
    'sections': {
      'type': 'array',
      'items': {
        'type': 'object',
        'properties': {
          'kind': {'type': 'string'},
          'title': {'type': 'string'},
          'subtitle': {'type': 'string'},
          'items': {
            'type': 'array',
            'items': {
              'type': 'object',
              'properties': {
                'kind': {'type': 'string'},
                'label': {'type': 'string'},
                'value': {'type': 'string'},
                'hint': {'type': 'string'},
                'component_name': {'type': 'string'},
                'emphasis': {'type': 'string'},
                'resolution': {'type': 'string'},
                'checked': {'type': 'boolean'},
                'obscured': {'type': 'boolean'},
              },
              'required': ['kind', 'label'],
            },
          },
        },
        'required': ['kind', 'items'],
      },
    },
  },
  'required': ['screen_type', 'title', 'subtitle', 'use_logo', 'sections'],
};

const Map<String, dynamic> singleScreenSchema = {
  'type': 'object',
  'properties': {
    'screen_spec': _screenSpecSchema,
    'screen_code': {'type': 'string'},
    'kit_gaps': _gapsSchema,
  },
  'required': ['screen_code', 'kit_gaps'],
};

const Map<String, dynamic> archSchema = {
  'type': 'object',
  'properties': {
    'screen_spec': _screenSpecSchema,
    'files': {
      'type': 'array',
      'items': {
        'type': 'object',
        'properties': {
          'path': {'type': 'string'},
          'code': {'type': 'string'},
        },
        'required': ['path', 'code'],
      },
    },
    'kit_gaps': _gapsSchema,
  },
  'required': ['files', 'kit_gaps'],
};
