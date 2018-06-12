Received: from eggs.gnu.org ([2001:4830:134:3::10]:35747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSfmK-00011F-2R
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSfmJ-00023a-6f
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:39:52 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:46269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSfmJ-00023E-05
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:39:51 -0400
Received: by mail-ot0-x22b.google.com with SMTP id q1-v6so27258683oth.13
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 02:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611172355.12067-1-ehabkost@redhat.com>
References: <20180611172355.12067-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 10:39:29 +0100
Message-ID: <CAFEAcA_qPG==oGyLZnfvHcq4my=yn0B5drH8Jcoj+K_jY6ji4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] x86 queue, 2018-06-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

On 11 June 2018 at 18:23, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 0d2fa03dae4fbe185a082f361342b1e30aed4582:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180608' into staging (2018-06-08 16:26:51 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 1fb6752ecf87fb132035d3c03b0b9ca012265492:
>
>   pc: Remove PC_COMPAT_2_12 from 3.0 machine-types (2018-06-10 21:33:00 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2018-06-11
>
> * Support for CPUID[0x8000001D] (AMD Cache Topology Information)
> * pc bug fix: Remove PC_COMPAT_2_12 from 3.0 machine-types
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
