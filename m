Received: from eggs.gnu.org ([2001:4830:134:3::10]:36211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdbv-00017D-48
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdbu-0000do-6x
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:57:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVdbu-0000dc-1x
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:57:22 -0400
Received: by mail-oi0-x244.google.com with SMTP id i205-v6so3103011oib.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:57:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529072910-16156-2-git-send-email-eric.auger@redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
	<1529072910-16156-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 14:57:00 +0100
Message-ID: <CAFEAcA-wS9oy1JSgpwrCZie9GQaKLOf2wQxZOUtaLfw+HGP_GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 01/11] linux-headers: Update to 4.18-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>

On 15 June 2018 at 15:28, Eric Auger <eric.auger@redhat.com> wrote:
> commit b357bf6023a948cf6a9472f07a1b0caac0e4f8e8
> Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

What's 4.18-rc0? The upstream kernel doesn't have a tag by that
name and looking at the Makefile the last thing before 4.18-rc1
was 4.17.

Still, since it is a commit on mainline I guess we're fine?

thanks
-- PMM
