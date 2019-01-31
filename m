Received: from eggs.gnu.org ([209.51.188.92]:54879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAOW-0000m0-Pq
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAOU-00075b-KO
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:20:32 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:37384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpAOU-00072M-8l
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:20:30 -0500
Received: by mail-ot1-x335.google.com with SMTP id s13so2485446otq.4
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:20:24 -0800 (PST)
MIME-Version: 1.0
References: <20190128193834.3823-1-ehabkost@redhat.com>
In-Reply-To: <20190128193834.3823-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:20:13 +0000
Message-ID: <CAFEAcA95KP-88dsq+2s9Daw7bGmYjARn=b0t+kpS5+XG_x=6HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] x86 queue, 2019-01-28
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

On Mon, 28 Jan 2019 at 19:38, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 5f39a91dbd9a186edb999afd4d17524f4b1da14f:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' into staging (2019-01-28 12:54:06 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 9fe8b7be17eaac4cfde4083000cc96747d7cf4f8:
>
>   i386: Enable NPT and NRIPSAVE for AMD CPUs (2019-01-28 15:51:54 -0200)
>
> ----------------------------------------------------------------
> x86 queue, 2019-01-28
>
> Two small CPU model updates:
> * Enable NPT and NRIPSAVE on AMD CPUs
> * Update stepping of Cascadelake-Server
>
> ----------------------------------------------------------------
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
