Received: from eggs.gnu.org ([2001:4830:134:3::10]:57480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erl3Y-0004wL-Fu
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:49:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erl3X-0008Ro-Mm
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:49:04 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:46351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erl3X-0008Ra-HI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 08:49:03 -0500
Received: by mail-ot0-x232.google.com with SMTP id g97so8733484otg.13
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 05:49:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180301210249.14872-1-eblake@redhat.com>
References: <20180301210249.14872-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 13:48:42 +0000
Message-ID: <CAFEAcA-HNekDVjbY5qyG4hOQ51JwN2XJSkYqo8bBq4ntqf06Ew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] nbd patches for 2018-03-01
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

On 1 March 2018 at 21:02, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c67:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' into staging (2018-03-01 17:08:16 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-nbd-2018-03-01
>
> for you to fetch changes up to 28fb494f9b8827c6087d515e20a3c78baaf443cc:
>
>   nbd/client: fix error messages in nbd_handle_reply_err (2018-03-01 14:48:23 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2018-03-01
>
> - Eric Blake: nbd: Honor server's advertised minimum block size
> - Vladimir Sementsov-Ogievskiy: partial: nbd block status base:allocation
>
> ----------------------------------------------------------------
> Eric Blake (1):
>       nbd: Honor server's advertised minimum block size
>
> Vladimir Sementsov-Ogievskiy (3):
>       nbd: change indenting in nbd.h
>       nbd: BLOCK_STATUS constants
>       nbd/client: fix error messages in nbd_handle_reply_err

Applied, thanks.

-- PMM
