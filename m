Received: from eggs.gnu.org ([209.51.188.92]:54904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVd6-00046g-N4
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:11:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVd5-0003j7-LP
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:11:48 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:43275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggVd3-0003hm-PI
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:11:47 -0500
Received: by mail-ot1-x330.google.com with SMTP id a11so381598otr.10
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20190105140100.26913-1-eblake@redhat.com>
In-Reply-To: <20190105140100.26913-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:11:32 +0000
Message-ID: <CAFEAcA8LpwCmRaGO2dUjk7G3V=2VyJSkueDMVG6k7fHR4RZqNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] NBD patches through 2019-01-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sat, 5 Jan 2019 at 14:03, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 9b2e891ec5ccdb4a7d583b77988848282606fdea:
>
>   Merge remote-tracking branch 'remotes/marcel/tags/rdma-pull-request' into staging (2018-12-22 11:25:31 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-01-05
>
> for you to fetch changes up to ef2e35fcc8e14bcc9366df5fdf53f65d679f8dca:
>
>   nbd/client: Drop pointless buf variable (2019-01-05 07:53:22 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2019-01-05
>
> Error and trace improvements in NBD code, such as less noise for
> common disconnect scenarios.
>
> - Vladimir Sementsov-Ogievskiy: 0/3 nbd-client: drop extra error noise
> - Eric Blake: portions of 0/22 nbd: add qemu-nbd --list
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
