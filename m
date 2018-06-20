Received: from eggs.gnu.org ([2001:4830:134:3::10]:37619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVdhp-0003cs-5s
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:03:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVdhj-0003Ca-A0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:03:29 -0400
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
	<1529072910-16156-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-wS9oy1JSgpwrCZie9GQaKLOf2wQxZOUtaLfw+HGP_GA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7fc96a3d-f1e2-7ab4-a46d-3d3482cc5e71@redhat.com>
Date: Wed, 20 Jun 2018 16:03:08 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wS9oy1JSgpwrCZie9GQaKLOf2wQxZOUtaLfw+HGP_GA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] linux-headers: Update to 4.18-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>

Hi Peter,
On 06/20/2018 03:57 PM, Peter Maydell wrote:
> On 15 June 2018 at 15:28, Eric Auger <eric.auger@redhat.com> wrote:
>> commit b357bf6023a948cf6a9472f07a1b0caac0e4f8e8
>> Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> What's 4.18-rc0? The upstream kernel doesn't have a tag by that
> name and looking at the Makefile the last thing before 4.18-rc1
> was 4.17.
> 
> Still, since it is a commit on mainline I guess we're fine?
Yes it is post 4.17 and before 4.18-rc1. I didn't know how to call that.

Thanks

Eric
> 
> thanks
> -- PMM
> 
