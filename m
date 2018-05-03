Received: from eggs.gnu.org ([2001:4830:134:3::10]:46301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEBQT-0005QS-28
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:25:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEBQR-0006Kx-Of
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:25:25 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEBQR-0006KQ-H7
	for qemu-devel@nongnu.org; Thu, 03 May 2018 06:25:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id p62-v6so15582484oie.10
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 03:25:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502111318.129888-1-groug@kaod.org>
References: <20180502111318.129888-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 11:25:01 +0100
Message-ID: <CAFEAcA9TzFw-_FKV4H7QrkkNydjC=FRkcA6r8JJkrUOSY59OuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] 9p patches for 2.13 20180502
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 May 2018 at 12:13, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 26bd8d98c4b3284a4c6fe3b67c98b1edd00e9beb:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.13-pull-request' into staging (2018-05-01 15:26:06 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8f9c64bfa584ab66b8bcbfc162efa179f7f1cd41:
>
>   9p: add trace event for v9fs_setattr() (2018-05-02 08:59:24 +0200)
>
> ----------------------------------------------------------------
> Just one trace
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       9p: add trace event for v9fs_setattr()
>
>  hw/9pfs/9p.c         | 5 +++++
>  hw/9pfs/trace-events | 2 ++
>  2 files changed, 7 insertions(+)

Applied, thanks.

-- PMM
