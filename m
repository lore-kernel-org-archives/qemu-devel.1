Received: from eggs.gnu.org ([2001:4830:134:3::10]:43089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f61yS-0006xE-D2
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 18:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f61yR-0004uj-D6
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 18:42:48 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:37515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f61yR-0004uJ-89
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 18:42:47 -0400
Received: by mail-ot0-x230.google.com with SMTP id y46-v6so14653738otd.4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 15:42:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410132200.187832-1-eblake@redhat.com>
References: <20180410132200.187832-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 23:42:26 +0100
Message-ID: <CAFEAcA_qBNOXY_WVoarnBrLCA5SAEnRND0y1YY+y=VuV36MB4A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI patches for 2018-04-10, 2.12-rc3
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

On 10 April 2018 at 14:21, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit fb4fe32d5b6290deabe752b51cc1cc2a9e8573db:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20180409-xtensa' into staging (2018-04-10 10:22:45 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-04-10
>
> for you to fetch changes up to 951702f39c7e31530ce4ea65b11fe25ea1ea9c37:
>
>   monitor: bind dispatch bh to iohandler context (2018-04-10 07:49:43 -0500)
>
> Hopefully the last of the fixes for regressions caused by OOB which
> could be observed even when x-oob=on is not used.
>
> ----------------------------------------------------------------
> qapi patches for 2018-04-10
>
> - Peter Xu: iotests: fix wait_until_completed()
> - Peter Xu: iothread: workaround glib bug which hangs qmp-test
> - Peter Xu: monitor: bind dispatch bh to iohandler context
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
