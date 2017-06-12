Received: from eggs.gnu.org ([2001:4830:134:3::10]:43235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKLsr-0007LQ-3b
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKLsq-0006uu-96
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:43:41 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKLsq-0006u8-2R
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 05:43:40 -0400
Received: by mail-wr0-x22f.google.com with SMTP id v104so89607263wrb.0
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 02:43:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607162253.14134-1-pbonzini@redhat.com>
References: <20170607162253.14134-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jun 2017 10:43:16 +0100
Message-ID: <CAFEAcA_cAmZPR3Yp2XR7g5hEgtsLrB9QXA0xMGJH6cDVWsoZag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v6 00/31] Misc patches for 2017-06-01
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

On 7 June 2017 at 17:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ac06724a715864942e2b5e28f92d5d5421f0a0b0:
>
>   docs: create config/, devel/ and spin/ subdirectories (2017-06-07 18:22:03 +0200)
>
> ----------------------------------------------------------------
> * virtio-scsi use-after-free fix (Fam)
> * SMM fixes and improvements for TCG (myself, Mihail)
> * irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
> * Coverity fix (Stefano)
> * NBD cleanups and fixes (Vladimir, Eric, myself)
> * RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
> * socket error reporting improvement (Daniel)
> * GDB XML description for SSE registers (Abdallah)
> * kvmclock update fix (Denis)
> * SMM memory savings (Gonglei)
> * -cpu 486 fix (myself)
> * various bugfixes (Roman, Peter, myself, Thomas)
> * rtc-test improvement (Guangrong)
> * migration throttling fix (Felipe)
> * create docs/ subdirectories (myself)
>

Applied, thanks.

-- PMM
