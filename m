Received: from eggs.gnu.org ([209.51.188.92]:58846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr1IF-0001xN-Hv
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:01:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr1I7-0002kE-DU
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:01:43 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:36416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr1I4-0002j6-1n
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:01:33 -0500
Received: by mail-ot1-x32d.google.com with SMTP id k98so5812443otk.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 06:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20190205035704.26014-1-eblake@redhat.com>
In-Reply-To: <20190205035704.26014-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 14:01:17 +0000
Message-ID: <CAFEAcA9OLtGPVrngO3shmAdtjALTRWWLdQm1cNEwtFm_8YdrTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] NBD patches for 2019-02-04
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

On Tue, 5 Feb 2019 at 03:58, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 773c4a6228fd910556cee2d477ee56c591a30000:
>
>   test-filter-mirror: pass UNIX domain socket through fd (2019-02-04 16:03:20 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-04
>
> for you to fetch changes up to bc5a03350c220698229e7d6929dd242d5d358345:
>
>   block/nbd-client: rename read_reply_co to connection_co (2019-02-04 15:11:27 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2019-02-04
>
> - deprecate 'qemu-nbd --partition'
> - preparation for NBD reconnect, including better logging of read errors
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
