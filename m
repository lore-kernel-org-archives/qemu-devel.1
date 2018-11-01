Received: from eggs.gnu.org ([2001:4830:134:3::10]:38261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGjn-0002ss-NT
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGjl-0004Bl-Nm
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:26:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:38188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIGjf-00043B-US
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:26:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id f24so12714129otl.5
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:26:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031140710.GG3902@habkost.net>
References: <20181031004550.15410-1-ehabkost@redhat.com>
	<20181031140710.GG3902@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 17:25:57 +0000
Message-ID: <CAFEAcA8SDBsigHe6t-fGqfKDCe_WuSrn+S7O4JOpXzzkeamx=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] x86 queue, 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>

On 31 October 2018 at 14:07, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Peter, my S-o-b line was missing on some commits, I have just pushed a new
> x86-next-pull-request tag, with exactly the same tree.  Sorry for the noise.
>
> Thanks to Eric Blake for reporting the issue.
>
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 09b9ee643f90ef95e30e594df2a3c83ccaf75b1f:
>
>   i386: Add PKU on Skylake-Server CPU model (2018-10-30 21:14:43 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2018-10-30
>
> * MSR-based feature support for
>   MSR_IA32_ARCH_CAPABILITIES bits (Robert Hoo)
> * Cascadelake-Server CPU model (Tao Xu)
> * Add PKU on Skylake-Server CPU model (Tao Xu)
> * Correct cpu_x86_cpuid(0xd) (Sebastian Andrzej Siewior)
> * Remove dead code (Peter Maydell)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
