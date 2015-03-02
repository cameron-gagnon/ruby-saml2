require 'saml2/contact'
require 'saml2/organization'

module SAML2
  module OrganizationAndContacts
    attr_writer :organization, :contacts

    def initialize(node = nil)
      unless node
        @organization = nil
        @contacts = []
      end
    end

    def organization
      unless instance_variable_defined?(:@organization)
        @organization = Organization.from_xml(@root.at_xpath('md:Organization', Namespaces::ALL))
      end
      @organization
    end

    def contacts
      @contacts ||= load_object_array(@root, 'md:ContactPerson', Contact)
    end

    protected

    def build(builder)
      organization.build(builder) if organization
      contacts.each do |contact|
        contact.build(builder)
      end
    end
  end
end
