Received: from eggs.gnu.org ([2001:4830:134:3::10]:49168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs4zC-0000YU-2C
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fs4zB-00021p-CN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:38:10 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fs4zB-00021M-4r
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 07:38:09 -0400
Received: by mail-oi0-x243.google.com with SMTP id s198-v6so31389603oih.11
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 04:38:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820202604.14218-1-laurent@vivier.eu>
References: <20180820202604.14218-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Aug 2018 12:37:48 +0100
Message-ID: <CAFEAcA-d8o-DuO+TSm_OZj25Bp0pQf7fkpe7-sE6x3A3SnOQUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 20 August 2018 at 21:25, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>
> for you to fetch changes up to 70c61d4f78cc8475b597f1ef26faf232302b81d1:
>
>   linux-user: add QEMU_IFLA_INFO_KIND nested type for tun (2018-08-20 22:07:40 +0200)
>
> ----------------------------------------------------------------
> linux-user fixes:
> - netlink fixes (add missing types, fix MSG_TRUNC)
> - sh4 fix (tcg state)
> - sparc32plus fix (truncate address space to 32bit)
> - add x86_64 binfmt data
>


Applied, thanks.

-- PMM
