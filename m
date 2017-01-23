Received: from eggs.gnu.org ([2001:4830:134:3::10]:41930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVbXB-00023E-5V
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVbXA-0000hK-DJ
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:07:33 -0500
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:32856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVbXA-0000gx-8F
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:07:32 -0500
Received: by mail-vk0-x229.google.com with SMTP id k127so87116682vke.0
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 02:07:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170120133139.31080-1-pbonzini@redhat.com>
References: <20170120133139.31080-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 10:07:09 +0000
Message-ID: <CAFEAcA89j4GXDCpDm7q9cB9hVzFMJy-q00ZmzyHut3KfCD8UyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v3 00/32] Misc patches for 2017-01-11
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

On 20 January 2017 at 13:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 2ccede18bd24fce5db83fef3674563a1f256717b:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2017-01-16 12:41:35 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to abc62c89f3191774dbd600a2caec803cbf557160:
>
>   pc.h: move x-mach-use-reliable-get-clock compat entry to PC_COMPAT_2_8 (2017-01-20 13:22:57 +0100)

Merge conflict here in the bit with the x-mach-use-reliable-get-clock
entry in the PC_COMPAT stuff, so you should check that it got
resolved correctly this time around.

Applied to master, thanks.

thanks
-- PMM
