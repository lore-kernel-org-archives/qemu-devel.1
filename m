Received: from eggs.gnu.org ([2001:4830:134:3::10]:53614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eEAJ3-0001HO-8M
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1eEAIy-0004Pe-Cj
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:41:25 -0500
References: <1510341591-22817-1-git-send-email-gengdongjiu@huawei.com>
	<1510341591-22817-10-git-send-email-gengdongjiu@huawei.com>
	<3017b1b9-24d7-565b-1180-a0eb93c6d57a@redhat.com>
	<572b8361-ee14-35ed-6c85-a5e5d8ae5b1a@huawei.com>
	<b948cb25-dad9-ec7e-8406-b829d21cac26@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <85576ff7-5847-615d-787d-c7a652be024a@huawei.com>
Date: Mon, 13 Nov 2017 16:36:49 +0800
MIME-Version: 1.0
In-Reply-To: <b948cb25-dad9-ec7e-8406-b829d21cac26@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 09/12] Move related hwpoison page
 function to accel/kvm/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, imammedo@redhat.com, zhaoshenglong@huawei.com, peter.maydell@linaro.org, mtosatti@redhat.com, james.morse@arm.com, lersek@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, guohanjun@huawei.com, lijinyue@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhengqiang10@huawei.com, linuxarm@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org



On 2017/11/13 16:27, Paolo Bonzini wrote:
>> If you think this structure should be added in accel/kvm/kvm-all.c, I will move it.
> It can be done later; but if you have to send a v13 series, I would be
> grateful if you included this change as well.
Ok, got it, thanks Paolo.

> 
> Paolo
> 
