Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gVYCE-00032c-9g
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 03:42:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gVYCD-0008JQ-L8
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 03:42:46 -0500
Date: Sat, 8 Dec 2018 16:42:31 +0800 (CST)
Message-ID: <201812081642314652084@zte.com.cn>
In-Reply-To: <1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn>
References: 1544095560-70807-1-git-send-email-peng.hao2@zte.com.cn
Mime-Version: 1.0
From: <peng.hao2@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH_V12_0/5=5D_add_pvpanic_mmio_supp?=
 =?utf-8?q?ort?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: drjones@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org

PnYxMCAtLT4gdjExCj5jaGFuZ2UgY29uZmlndXJlIGludGVyZmFjZSBpbiB2aXJ0IG1hY2hpbmUg
Y29uZmlndXJlIHBhcmFtZXRlcnMuCj4KPnYxMSAtLT4gdjEyCj5yZWFsaXplIHB2cGFuaWMgYXMg
YSBwY2kgZGV2aWNlIGFuZCB1c2UgdGhlIG1taW8gb2YgcGNpIGRldmljZS4KPgo+UGhpbGlwcGUg
TWF0aGlldS1EYXVkw6kgKDIpOgo+aHcvbWlzYy9wdnBhbmljOiBCdWlsZCB0aGUgcHZwYW5pYyBk
ZXZpY2UgaW4gJChjb21tb24tb2JqKQo+aHcvbWlzYy9wdnBhbmljOiBDb3NtZXRpYyByZW5hbWlu
Zwo+Cj5QZW5nIEhhbyAoMyk6Cj5wdnBhbmljIDogdXBkYXRlIHB2cGFuaWMgZG9jdW1lbnQKPmh3
L2FybS92aXJ0OiBVc2UgdGhlIHB2cGFuaWMgZGV2aWNlCj5wdnBhbmljOiBhZGQgbW1pbyBpbnRl
cmZhY2UgYXMgYSBwY2kgZGV2aWNlCkhpICwgSSByZXN1Ym1pdCBhIHNlcmllcyBwYXRjaGVzIGZv
ciByZWFsaXplaW5nIHB2cGFuaWMgYXMgYSBwY2kgZGV2aWNlLgphbmQgSSB3YW50IHRvIGNvbmZp
cm0gaWYgdGhlc2UgcGF0Y2hlcyBtZWV0IHRoZSByZXF1aXJlbWVudHMuIApJIGtub3cgdGhlcmUg
YXJlIHN0aWxsIHNvbWUgaW1wZXJmZWN0aW9ucyBpbiB0aGlzIHNlcmllcyBvZiBwYXRjaGVzLCAK
c3VjaCBhcyBob3cgdG8gYXZvaWQgeDg2L3B2cGFuaWMgdXNpbmcgSVNBL3B2cGFuaWMgYW5kIFBD
SS9wdnBhbmljIGF0IHRoZSBzYW1lIHRpbWUuCiBCdXQgSSB3YW50IHRvIGNvbmZpcm0gaWYgdGhl
cmUgaXMgYSBwcm9ibGVtIHdpdGggdGhlIG92ZXJhbGwgZGlyZWN0aW9uIG9mIGltcGxlbWVudGF0
aW9uIAphcyBhIFBDSSBkZXZpY2UuVGhlbiBJIGNhbiByZXN1Ym1pdCBwYXRjaGVzIHRvIGtlcm5l
bCBmb3IgcmVwbGFjaW5nIHRoZSBwcmV2aW91cyBvbmVzLgoKVGhhbmtzLg==
