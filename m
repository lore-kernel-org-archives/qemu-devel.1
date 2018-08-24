Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ft8zt-0007Pb-Cp
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:07:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ft8zs-0007ma-LR
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:07:17 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ft8zs-0007mB-EL
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 06:07:16 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so14368189oie.13
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 03:07:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823164756.16948-1-pbonzini@redhat.com>
References: <20180823164756.16948-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 11:06:55 +0100
Message-ID: <CAFEAcA-C-4o4NzSi9qUiiamdOBoLwT8rk+WHbJecGg82tZv1rA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/69] Misc patches for 2018-08-21
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

On 23 August 2018 at 17:47, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 659b11e7a7239529cfdb4968418268ff9aa22d=
88:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-p=
ull-request' into staging (2018-08-21 11:36:15 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b2e78fac6f27c36938353e477354778896adc08f:
>
>   KVM: cleanup unnecessary #ifdef KVM_CAP_... (2018-08-23 18:46:25 +0200)
>
> ----------------------------------------------------------------
> * x86 TCG fixes for 64-bit call gates (Andrew)
> * qumu-guest-agent freeze-hook tweak (Christian)
> * pm_smbus improvements (Corey)
> * Move validation to pre_plug for pc-dimm (David)
> * Fix memory leaks (Eduardo, Marc-Andr=C3=A9)
> * synchronization profiler (Emilio)
> * Convert the CPU list to RCU (Emilio)
> * LSI support for PPR Extended Message (George)
> * vhost-scsi support for protection information (Greg)
> * Mark mptsas as a storage device in the help (Guenter)
> * checkpatch tweak cherry-picked from Linux (me)
> * Typos, cleanups and dead-code removal (Julia, Marc-Andr=C3=A9)
> * qemu-pr-helper support for old libmultipath (Murilo)
> * Annotate fallthroughs (me)
> * MemoryRegionOps cleanup (me, Peter)
> * Make s390 qtests independent from libqos, which doesn't actually suppor=
t it (me)
> * Make cpu_get_ticks independent from BQL (me)
> * Introspection fixes (Thomas)
> * Support QEMU_MODULE_DIR environment variable (ryang)

Applied, thanks.

-- PMM
