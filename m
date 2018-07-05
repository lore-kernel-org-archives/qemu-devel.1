Received: from eggs.gnu.org ([2001:4830:134:3::10]:50455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fayZX-0005yG-Nu
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fayZW-0007Xr-TM
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:20:59 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:39787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fayZW-0007V9-Nh
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 03:20:58 -0400
Received: by mail-oi0-x232.google.com with SMTP id d189-v6so14940437oib.6
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 00:20:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703163451.16936-1-laurent@vivier.eu>
References: <20180703163451.16936-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 08:20:37 +0100
Message-ID: <CAFEAcA8hf5Cx+PZoH9_576PAwKVW3S55bmY-bTxAHgGt7f3Uew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Linux user for 3.0 patches
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

On 3 July 2018 at 17:34, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit ab08440a4ee09032d1a9cb22fdcab23bc7e1c656:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180702' into staging (2018-07-02 17:57:46 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to 377e93e9e85e76c7fd7af900ba965743243a6618:
>
>   linux-user/strace: Improve recvmsg() output (2018-07-03 16:27:15 +0200)
>
> ----------------------------------------------------------------
> Some strace cleanups
> Minor fixes for setsockopt() and netlink
> Manage 'F' flag with qemu-binfmt-conf.sh
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
