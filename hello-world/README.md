## EDA Hello World

### Requirements
python3, ansible, ansible-galaxy and Java17+

### Install EDA
`
ansible-galaxy collection install ansible.eda
`

### Test locally

1. Run the EDA service from directory above this README

    `
    ansible-rulebook --rulebook hello-world/rulebook-webhook.yml -i inventory.yml --verbose
    `

2. Open new terminal

3. Hit 'Say Hello' rule using curl

    `
    curl -H 'Content-Type: application/json' -d "{\"message\": \"Ansible is super cool\"}" 127.0.0.1:5000/endpoint
    `

    NOTE1: Remove comments from playbook-hello.yml and re-run to see message contents.


4. Hit Webhook2 to match second condition

    `
    curl -H 'Content-Type: application/json' -d "{\"message\": \"hook2\", \"ip_list\": \"test\"}" 127.0.0.1:5000/endpoint
    `

    ```
    #### REVISIT IF TIME PERMITS: 
    Weird behavior here. 
    Uncomment either and they work but not together.
    Put them together and: 

    $ curl -H 'Content-Type: application/json' -d "{\"message\": \"hook2\"}" 127.0.0.1:5000/endpoint` 

    doesn't trigger but: 

    $ curl -H 'Content-Type: application/json' -d "{\"ip_list\": \"test\"}" 127.0.0.1:5000/endpoint`

    does and then fails bc it requires the "events" keyword (Appendix 2)
    ```

5. Hit webhook 3 and observe different keys 

    `
    curl -H 'Content-Type: application/json' -d "{\"message\": \"hook3\", \"ip_list\": \"test\"}" 127.0.0.1:5000/endpoint
    `

    `
    curl -H 'Content-Type: application/json' -d "{\"message\": \"hook4\", \"ip_list\": \"test\"}" 127.0.0.1:5000/endpoint
    `

### Appendix: 
1.  ansible_eda.event vs. ansible_eda.events (regular condition vs. any and all conditions return differently and need appropriate handlers)
2.  m_1/m_2 returned under ansible_eda.events key depending on which condition is matched. The m appears to stand for metadata bc 'Say Hello' returns metadata instead. 
    - Are they entirely based on order no matter what? 
    - Can same condition twice double up on matching times and then duplicate data?
