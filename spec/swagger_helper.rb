# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  
  intro = <<~DESC
  ## Overview
  
  Welcome to the Ethscriptions Indexer API docs!
  
  This API enables you to learn everything about the ethscriptions protocol. All instances of the open source [Ethscriptions Indexer](https://github.com/0xFacet/ethscriptions-indexer) expose this API.
  
  If you don't want to run your own instance of the indexer you can use ours for free using the base URL `https://api.ethscriptions.com/v2`.
  
  ## Community and Support
        
  Join our community on [GitHub](https://github.com/0xFacet/ethscriptions-indexer) and [Discord](https://discord.gg/ethscriptions) to contribute, get support, and share your experiences with the Ethscriptions Indexer.
  
  DESC
  
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Ethscriptions API V2',
        version: 'v2',
        description: intro,
      },
      paths: {},
      tags: [
        {
          name: 'Ethscriptions',
          description: 'Endpoints for querying ethscriptions.'
        },
        {
          name: 'Ethscription Transfers',
          description: 'Endpoints for querying ethscription transfers.'
        },
        {
          name: 'Tokens',
          description: 'Endpoints for querying tokens. Note: token indexing is an optional feature and different indexers might index different tokens.'
        },
        {
          name: 'Status',
          description: 'Endpoints for querying indexer status.'
        },
      ],
      components: {
        schemas: {
          Ethscription: {
            type: :object,
            properties: {
              transaction_hash: { type: :string, example: '0x0ef100873db4e3b7446e9a3be0432ab8bc92119d009aa200f70c210ac9dcd4a6', description: 'Hash of the Ethereum transaction.' },
              block_number: { type: :string, example: '19619510', description: 'Block number where the transaction was included.' },
              transaction_index: { type: :string, example: '88', description: 'Transaction index within the block.' },
              block_timestamp: { type: :string, example: '1712682959', description: 'Timestamp for when the block was mined.' },
              block_blockhash: { type: :string, example: '0xa44323fa6404b446665037ec61a09fc8526144154cb3742bcd254c7ef054ab0c', description: 'Hash of the block.' },
              ethscription_number: { type: :string, example: '5853618', description: 'Unique identifier for the ethscription.' },
              creator: { type: :string, example: '0xc27b42d010c1e0f80c6c0c82a1a7170976adb340', description: 'Address of the ethscription creator.' },
              initial_owner: { type: :string, example: '0x00000000000000000000000000000000000face7', description: 'Initial owner of the ethscription.' },
              current_owner: { type: :string, example: '0x00000000000000000000000000000000000face7', description: 'Current owner of the ethscription.' },
              previous_owner: { type: :string, example: '0xc27b42d010c1e0f80c6c0c82a1a7170976adb340', description: 'Previous owner of the ethscription before the current owner.' },
              content_uri: { type: :string, example: 'data:application/vnd.facet.tx+json;rule=esip6,{...}', description: 'URI encoding the data and rule for the ethscription.' },
              content_sha: { type: :string, example: '0xda6dce30c4c09885ed8538c9e33ae43cfb392f5f6d42a62189a446093929e115', description: 'SHA hash of the content.' },
              esip6: { type: :boolean, example: true, description: 'Indicator of whether the ethscription conforms to ESIP-6.' },
              mimetype: { type: :string, example: 'application/vnd.facet.tx+json', description: 'MIME type of the ethscription.' },
              gas_price: { type: :string, example: '37806857216', description: 'Gas price used for the transaction.' },
              gas_used: { type: :string, example: '27688', description: 'Amount of gas used by the transaction.' },
              transaction_fee: { type: :string, example: '1046796262596608', description: 'Total fee of the transaction.' },
              value: { type: :string, example: '0', description: 'Value transferred in the transaction.' },
              attachment_sha: { type: :string, nullable: true, example: '0x0ef100873db4e3b7446e9a3be0432ab8bc92119d009aa200f70c210ac9dcd4a6', description: 'SHA hash of the attachment.' },
              attachment_content_type: { type: :string, nullable: true, example: 'text/plain', description: 'MIME type of the attachment.' }
            },
          },
          EthscriptionTransfer: {
            type: :object,
            properties: {
              ethscription_transaction_hash: { 
                type: :string, 
                example: '0x4c5d41...',
                description: 'Hash of the ethscription associated with the transfer.'
              },
              transaction_hash: { 
                type: :string, 
                example: '0x707bb3...',
                description: 'Hash of the Ethereum transaction that performed the transfer.'
              },
              from_address: { 
                type: :string, 
                example: '0xfb833c...',
                description: 'Address of the sender in the transfer.'
              },
              to_address: { 
                type: :string, 
                example: '0x1f1edb...',
                description: 'Address of the recipient in the transfer.'
              },
              block_number: { 
                type: :integer, 
                example: 19619724, 
                description: 'Block number where the transfer was recorded.'
              },
              block_timestamp: { 
                type: :integer, 
                example: 1712685539, 
                description: 'Timestamp for when the block containing the transfer was mined.'
              },
              block_blockhash: { 
                type: :string, 
                example: '0x0204cb...',
                description: 'Hash of the block containing the transfer.'
              },
              event_log_index: { 
                type: :integer, 
                example: nil, 
                description: 'Index of the event log that recorded the transfer.',
                nullable: true
              },
              transfer_index: { 
                type: :string, 
                example: '51', 
                description: 'Index of the transfer in the transaction.'
              },
              transaction_index: { 
                type: :integer, 
                example: 95, 
                description: 'Transaction index within the block.'
              },
              enforced_previous_owner: { 
                type: :string, 
                example: nil, 
                description: 'Enforced previous owner of the ethscription, if applicable.',
                nullable: true
              }
            },
          },
          Token: {
            type: :object,
            properties: {
              deploy_ethscription_transaction_hash: { type: :string, example: '0xc8115ff794c6a077bdca1be18408e45394083debe026e9136ed26355b52f6d0d', description: 'The transaction hash of the Ethscription that deployed the token.' },
              deploy_block_number: { type: :string, example: '18997063', description: 'The block number in which the token was deployed.' },
              deploy_transaction_index: { type: :string, example: '67', description: 'The index of the transaction in the block in which the token was deployed.' },
              protocol: { type: :string, example: 'erc-20', description: 'The protocol of the token.' },
              tick: { type: :string, example: 'nodes', description: 'The tick (symbol) of the token.' },
              max_supply: { type: :string, example: '10000000000', description: 'The maximum supply of the token.' },
              total_supply: { type: :string, example: '10000000000', description: 'The current total supply of the token.' },
              mint_amount: { type: :string, example: '10000', description: 'The amount of tokens minted.' }
            },
            description: 'Represents a token, including its deployment information, protocol, and supply details.'
          },
          PaginationObject: {
            type: :object,
            properties: {
              page_key: { type: :string, example: '18680069-4-1', description: 'Key for the next page of results. Supply this in the page_key query parameter to retrieve the next set of items.' },
              has_more: { type: :boolean, example: true, description: 'Indicates if more items are available beyond the current page.' }
            },
            description: 'Contains pagination details to navigate through the list of records.'
          }
        }
      },
      servers: [
        {
          url: 'https://api.ethscriptions.com/v2'
        }
      ]
    }
  }

  ethscription_object = config.openapi_specs['v1/swagger.yaml'][:components][:schemas][:Ethscription]
  ethscription_properties = ethscription_object[:properties]

  # Defining the additional property for transfers
  transfers_addition = {
    transfers: {
      type: :array,
      items: {
        '$ref': '#/components/schemas/EthscriptionTransfer'
      },
      description: 'Array of transfers associated with the ethscription.'
    }
  }

  # Merge the original properties with the new addition
  updated_properties = ethscription_properties.merge(transfers_addition)

  # Create a new component schema that includes the updated properties
  ethscription_with_transfers_component = ethscription_object.merge({
    type: ethscription_object[:type],
    properties: updated_properties
  })

  # Add the new component to the OpenAPI specification
  config.openapi_specs['v1/swagger.yaml'][:components][:schemas][:EthscriptionWithTransfers] = ethscription_with_transfers_component
  
  # Retrieve the existing TokenObject component schema
  token_component = config.openapi_specs['v1/swagger.yaml'][:components][:schemas][:Token]

  # Define the additional property for balances
  balances_property = {
    balances: {
      type: :object,
      additionalProperties: {
        type: :string
      },
      description: 'A mapping of wallet addresses to their respective token balances.',
      example: {
        "0x000000000006f291b587f39b6960dd32e31400bf": "5595650000",
        "0x0000000a0705080fae54fd5cd2041a996a1d59ed": "5660000",
        "0x00007fd644a03bc613b222a5c2e661861d71c424": "10000",
        "0x000112a490277649e5d4d02ffd8a58bb002d0ed4": "690000"
      }
    }
  }

  # Merge the additional property into the existing properties of TokenObject
  updated_properties = token_component[:properties].merge(balances_property)

  # Create a new component schema that includes the updated properties
  token_with_balances_component = token_component.merge({
    type: token_component[:type],
    properties: updated_properties
  })

  # Add the new component schema to the openapi_specs
  config.openapi_specs['v1/swagger.yaml'][:components][:schemas][:TokenWithBalances] = token_with_balances_component

  
  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
