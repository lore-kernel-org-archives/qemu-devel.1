Received: from eggs.gnu.org ([2001:4830:134:3::10]:60907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW0OP-0006Wo-Qz
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dW0OP-00029w-2y
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:12:25 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:34312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dW0OO-00029c-Tf
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:12:25 -0400
Received: by mail-wm0-x235.google.com with SMTP id 70so9710410wmo.1
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 06:12:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
References: <1500027028-4127-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 14:12:03 +0100
Message-ID: <CAFEAcA_sDjJ4LS844atmeth2bxg_2H1FmnAa1t7P=zHApd+bzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/55] Misc patches for QEMU 2.10 soft
 freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 July 2017 at 11:10, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 49bcce4b9c11759678fd223aefb48691c4959d4f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-07-12' into staging (2017-07-13 16:56:06 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 68c761e19c2ea453f880dbbd04e867d34d1468b8:
>
>   spapr_rng: Convert to DEFINE_PROP_LINK (2017-07-14 12:04:43 +0200)
>
> ----------------------------------------------------------------
> * gdbstub fixes (Alex)
> * IOMMU MemoryRegion subclass (Alexey)
> * Chardev hotswap (Anton)
> * NBD_OPT_GO support (Eric)
> * Misc bugfixes
> * DEFINE_PROP_LINK (minus the ARM patches - Fam)
> * MAINTAINERS updates (Philippe)

Applied, thanks.

-- PMM
