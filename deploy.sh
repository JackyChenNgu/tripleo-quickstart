#!/bin/bash
export VIRTHOST=127.0.0.2
export LIBGUESTFS_BACKEND_SETTINGS=network_bridge=virbr0

scripts=deploy.sh

function usage() {
   echo -e "\033[1;31;40musage: source $scripts\033[0m"
   echo -e "\033[1;31;40moptions: \033[0m"
   echo -e "	provision"
   echo -e "	install_undercloud"
   echo -e "	prepare_overcloud"	
   echo -e "	deploy_overcloud"
   echo -e "	validate_deploy"
}
case $1 in
provision)
        bash quickstart.sh -R rocky -e "@./release.yml" --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml -p quickstart.yml $VIRTHOST
	;;
install_undercloud)
	bash quickstart.sh -R rocky -e "@./release.yml" --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml \
        -I --teardown none -p quickstart-extras-undercloud.yml $VIRTHOST
	;;
prepare_overcloud)
        bash quickstart.sh -R rocky -e "@./release.yml" --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml \
	-I --teardown none -p quickstart-extras-overcloud-prep.yml $VIRTHOST
	;;
deploy_overcloud)
	bash quickstart.sh -R rocky -e "@./release.yml" --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml \
	-I --teardown none -p quickstart-extras-overcloud.yml $VIRTHOST
	;;
validate_deploy)
	bash quickstart.sh -R rocky -e "@./release.yml" --no-clone --tags all --nodes config/nodes/1ctlr_1comp.yml \
	-I --teardown none -p quickstart-extras-validate.yml $VIRTHOST
	;;
*)
	usage
	#echo -e "\033[1;31;40musage: source $scripts [provision|install_undercloud|prepare_overcloud|deploy_overcloud|validate_deploy]\033[0m"	
	;;
esac
