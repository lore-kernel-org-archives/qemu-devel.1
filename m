Received: from eggs.gnu.org ([209.51.188.92]:33333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz3V6-000503-13
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gz3V4-0001lw-6U
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:00:11 -0500
Resent-Message-Id: <E1gz3V4-0001lw-6U@eggs.gnu.org>
Received: from sender-of-o51.zoho.com ([135.84.80.216]:21127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gz3V2-0001iy-PT
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 13:00:10 -0500
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <155129037679.2181.15632479093957046523@49fa7ef69f7b>
In-Reply-To: <20190222154454.30289-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 27 Feb 2019 09:59:38 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v4] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: fam@euphon.net, qemu-devel@nongnu.org, stappers@stappers.nl, lersek@redhat.com, armbru@redhat.com

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDIyMjE1NDQ1NC4zMDI4
OS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwMjIyMTU0NDU0LjMwMjg5LTEtYWxleC5i
ZW5uZWVAbGluYXJvLm9yZwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0XSBody9ibG9j
azogYmV0dGVyIHJlcG9ydGluZyBvbiBwZmxhc2ggYmFja2luZyBmaWxlIG1pc21hdGNoClR5cGU6
IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1
Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0
Y2hldy8yMDE5MDIyMDAxMDIzMi4xODczMS0xLXBoaWxtZEByZWRoYXQuY29tIC0+IHBhdGNoZXcv
MjAxOTAyMjAwMTAyMzIuMTg3MzEtMS1waGlsbWRAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCmQ2MTdkNGQ0ZWIgaHcvYmxvY2s6IGJldHRlciByZXBvcnRpbmcgb24g
cGZsYXNoIGJhY2tpbmcgZmlsZSBtaXNtYXRjaAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6
ICIoZm9vKikiIHNob3VsZCBiZSAiKGZvbyAqKSIKIzcwOiBGSUxFOiBody9ibG9jay9wZmxhc2hf
Y2ZpMDEuYzo3Njk6CisgICAgICAgICAgICAgICAgbWVtc2V0KCh1aW50OF90KilwZmwtPnN0b3Jh
Z2UgKyBiYWNraW5nX2xlbiwgMHhmZiwgcGFkX2J5dGVzKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4
MCBjaGFyYWN0ZXJzCiM4MjogRklMRTogaHcvYmxvY2svcGZsYXNoX2NmaTAxLmM6NzgxOgorICAg
ICAgICAgICAgd2Fybl9yZXBvcnQoImRldmljZSBuZWVkcyAlIiBQUkl1NjQgIiBieXRlcywgcmVz
dCBpZ25vcmVkIiwgdG90YWxfbGVuKTsKCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgNTgg
bGluZXMgY2hlY2tlZAoKQ29tbWl0IGQ2MTdkNGQ0ZWIxMyAoaHcvYmxvY2s6IGJldHRlciByZXBv
cnRpbmcgb24gcGZsYXNoIGJhY2tpbmcgZmlsZSBtaXNtYXRjaCkgaGFzIHN0eWxlIHByb2JsZW1z
LCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRp
dmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlO
VEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMjAxOTAyMjIxNTQ0NTQuMzAyODktMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVl
ZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t
