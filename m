Received: from eggs.gnu.org ([2001:4830:134:3::10]:49152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eqhbn-0002jg-2X
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1eqhbi-0005vR-O5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:56:03 -0500
Resent-Message-Id: <E1eqhbi-0005vR-O5@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1eqhbi-0005u3-H8
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:55:58 -0500
In-Reply-To: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151974687189.1230.17769536671596955392@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 27 Feb 2018 07:54:35 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/5] s390x: vfio-ap: guest dedicated
 crypto adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: akrowiak@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MTk3NDYyNTktMjc3MTAtMS1naXQtc2VuZC1lbWFpbC1ha3Jvd2lha0BsaW51
eC52bmV0LmlibS5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MiAwLzVdIHMzOTB4
OiB2ZmlvLWFwOiBndWVzdCBkZWRpY2F0ZWQgY3J5cHRvIGFkYXB0ZXJzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAt
LW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQoKY29tbWl0cz0iJChnaXQg
bG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIKZm9yIGMgaW4gJGNvbW1pdHM7IGRv
CiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6ICQoZ2l0IGxvZyAtbiAxIC0tZm9y
bWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMgLS1mb3JtYXQ9ZW1haWwgfCAuL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRoZW4KICAgICAgICBmYWlsZWQ9MQog
ICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRvbmUKCmV4aXQgJGZhaWxlZAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1MTk3NDYyNTktMjc3MTAtMS1n
aXQtc2VuZC1lbWFpbC1ha3Jvd2lha0BsaW51eC52bmV0LmlibS5jb20gLT4gcGF0Y2hldy8xNTE5
NzQ2MjU5LTI3NzEwLTEtZ2l0LXNlbmQtZW1haWwtYWtyb3dpYWtAbGludXgudm5ldC5pYm0uY29t
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKZTllMWQ2OGI4NyBzMzkweC9jcHVtb2Rl
bDogU2V0IHVwIENQVSBtb2RlbCBmb3IgQVAgZGV2aWNlIHN1cHBvcnQKMmZhYmQwZjU3NiBzMzkw
eC92ZmlvOiBhcDogSW50cm9kdWNlIFZGSU8gQVAgZGV2aWNlCmJiNTA1ZWU1ZDYgczM5MHgvdmZp
bzogYXA6IFZGSU86IGxpbnV4IGhlYWRlciB1cGRhdGVzCjRlYTg5ZWJmMzggczM5MHgvYXA6IGJh
c2UgQWRqdW5jdCBQcm9jZXNzb3IgKEFQKSBvYmplY3QKNGZjMzFlNjNlYSBzMzkwOiBkb2M6IGRl
dGFpbGVkIHNwZWNpZmljYXRpb25zIGZvciBBUCB2aXJ0dWFsaXphdGlvbgoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KQ2hlY2tpbmcgUEFUQ0ggMS81OiBzMzkwOiBkb2M6IGRldGFpbGVkIHNwZWNpZmlj
YXRpb25zIGZvciBBUCB2aXJ0dWFsaXphdGlvbi4uLgpDaGVja2luZyBQQVRDSCAyLzU6IHMzOTB4
L2FwOiBiYXNlIEFkanVuY3QgUHJvY2Vzc29yIChBUCkgb2JqZWN0Li4uCkNoZWNraW5nIFBBVENI
IDMvNTogczM5MHgvdmZpbzogYXA6IFZGSU86IGxpbnV4IGhlYWRlciB1cGRhdGVzLi4uCkNoZWNr
aW5nIFBBVENIIDQvNTogczM5MHgvdmZpbzogYXA6IEludHJvZHVjZSBWRklPIEFQIGRldmljZS4u
LgpDaGVja2luZyBQQVRDSCA1LzU6IHMzOTB4L2NwdW1vZGVsOiBTZXQgdXAgQ1BVIG1vZGVsIGZv
ciBBUCBkZXZpY2Ugc3VwcG9ydC4uLgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwoj
ODY6IEZJTEU6IHRhcmdldC9zMzkweC9jcHVfZmVhdHVyZXMuYzozOToKKyAgICBGRUFUX0lOSVQo
InFjaSIsIFMzOTBfRkVBVF9UWVBFX1NURkwsIDEyLCAiUXVlcnkgQVAgQ29uZmlndXJhdGlvbiBm
YWNpbGl0eSIpLAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM4OTogRklMRTogdGFy
Z2V0L3MzOTB4L2NwdV9mZWF0dXJlcy5jOjQyOgorICAgIEZFQVRfSU5JVCgiYXBmdCIsIFMzOTBf
RkVBVF9UWVBFX1NURkwsIDE1LCAiQWRqdW5jdCBQcm9jZXNzb3IgRmFjaWxpdGllcyBUZXN0IGZh
Y2lsaXR5IiksCgp0b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDExMyBsaW5lcyBjaGVja2Vk
CgpZb3VyIHBhdGNoIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
