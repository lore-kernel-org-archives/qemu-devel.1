Received: from eggs.gnu.org ([209.51.188.92]:58773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3QHC-0002gu-W2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3QF7-0005qP-Ej
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:05:46 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3QF6-0005pu-O2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:05:44 -0400
Received: by mail-oi1-x22a.google.com with SMTP id e7so4578468oia.8
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552323335-46779-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 19:05:32 +0000
Message-ID: <CAFEAcA-c0qW1bzc4Sa5+SL2v3y_x_qRU0JMEEDqaO2BWFPNU4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/31] Misc patches for 2019-03-09
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

On Mon, 11 Mar 2019 at 17:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 79d8b1dc5b44d806d9700f2e8a8028075a8ff2b2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190311-v2-pull-request' into staging (2019-03-11 12:52:44 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 328eb60dc1a19448b36eb63901ca0b8f87ed6f57:
>
>   qemugdb: fix licensing (2019-03-11 16:55:52 +0100)
>
> ----------------------------------------------------------------
> * allow building QEMU without TCG or KVM support (Anthony)
> * update AMD IOMMU copyright (David)
> * compilation fixes for GCC and BSDs (Alexey, David, Paolo, Philippe)
> * coalesced I/O bugfix (Jagannathan)
> * Processor Tracing cpuid fix (Luwei)
> * Kconfig fixes (Paolo, David)
> * Cleanups (Paolo, Wei)
> * PVH vs. multiboot fix (Stefano)
> * LSI bugfixes (Sven)
> * elf2dmp Coverity fix (Victor)
> * scsi-disk fix (Zhengui)
> * authorization support for chardev TLS (Daniel)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
