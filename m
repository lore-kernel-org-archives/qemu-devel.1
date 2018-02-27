Received: from eggs.gnu.org ([2001:4830:134:3::10]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqeaG-0001td-JS
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqeaF-0002Aj-Qh
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:42:16 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:32865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqeaF-0002AL-LI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 07:42:15 -0500
Received: by mail-ot0-x229.google.com with SMTP id y11so3639360otg.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 04:42:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180225175928.13101-1-laurent@vivier.eu>
References: <20180225175928.13101-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 12:41:54 +0000
Message-ID: <CAFEAcA_651iDZ=zSY7cmUX1UuacxXZoksdtK8XeH8cremvxwOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 25 February 2018 at 17:59, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
>
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>
> for you to fetch changes up to 45506bddba6fe73f61cf15fb682ffff73ce156c0:
>
>   linux-user: MIPS set cpu to r6 CPU if binary is R6 (2018-02-25 17:29:45 +0100)
>
> ----------------------------------------------------------------
> This pull request includes new version of patches of the previous
> one that were breaking some linux-user targets.
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
