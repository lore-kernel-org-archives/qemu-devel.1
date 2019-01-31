Received: from eggs.gnu.org ([209.51.188.92]:49392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGTZ-00016d-CS
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gpGTX-0001WD-E5
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:50:09 -0500
Resent-Message-Id: <E1gpGTX-0001WD-E5@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gpGTV-0001SD-FM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 12:50:07 -0500
Message-ID: <154895696014.23946.13669523883381499428@ebba9967afc0>
In-Reply-To: <cover.c7f64d9a8f7ff9259c785560765645151c85dc75.1548266832.git-series.knut.omang@oracle.com>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Thu, 31 Jan 2019 09:49:21 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/2] pcie: Add simple ACS "support" to the
 generic PCIe root port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: knut.omang@oracle.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, mst@redhat.com, stefanha@gmail.com, elijahs@mellanox.com, alex.williamson@redhat.com, talat@mellanox.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci5jN2Y2NGQ5YThmN2Zm
OTI1OWM3ODU1NjA3NjU2NDUxNTFjODVkYzc1LjE1NDgyNjY4MzIuZ2l0LXNlcmllcy5rbnV0Lm9t
YW5nQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNv
ZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlv
bjoKClN1YmplY3Q6IFtRZW11LWRldmVsXSBbUEFUQ0ggMC8yXSBwY2llOiBBZGQgc2ltcGxlIEFD
UyAic3VwcG9ydCIgdG8gdGhlIGdlbmVyaWMgUENJZSByb290IHBvcnQKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IGNvdmVyLmM3ZjY0ZDlhOGY3ZmY5MjU5Yzc4NTU2MDc2NTY0NTE1MWM4NWRjNzUu
MTU0ODI2NjgzMi5naXQtc2VyaWVzLmtudXQub21hbmdAb3JhY2xlLmNvbQoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVs
aW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0t
bWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVh
OWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5j
aCAndGVzdCcKZDc1OGI5OWJlMCBnZW5fcGNpZV9yb290X3BvcnQ6IEFkZCBBQ1MgKEFjY2VzcyBD
b250cm9sIFNlcnZpY2VzKSBjYXBhYmlsaXR5CmYwOWIxNGMxNDUgcGNpZTogQWRkIGEgc2ltcGxl
IFBDSWUgQUNTIChBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcykgaGVscGVyIGZ1bmN0aW9uCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcgY29tbWl0IGYwOWIxNGMxNDVkNyAocGNpZTog
QWRkIGEgc2ltcGxlIFBDSWUgQUNTIChBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcykgaGVscGVyIGZ1
bmN0aW9uKQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzA6IEZJTEU6IGh3L3Bj
aS9wY2llLmM6OTE3OgorICAgICAgICAgICAgICAgICBQQ0lfQUNTX1NWIHwgUENJX0FDU19UQiB8
IFBDSV9BQ1NfUlIgfCBQQ0lfQUNTX0NSIHwgUENJX0FDU19VRik7CgpXQVJOSU5HOiBsaW5lIG92
ZXIgODAgY2hhcmFjdGVycwojMzI6IEZJTEU6IGh3L3BjaS9wY2llLmM6OTE5OgorICAgICAgICAg
ICAgICAgICBQQ0lfQUNTX1NWIHwgUENJX0FDU19UQiB8IFBDSV9BQ1NfUlIgfCBQQ0lfQUNTX0NS
IHwgUENJX0FDU19VRik7CgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJz
CiM1NzogRklMRTogaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmg6MTc5OgorI2RlZmluZSBQQ0lf
QUNTX1ZFUl5JXkleSTB4MiQKCnRvdGFsOiAxIGVycm9ycywgMiB3YXJuaW5ncywgMzIgbGluZXMg
Y2hlY2tlZAoKUGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElm
IGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0
aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tp
bmcgY29tbWl0IGQ3NThiOTliZTBmOCAoZ2VuX3BjaWVfcm9vdF9wb3J0OiBBZGQgQUNTIChBY2Nl
c3MgQ29udHJvbCBTZXJ2aWNlcykgY2FwYWJpbGl0eSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuYzdmNjRkOWE4ZjdmZjkyNTljNzg1NTYw
NzY1NjQ1MTUxYzg1ZGM3NS4xNTQ4MjY2ODMyLmdpdC1zZXJpZXMua251dC5vbWFuZ0BvcmFjbGUu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
