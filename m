Received: from eggs.gnu.org ([209.51.188.92]:43928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2E6Q-0000Z9-Io
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:55:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2E6P-0002jz-Kb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:55:50 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:45282)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2E6P-0002Y0-8X
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:55:49 -0500
Received: by mail-ot1-x32c.google.com with SMTP id i12so17108475otp.12
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 03:55:48 -0800 (PST)
MIME-Version: 1.0
References: <20190307205844.20236-1-pbonzini@redhat.com>
In-Reply-To: <20190307205844.20236-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 11:55:35 +0000
Message-ID: <CAFEAcA-3C7-mSLe=O0fpUyvgBa9pTRGfDw9b_GQ4KcV4_jO8gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/54] Kconfig conversion,
 excluding ARM and MIPS
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

On Thu, 7 Mar 2019 at 21:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2a6:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-03-07 16:16:02 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-kconfig
>
> for you to fetch changes up to 576c3f2f16e7392e28cc9fe10d9a920d67d3645b:
>
>   kconfig: add documentation (2019-03-07 21:54:22 +0100)
>
> ----------------------------------------------------------------
> Initial Kconfig work, excluding ARM and MIPS
>
> ----------------------------------------------------------------
>
> v2->v3: fix UTF-8, adjust documentation patch for Sphinx
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
