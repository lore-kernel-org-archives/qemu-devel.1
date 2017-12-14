Received: from eggs.gnu.org ([2001:4830:134:3::10]:47596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ePIGp-00017G-SA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1ePIGp-0004ll-3C
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 20:25:07 -0500
References: <1511807966-23936-1-git-send-email-gengdongjiu@huawei.com>
	<470c9df5-f2e8-974b-b37f-eff84a6f3d71@huawei.com>
	<18906953-f464-d9f4-23b4-fd7118d45e2f@huawei.com>
	<20171211143220.7a359462@redhat.com>
	<e36ec13c-e597-caae-4ae8-81b320e8f461@huawei.com>
	<CAFEAcA-JmbR3RUMWrH2j5OrSitczu+KskE-NJyhsWrHbJCH_ZA@mail.gmail.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <500fe8d6-b154-30db-d14b-781f32875dd6@huawei.com>
Date: Thu, 14 Dec 2017 09:24:36 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-JmbR3RUMWrH2j5OrSitczu+KskE-NJyhsWrHbJCH_ZA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v13 00/12] Add ARMv8 RAS virtualization
 support in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Linuxarm <linuxarm@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>, xuwei5@hisilicon.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, James Morse <james.morse@arm.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Richard Henderson <rth@twiddle.net>

Hi peter,

On 2017/12/14 2:12, Peter Maydell wrote:
>> [v13,11/12] hw/arm/virt: Add RAS platform version for migration
>> [v13,12/12] target-arm: kvm64: handle SIGBUS signal from kernel or KVM
> Hi; unfortunately I only have one more working day this year, which
> isn't really enough to get up to speed sufficiently with RAS to
> review this patchset, so the earliest I'm likely to get to it is
> the week beginning 9th Jan.
Ok, thanks.

> 
> Hopefully somebody who understands RAS better than me will
> be able to review it before then.
I also hope somebody can review it before then.

> 
> thanks
> -- PMM
