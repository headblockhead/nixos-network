let
  #headb = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9IxocfA5legUO3o+cbbQt75vc19UG9yrrPmWVLkwbmvGxCtEayW7ubFNXo9CwlPRqcudOARZjas3XJ4+ZwrDJC8qWrSNDSw1izZizcE5oFe/eTaw+E7jT8KcUWWfdUmyx3cuJCHUAH5HtqTXc5KtZ2PiW91lgx77CYEoDKtt14cqqKvBvWCgj8xYbuoZ5lS/tuF2TkYstxI9kNI2ibk14/YyUfPs+hVTeBCz+0/l87WePzYWwA6xkkZZzGstcpXyOKSrP/fchFC+CWs7oeoJSJ5QGkNqia6HFQrdw93BtGoD2FdR3ruNJa27lOFQcXRyijx43KVr4iLuYvdGw5TEt headb@compute-01";
  compute-01 = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCbxVr683AR4IDIVyaVATAb0YyK2o1/lD88LsD8sT44FNNo2e4ezlM6PiugEskhujKAR3hhFr3Kr22licF7VU+ops1hXtIsk0SAQ1abgpdV+eOM02CjRFBo+OMeUoUCnx5+6YRIN5Mw7olDx0oK4CUC938TRfj9+F7dJZbU+l2AGfHOtSXS7bnqhBNVjXNW2A1ha/IpaJvAPABT4sCfFonSwaqXERHn6Jr/aPV4dum9uT5aw8r4SE91DWiMDnbnDVEnDWDlqg+sTNfLv66U//gveGPVtg9zqmCR2QfNM5HXFPIh3KjkZl/gUdUWHEUT1MzbwUiIa+81b25GSBo4EM5x+RSMA+jq6aUucSKqplhPzcMbQY3eftRLmPDqLNhvtQlSkw0fRSICaQ5v6AiFiVBqlvdetX3gxl4+QLi5rxawoeZLqteH0562dVeXZFBowF6W1/Q4GHIieqwZvlDXZ3806PIukXhAMsjhfyj7WSbKA81LKJmutpw7rzYVOcZf3BnAjnHhrg7XMlfqpl2DTKSlreTA9+4H4ePZt7vN19aViqQjuL+jYjjxw+NJB/NGl4FW34H3eq0yxFSlTW43Yor6liS/hlsJs9nlobtVRuZOtUnspgjSjTuTXH5DnQ0AAHZmi/2DkjZpBICn8AQ3esHIo8mLqbjXx+8qCI1AeB4/OQ== root@compute-01";
  edwards-laptop = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzHYmvZTtOnxEcv+/pqGC7bp8aHsWRLl+cXvn1druMOXgDF+7Ioj+sII56FGUG2NCXsdkvtJinEBGSZOaojI1e4iCIMZaZS7Q11JiCGhgoDHSmeJoKpG7+qE8Xeh71KOw2NbtXIQeAXVgmRk07iYzVD+KowwLs1p9u23oFfF+zgj698SBx3ZQyaXJ8c10U23YjABT0zHXPTfRbC5pwZLzbbfSMkvJ5iDQgGrshwxgHB93imUpRqQ4SWLTnSxDn8WzvcCJ+zPFvLi8nc7YfXO6iPGLoB7DGhI4FUjKxvDU+H2kX00GiXzouItZDi3UijuvP04HtmpE16ZtBBahXuY1lkJOYM+vrkKhcgMAwgdHxycXxmHN9PeJmvayentwtQN9T4BSehRCIhuOIxWVyI+wUEIyRJTRpaEh5gqwuXxbYNmHnWaCoP+BRmYuCviWBnYyn2HI9HnspWSmq3wueFH7K+/VyRBpBfsRaKoObv/i7nDDUm60JpCE8givOrvP1lfvhNJIXnz216pkBvvsqzioYM7hv5N8z9WpoYsg+9B0RGcunjuVn9R4DrPJ5j5gFe7gdDdq7gZRiKFm5thKbsjhK3BGr/p4Yvn3TvhdVfZzOU8Ttn1LbdcNDnh0qB0/qsC8jSuSdDnvArC7hQtflc0l7+3hx6up7IZOEfpjGcmq9dQ== root@edwards-laptop";
  #  router = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDAQl3i/8ObSjutkdNxtztWKEcA7FD4wHWaQGtMIEpv4+NwbiarL7hXe/zHCmQjyIRFQmZzhgE2rsml3Ule68cDtYJVtj90+wov5FligNMde4Aopx7DzjzCkF6RgVXYqEQB21XdUr2GUanNYqwvnCAVR+JFRaF5ouadV+qIeivzeACisB/zcOr+AAJHBqHmm0kPAQ5i4kdD18TaQiezKhg+13/QrKqOhdUTNtZi8O/pUu2Mud9PbobRYI1dw18brf1QWFrY1/1ukd1LiD6D6/JJU9UUsFeC2apOX7rQej8Ip+SholajzEV8IyGOrA8rgHbVk0spDOp8XZKIDEjinupEFWJcZP93LvQe82WYk0EvjHJ66w3+TyTKYXGIOvaooMSj/5Uc5R/47rY/OmqUa+NF43ZMazQCNvQuVHc/zJ7MckWsz3XPdKrYghfWbYhP2w9Uj4D6Pl9Uzqu0tf3bhofdKGNVP7ujQEChisMr5d9wfob29urr4RjNYZcgyA+95IAFxcfOKrgNDYmlDffvv9VTmbMSYVsd0eHK6gUTHrmVFoZSA0roVVxwrdg8jq7NobC/uxtwLopAVtMF4xq/3JTTEoir8kP5z9BRvLMmG9E1jU0ZJwnzmMk6OHOPPn5Fqw536dSqimIBqQZtlmB7EsYe2kKDPSP2VuFP40EDqw6F5Q== root@router";
in
{
  "wireguard-public-key.age".publicKeys = [ compute-01 edwards-laptop ];
  "wireguard-private-key.age".publicKeys = [ compute-01 edwards-laptop ];
}
