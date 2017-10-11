Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2HER-0006JV-U1
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1e2HEN-0004FC-UU
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:39:31 -0400
Resent-Message-Id: <E1e2HEN-0004FC-UU@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1e2HEN-0004F1-MS
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:39:27 -0400
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <150772912107.288.7743549322689037658@b58463cdfd5f>
In-Reply-To: <1507726772-16661-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 11 Oct 2017 06:38:41 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanb@linux.vnet.ibm.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org, amarnath.valluri@intel.com, marcandre.lureau@gmail.com

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDE1MDc3MjY3NzItMTY2NjEtMS1naXQtc2VuZC1lbWFpbC1zdGVmYW5iQGxpbnV4
LnZuZXQuaWJtLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSB0cG06IFVzZSBFTVNH
U0laRSBpbnN0ZWFkIG9mIEVCQURNU0cgdG8gY29tcGlsZSBvbiBPcGVuQlNECgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxv
ZyAtLW9uZWxpbmUgJEJBU0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
CmNvbW1pdHM9IiQoZ2l0IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBj
IGluICRjb21taXRzOyBkbwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdp
dCBsb2cgLW4gMSAtLWZvcm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9y
bWF0PWVtYWlsIHwgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAg
ICAgICAgZmFpbGVkPTEKICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpl
eGl0ICRmYWlsZWQKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIx
ZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8xNTA3
NzI4MjkwLTYwNjItMS1naXQtc2VuZC1lbWFpbC10aG9tYXMudmVucmllc0BnbWFpbC5jb20gLT4g
cGF0Y2hldy8xNTA3NzI4MjkwLTYwNjItMS1naXQtc2VuZC1lbWFpbC10aG9tYXMudmVucmllc0Bn
bWFpbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo1YWY1MGU0YzY0IHRwbTog
VXNlIEVNU0dTSVpFIGluc3RlYWQgb2YgRUJBRE1TRyB0byBjb21waWxlIG9uIE9wZW5CU0QKCj09
PSBPVVRQVVQgQkVHSU4gPT09CkNoZWNraW5nIFBBVENIIDEvMTogdHBtOiBVc2UgRU1TR1NJWkUg
aW5zdGVhZCBvZiBFQkFETVNHIHRvIGNvbXBpbGUgb24gT3BlbkJTRC4uLgpFUlJPUjogcmV0dXJu
IG9mIGFuIGVycm5vIHNob3VsZCB0eXBpY2FsbHkgYmUgLXZlIChyZXR1cm4gLUVNU0dTSVpFKQoj
MjM6IEZJTEU6IGh3L3RwbS90cG1fdXRpbC5jOjY5OgorICAgICAgICByZXR1cm4gRU1TR1NJWkU7
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKWW91ciBwYXRj
aCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNv
bW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQGZyZWVsaXN0cy5vcmc=
