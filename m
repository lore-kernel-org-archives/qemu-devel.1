Received: from eggs.gnu.org ([2001:4830:134:3::10]:47066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dqMLk-00070Q-MJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dqMLj-0007WD-Bv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:41:47 -0400
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Fri, 8 Sep 2017 16:40:51 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F2015F5FE7@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015F5F11@DGGEMA503-MBX.china.huawei.com>
	<CAFEAcA8HPhHeeXEDtxnewJ7mAJ-gYzR96pC06qA+Xx95LHu2DA@mail.gmail.com>
In-Reply-To: <CAFEAcA8HPhHeeXEDtxnewJ7mAJ-gYzR96pC06qA+Xx95LHu2DA@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBbUEFUQ0ggdjExIDUvNl0gdGFyZ2V0?=
 =?utf-8?q?-arm=3A_kvm64=3A_handle_SIGBUS_signal_for_synchronous_External_?=
 =?utf-8?q?Abort?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Paolo
	Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Will
	Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>, Shiju Jose <shiju.jose@huawei.com>, "zjzhang@codeaurora.org" <zjzhang@codeaurora.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, lkml -
	Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, John Garry <john.garry@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, huangdaode <huangdaode@hisilicon.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

Wy4uLl0NCj4gPg0KPiA+IC8qDQo+ID4gICogeHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4eHh4
eHh4eA0KPiA+ICAqLw0KPiA+IHZvaWQga3ZtX2h3cG9pc29uX3BhZ2VfYWRkKHJhbV9hZGRyX3Qg
cmFtX2FkZHIpOw0KPiANCj4gSXQgc2hvdWxkIGJlIGluIHRoZSBkb2MtY29tbWVudCBmb3JtYXQs
IHdoaWNoIGJlZ2lucyAiLyoqIiBhbmQgaGFzIHNvbWUgc3R5bGl6YXRpb24gb2YgaG93IHlvdSBs
aXN0IHBhcmFtZXRlcnMgYW5kIHNvIG9uLiBMb3RzIG9mDQo+IGV4YW1wbGVzIGluIHRoZSBleGlz
dGluZyBoZWFkZXJzLg0KDQp1bmRlcnN0YW5kLCB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4N
Cg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K
