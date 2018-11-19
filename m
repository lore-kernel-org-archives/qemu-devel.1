Received: from eggs.gnu.org ([2001:4830:134:3::10]:48201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gOjPA-0002yP-9M
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:16:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gOjP7-0005lw-4b
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 08:15:56 -0500
Date: Mon, 19 Nov 2018 21:10:03 +0800 (CST)
Message-ID: <201811192110034389139@zte.com.cn>
In-Reply-To: <5fb48e39-d91b-6750-975b-ea58575ade92@redhat.com>
References: 1542482566-91660-1-git-send-email-peng.hao2@zte.com.cn,
	5fb48e39-d91b-6750-975b-ea58575ade92@redhat.com
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=5D_hw/arm/sysbus-fdt=3A_fix_asse?=
 =?utf-8?q?rt_in_matchfunction?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger@redhat.com
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

PkhpIFBlbmcsCj4KPk9uIDExLzE3LzE4IDg6MjIgUE0sIFBlbmcgSGFvIHdyb3RlOgo+PiBJbiBt
YXRjaCBmdW5jdGlvbiBpdCBzaG91bGQgbm90IGNhbGwgT0JKRUNLX0NIRUNLLiBXaGVuIHRoZXJl
IGlzCj4+IGEgbWlzbWF0Y2gsIHdlIHNob3VsZCBjb250aW51ZSB0byBtYXRjaCByYXRoZXIgdGhh
biBhc3NlcnQoKS4KPgo+Tm9ybWFsbHkgdGhpcyBpc3N1ZSBzaG91bGQgaGF2ZSBiZWVuIGZpeGVk
IGJ5Cj5lOWFjOGU4NGYwICAiaHcvYXJtL3N5c2J1cy1mZHQ6IE9ubHkgY2FsbCBtYXRjaF9mbiBj
YWxsYmFjayBpZiB0aGUgdHlwZQo+bWF0Y2hlcyIuIFBsZWFzZSBjYW4geW91IGNvbmZpcm0/Cj4K
CnllcyxpdCB3b3JrcyBhZnRlciB1cGRhdGluZyB5b3VyIHBhdGNoLgpUaGFua3MuCj5UaGFua3MK
Pgo+RXJpYwo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEhhbyA8cGVuZy5oYW8yQHp0ZS5jb20u
Y24+Cj4+IC0tLQo+PiAgaHcvYXJtL3N5c2J1cy1mZHQuYyB8IDcgKysrKysrLQo+PiAgMSBmaWxl
IGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvaHcvYXJtL3N5c2J1cy1mZHQuYyBiL2h3L2FybS9zeXNidXMtZmR0LmMKPj4gaW5kZXggMGUy
NGM4MC4uNDFiOTYyZCAxMDA2NDQKPj4gLS0tIGEvaHcvYXJtL3N5c2J1cy1mZHQuYwo+PiArKysg
Yi9ody9hcm0vc3lzYnVzLWZkdC5jCj4+IEBAIC00MTksMTAgKzQxOSwxNSBAQCBzdGF0aWMgaW50
IGFkZF9hbWRfeGdiZV9mZHRfbm9kZShTeXNCdXNEZXZpY2UgKnNiZGV2LCB2b2lkICpvcGFxdWUp
Cj4+ICBzdGF0aWMgYm9vbCB2ZmlvX3BsYXRmb3JtX21hdGNoKFN5c0J1c0RldmljZSAqc2JkZXYs
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IEJpbmRpbmdFbnRyeSAq
ZW50cnkpCj4+ICB7Cj4+IC0gICAgVkZJT1BsYXRmb3JtRGV2aWNlICp2ZGV2ID0gVkZJT19QTEFU
Rk9STV9ERVZJQ0Uoc2JkZXYpOwo+PiArICAgIFZGSU9QbGF0Zm9ybURldmljZSAqdmRldjsKPj4g
ICAgICBjb25zdCBjaGFyICpjb21wYXQ7Cj4+ICAgICAgdW5zaWduZWQgaW50IG47Cj4+Cj4+ICsg
ICAgdmRldiA9IChWRklPUGxhdGZvcm1EZXZpY2UgKikgb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpF
Q1Qoc2JkZXYpLAo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgVFlQRV9WRklPX1BMQVRGT1JNKTsKPj4gKyAgICBpZiAoIXZkZXYpCj4+ICsgICAgICAg
IHJldHVybiBmYWxzZTsKPj4gKwo+PiAgICAgIGZvciAobiA9IHZkZXYtPm51bV9jb21wYXQsIGNv
bXBhdCA9IHZkZXYtPmNvbXBhdDsgbiA+IDA7Cj4+ICAgICAgICAgICBuLS0sIGNvbXBhdCArPSBz
dHJsZW4oY29tcGF0KSArIDEpIHsKPj4gICAgICAgICAgaWYgKCFzdHJjbXAoZW50cnktPmNvbXBh
dCwgY29tcGF0KSkgewo+Pg==
