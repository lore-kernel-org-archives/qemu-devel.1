Received: from eggs.gnu.org ([209.51.188.92]:45167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2j09-0003fp-Qm
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2j09-0007Ft-14
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:55:25 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2j08-0007Do-Lt
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 15:55:24 -0500
Received: by mail-oi1-x234.google.com with SMTP id t206so811918oib.3
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 12:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20190308165344.10685-1-stefanha@redhat.com>
In-Reply-To: <20190308165344.10685-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2019 20:55:11 +0000
Message-ID: <CAFEAcA9muwNYJ9UdYqvP8Bcu-ZZ9QU7NsneRgObkjjY9mmsz5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On Fri, 8 Mar 2019 at 16:53, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2a6:
>
>   Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-request' into staging (2019-03-07 16:16:02 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 6ca206204fa773c8626d59caf2a5676d6cc35f52:
>
>   iothread: document about why we need explicit aio_poll() (2019-03-08 10:20:57 +0000)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
