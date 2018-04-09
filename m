Received: from eggs.gnu.org ([2001:4830:134:3::10]:53973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5Waj-0005Aj-EN
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5Wai-0003cG-IK
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:12:13 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:41794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5Wai-0003bk-A4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 09:12:12 -0400
Received: by mail-oi0-x229.google.com with SMTP id 188-v6so7512970oih.8
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 06:12:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180409094100.27650-1-kraxel@redhat.com>
References: <20180409094100.27650-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 14:11:51 +0100
Message-ID: <CAFEAcA-9gV1k7nxd27rv3FZYrTvN8K5vxhfuyv9ecpPSp7tuMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Ui 20180409 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 April 2018 at 10:40, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 094b62cd9cd9f137cf75b4931e41b8953fb4ccd9:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-04-04 11:13:52 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20180409-pull-request
>
> for you to fetch changes up to 1458da9131c39ca99699b521436d6ce72d7c7981:
>
>   sdl2: drop dead code (2018-04-09 10:40:47 +0200)
>
> ----------------------------------------------------------------
> sdl2: fix kbd regression (compared to sdl1), cleanups.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
