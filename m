Received: from eggs.gnu.org ([2001:4830:134:3::10]:43542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcShy-0006WD-DJ
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:43:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcShx-00043p-HM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:43:50 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:46934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcShx-00043f-AM
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 05:43:49 -0400
Received: by mail-oi0-x241.google.com with SMTP id y207-v6so34676317oie.13
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 02:43:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180708015554.297823-1-eblake@redhat.com>
References: <20180708015554.297823-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 10:43:28 +0100
Message-ID: <CAFEAcA-C2X5gGAGF4ReJrp5MXGpaRhbotyD1KmFzQ=L1E9=WRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] NBD patches for 3.0
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

On 8 July 2018 at 02:55, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300f8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-07-06 18:18:08 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-07-07
>
> for you to fetch changes up to 0c0eaed14721f8a9db334deb35316411c512059a:
>
>   nbd/server: fix nbd_co_send_block_status (2018-07-07 20:30:09 -0500)
>
> Not much since my last pull request, but since I will be offline until
> after rc1, I thought I'd get this one in now.
>
> ----------------------------------------------------------------
> nbd patches for 2018-07-07
>
> Minor improvement for tracing of NBD block status
>
> - Vladimir Sementsov-Ogievskiy: nbd/server: fix nbd_co_send_block_status
>
> ----------------------------------------------------------------
> Vladimir Sementsov-Ogievskiy (1):
>       nbd/server: fix nbd_co_send_block_status
>
>  nbd/server.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
Applied, thanks.

-- PMM
