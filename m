Received: from eggs.gnu.org ([2001:4830:134:3::10]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPbC-00071d-2c
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTPbB-0006VK-5z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:35:26 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:35292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTPbA-0006U9-Hl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:35:25 -0400
Received: by mail-ot0-x22d.google.com with SMTP id q17-v6so6495264otg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 03:35:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 11:35:02 +0100
Message-ID: <CAFEAcA_R4KdQibHS0HnsVfgmGTXfsnh4PO3pr=hGkTr8+x6czg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Linux user for 3.0 patches
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

On 12 June 2018 at 11:58, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 9f55925b8f50a962d1d08d815044db7767ae3838:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-3.0-pull-request' into staging (2018-06-11 12:46:16 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to dec1c928494f76ddd1484a7a4584ec18b1900a7a:
>
>   linux-user/sparc64: Add inotify_rm_watch and tee syscalls (2018-06-11 14:47:45 +0200)
>
> ----------------------------------------------------------------
> Fixes in syscall numbers,
> disable the build of binaries not needed for linux-user,
> update of qemu-binfmt-conf.sh and cleanup around is_error()

Applied, thanks.

-- PMM
