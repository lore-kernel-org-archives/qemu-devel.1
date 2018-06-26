Received: from eggs.gnu.org ([2001:4830:134:3::10]:37665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXmTT-0002U2-IU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXmTS-0003Fe-Nq
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:49:31 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:41516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXmTS-0003FM-Ht
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 07:49:30 -0400
Received: by mail-oi0-x232.google.com with SMTP id 21-v6so5024851oip.8
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 04:49:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625222524.382-1-ehabkost@redhat.com>
References: <20180625222524.382-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 12:49:09 +0100
Message-ID: <CAFEAcA_ORsh-bkthNt1xZ=4T2bmHwMLEw+RRRWdUozotS_YbQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/12] x86 queue, 2018-06-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 25 June 2018 at 23:25, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 35e238c9330669882487f9929e0aa97900431853:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging (2018-06-25 15:25:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 0b6e9aa89e02c8b213af019aad816e00ba8243f8:
>
>   Merge branch 'master' of git://git.qemu.org/qemu into x86-next (2018-06-25 14:10:56 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2018-06-25
>
> * Add TOPOEXT feature to EPYC CPU model
> * AMD's amd-ssbd and amd-no-ssbd CPUID features
> * Removed unused CPUID flag names: ospke, osxsave
> * Better formatting of '-cpu help'
>
Applied, thanks.

-- PMM
