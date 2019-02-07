Received: from eggs.gnu.org ([209.51.188.92]:39602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grh1E-0002RA-Qf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:34:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1grh1D-0000xw-Bs
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:34:56 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:42063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1grh1A-0000t1-T2
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:34:53 -0500
Received: by mail-ot1-x32c.google.com with SMTP id v23so17340357otk.9
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 02:34:50 -0800 (PST)
MIME-Version: 1.0
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Feb 2019 10:34:38 +0000
Message-ID: <CAFEAcA8UU_wb-ALhGyq2zdZoexBw-sKaAmWRXzFNn18YHLwjmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/76] misc patches for 2019-02-04
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

On Tue, 5 Feb 2019 at 18:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1c3d45df5e94042d5fb2bb31416072563ab30e49:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-02-04' into staging (2019-02-05 12:46:18 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 5ed76a4c63db9295c6c5d67895925810050d4a46:
>
>   queue: fix QTAILQ_FOREACH_REVERSE_SAFE (2019-02-05 16:50:21 +0100)
>
> ----------------------------------------------------------------
> * cpu-exec fixes (Emilio, Laurent)
> * TCG bugfix in queue.h (Paolo)
> * high address load for linuxboot (Zhijian)
> * PVH support (Liam, Stefano)
> * misc i386 changes (Paolo, Robert, Doug)
> * configure tweak for openpty (Thomas)
> * elf2dmp port to Windows (Viktor)
> * initial improvements to Makefile infrastructure (Yang + GSoC 2013)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
