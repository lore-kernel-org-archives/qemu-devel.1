Received: from eggs.gnu.org ([2001:4830:134:3::10]:35900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEbws-0000Kn-7C
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEbwr-0002JN-BE
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:44:38 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:36977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEbwr-0002Iw-66
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:44:37 -0400
Received: by mail-ot0-x22e.google.com with SMTP id 77-v6so24731952otd.4
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 07:44:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180504133034.1328397-1-eblake@redhat.com>
References: <20180504133034.1328397-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 15:44:15 +0100
Message-ID: <CAFEAcA_uCWUP7hQnWDE+zQGjkvtQGQuwFjHhtEsvCnPoQ-dUMg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] 2.12 post-release NBD fixes, 2018-05-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 4 May 2018 at 14:30, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 26bd8d98c4b3284a4c6fe3b67c98b1edd00e9beb:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.13-pull-request' into staging (2018-05-01 15:26:06 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-05-04
>
> for you to fetch changes up to acfd8f7a5f92e703d2d046cbe3d510008a697194:
>
>   nbd/client: Relax handling of large NBD_CMD_BLOCK_STATUS reply (2018-05-04 08:23:39 -0500)
>
> Fix various issues with NBD in 2.12, some found by Coverity, and some by
> implementation interoperability testing.
>
> And May the Fourth be with you

Applied, but not with git push --force :-)

thanks
-- PMM
