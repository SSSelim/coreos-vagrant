NUMINSTANCES = 3
discovery-url:
	@for i in 1 2 3 4 5; do \
		URL=`curl -s -w '\n' https://discovery.etcd.io/new?size=$$NUMINSTANCES`; \
		if [ ! -z $$URL ]; then \
			sed -e "s,#discovery: https://discovery.etcd.io/<token>,discovery: $$URL," ./user-data.sample > ./user-data; \
			echo "Wrote $$URL to ./user-data"; \
		    break; \
		fi; \
		if [ $$i -eq 5 ]; then \
			echo "Failed to contact https://discovery.etcd.io after $$i tries"; \
		else \
			sleep 3; \
		fi \
	done
