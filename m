Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diIFm-0003TP-LR
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1diIFl-0005C6-QW
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:18 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1diIFl-0005Bw-Im
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:42:17 -0400
Received: by mail-wr0-x22b.google.com with SMTP id 49so31189302wrw.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 03:42:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170808132300.uyrrmgoij4qlwy52@kamzik.brq.redhat.com>
References: <1500471597-2517-1-git-send-email-drjones@redhat.com>
	<20170808132300.uyrrmgoij4qlwy52@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Aug 2017 11:41:55 +0100
Message-ID: <CAFEAcA8NLFVitFfMxKC3Tp7u_azFkOSnWBcddhUCF5Fx2dm+aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] ARM: KVM: Enable in-kernel PMU with
 user space gic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alexander Graf <agraf@suse.de>, Christoffer Dall <cdall@linaro.org>

On 8 August 2017 at 14:23, Andrew Jones <drjones@redhat.com> wrote:
>
> Peter,
>
> ping?

I've applied this to target-arm.next ready for the first 2.11
ARM pullreq. Sorry for the delay, I'd put not-for-2.10 patch
review onto the back burner since I knew nothing was going to
go into master til after the release...

thanks
-- PMM
