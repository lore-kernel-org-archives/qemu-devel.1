Received: from eggs.gnu.org ([2001:4830:134:3::10]:37252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1copOj-00013m-TJ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1copOf-0000bH-TH
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:17 -0400
Resent-Message-Id: <E1copOf-0000bH-TH@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1copOf-0000Yt-LS
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:13 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148974755554.99.94270344831504864@6c512846dbc7>
In-Reply-To: <148974701986.29545.5414999102981738774.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 17 Mar 2017 03:45:56 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] checkpatch: allow longer lines for logging
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMTQ4
OTc0NzAxOTg2LjI5NTQ1LjU0MTQ5OTkxMDI5ODE3Mzg3NzQuc3RnaXRAYmFoaWEKU3ViamVjdDog
W1FlbXUtZGV2ZWxdIFtQQVRDSF0gY2hlY2twYXRjaDogYWxsb3cgbG9uZ2VyIGxpbmVzIGZvciBs
b2dnaW5nIGZ1bmN0aW9ucwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKCkJBU0U9YmFzZQpuPTEKdG90YWw9JChnaXQgbG9nIC0tb25lbGluZSAkQkFT
RS4uIHwgd2MgLWwpCmZhaWxlZD0wCgojIFVzZWZ1bCBnaXQgb3B0aW9ucwpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQoKY29tbWl0cz0iJChnaXQgbG9nIC0tZm9ybWF0PSVIIC0tcmV2ZXJzZSAkQkFTRS4uKSIK
Zm9yIGMgaW4gJGNvbW1pdHM7IGRvCiAgICBlY2hvICJDaGVja2luZyBQQVRDSCAkbi8kdG90YWw6
ICQoZ2l0IGxvZyAtbiAxIC0tZm9ybWF0PSVzICRjKS4uLiIKICAgIGlmICEgZ2l0IHNob3cgJGMg
LS1mb3JtYXQ9ZW1haWwgfCAuL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIC07IHRo
ZW4KICAgICAgICBmYWlsZWQ9MQogICAgICAgIGVjaG8KICAgIGZpCiAgICBuPSQoKG4rMSkpCmRv
bmUKCmV4aXQgJGZhaWxlZAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1
YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzE0ODk3
NDcwMTk4Ni4yOTU0NS41NDE0OTk5MTAyOTgxNzM4Nzc0LnN0Z2l0QGJhaGlhIC0+IHBhdGNoZXcv
MTQ4OTc0NzAxOTg2LjI5NTQ1LjU0MTQ5OTkxMDI5ODE3Mzg3NzQuc3RnaXRAYmFoaWEKICogW25l
dyB0YWddICAgICAgICAgcGF0Y2hldy8xNDg5NzQ3NDQyODEuMzA2MzYuMTc5NzMyNjQwMDgyODU0
MTU1OTIuc3RnaXRAYmFoaWEgLT4gcGF0Y2hldy8xNDg5NzQ3NDQyODEuMzA2MzYuMTc5NzMyNjQw
MDgyODU0MTU1OTIuc3RnaXRAYmFoaWEKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwoz
OTBkN2M0IGNoZWNrcGF0Y2g6IGFsbG93IGxvbmdlciBsaW5lcyBmb3IgbG9nZ2luZyBmdW5jdGlv
bnMKCj09PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogY2hlY2twYXRjaDog
YWxsb3cgbG9uZ2VyIGxpbmVzIGZvciBsb2dnaW5nIGZ1bmN0aW9ucy4uLgpFUlJPUjogbGluZSBv
dmVyIDkwIGNoYXJhY3RlcnMKIzM4OiBGSUxFOiBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6MTM0OToK
KwkJICAgICEoJGxpbmUgPX4gL15cK1xzKiRsb2dGdW5jdGlvbnNccypcKFxzKig/OihbXiJdKikp
PyJbWFx0XSoiXHMqKD86LHxcKVxzKjspXHMqJC8gfHwKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJu
aW5ncywgMjAgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBs
ZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMg
cmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlO
RVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QGZyZWVsaXN0cy5vcmc=
