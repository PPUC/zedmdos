PROJECT_DIR    := $(shell pwd)
DL_DIR         ?= $(PROJECT_DIR)/dl
OUTPUT_DIR     ?= $(PROJECT_DIR)/output
CCACHE_DIR     ?= $(PROJECT_DIR)/buildroot-ccache
DOCKER_OPTS    ?=
DIRECT_BUILD   ?=
MAKE_OPTS      ?=
DOCKER_REPO    ?= zedmdos
IMAGE_NAME     ?= zedmdos-build

TARGETS := $(sort $(shell find $(PROJECT_DIR)/configs/ -name '*_defconfig'))

# define build command based on whether we are building direct or inside a docker build container
ifdef DIRECT_BUILD

define MAKE_BUILDROOT
	make $(MAKE_OPTS) O=$(OUTPUT_DIR)/$* \
		BR2_EXTERNAL=$(PROJECT_DIR) \
		BR2_DL_DIR=$(DL_DIR) \
		BR2_CCACHE_DIR=$(CCACHE_DIR) \
		-C $(PROJECT_DIR)/buildroot
endef

else # DIRECT_BUILD
	DOCKER         ?= docker

	ifndef BATCH_MODE
		DOCKER_OPTS += -i
	endif

define RUN_DOCKER
	$(DOCKER) run -t --init --rm \
		-e HOME \
		-v $(PROJECT_DIR):/build \
		-v $(DL_DIR):/build/buildroot/dl \
		-v $(OUTPUT_DIR)/$*:/$* \
		-v $(CCACHE_DIR):$(HOME)/.buildroot-ccache \
		-w /$* \
		-v /etc/passwd:/etc/passwd:ro \
		-v /etc/group:/etc/group:ro \
		-u $(UID):$(GID) \
		$(DOCKER_OPTS) \
		$(DOCKER_REPO)/$(IMAGE_NAME)
endef

define MAKE_BUILDROOT
	$(RUN_DOCKER) make $(MAKE_OPTS) O=/$* \
			BR2_EXTERNAL=/build \
			-C /build/buildroot
endef

endif # DIRECT_BUILD

_check_docker:
	$(if $(DIRECT_BUILD),$(error "This is a direct build environment"))
	$(if $(shell which $(DOCKER) 2>/dev/null),, $(error "$(DOCKER) not found!"))

build-docker-image: _check_docker
	$(DOCKER) build . -t $(DOCKER_REPO)/$(IMAGE_NAME)
	@touch .docker-image-available

.docker-image-available:
	@$(MAKE) -s _check_docker
	@$(DOCKER) pull $(DOCKER_REPO)/$(IMAGE_NAME)
	@touch .docker-image-available

docker-image: $(if $(DIRECT_BUILD),,.docker-image-available)

%-supported:
	$(if $(findstring $*, $(TARGETS)),,$(error "$* not supported!"))

output-dir-%: %-supported
	@mkdir -p $(OUTPUT_DIR)/$*

ccache-dir:
	@mkdir -p $(CCACHE_DIR)

dl-dir:
	@mkdir -p $(DL_DIR)

%-config: docker-image output-dir-%
	$(MAKE_BUILDROOT) $*_defconfig

%-build: docker-image %-config ccache-dir dl-dir
	@$(MAKE_BUILDROOT) $(CMD)

%-source: docker-image %-config ccache-dir dl-dir
	@$(MAKE_BUILDROOT) source

%-pkg:
	$(if $(PKG),,$(error "PKG not specified!"))
	@$(MAKE) $*-build CMD=$(PKG)
