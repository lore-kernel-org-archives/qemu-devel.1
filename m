Received: from eggs.gnu.org ([2001:4830:134:3::10]:56080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsouu-0003QU-3l
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fsout-0003ng-Dc
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:40:48 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fsout-0003mh-64
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 08:40:47 -0400
Received: by mail-oi0-x243.google.com with SMTP id z185-v6so8540696oia.5
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 05:40:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180822011417.11608-1-laurent@vivier.eu>
References: <20180822011417.11608-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 13:40:25 +0100
Message-ID: <CAFEAcA_4OZ6yFW6n0wggU5uT56+NvWG9sF-UrwEe4CMH7pUmYw@mail.gmail.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 22 August 2018 at 02:14, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180821-pull-request' into staging (2018-08-21 15:57:56 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>
> for you to fetch changes up to 259841c153698325e12f0186f349e1366616434e:
>
>   linux-user: Propagate goto fail to return (2018-08-21 23:54:48 +0200)
>
> ----------------------------------------------------------------
> This pull-request includes pre-requisite patches for the
> "split do_syscall()" series. As they are clean-up, we can already
> merge them.
>
> ----------------------------------------------------------------


Applied, thanks.

-- PMM
