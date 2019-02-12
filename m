Received: from eggs.gnu.org ([209.51.188.92]:47468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtVhP-0001Us-7Y
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:54:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtVhN-0006cO-RO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:53:59 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtVhN-0005p6-Gp
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:53:57 -0500
Received: by mail-ot1-x342.google.com with SMTP id w25so3510106otm.13
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 02:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20190211205128.27146-1-eblake@redhat.com>
In-Reply-To: <20190211205128.27146-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Feb 2019 10:53:22 +0000
Message-ID: <CAFEAcA8SsFqEDQ29bEkNtYK6gKZRpU35S_N6ySNsS6-uSg5yrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] NBD patches for 2019-02-11
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

On Mon, 11 Feb 2019 at 20:53, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2019-02-11
>
> for you to fetch changes up to ddd113beedd22908e676d53803843d2f85bf91ab:
>
>   qcow2: list of bitmaps new test 242 (2019-02-11 14:35:43 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2019-02-11
>
> - Add qcow2 bitmap details to 'qemu-img info'
>
> ----------------------------------------------------------------
> Andrey Shinkevich (3):
>       bdrv_query_image_info Error parameter added
>       qcow2: Add list of bitmaps to ImageInfoSpecificQCow2
>       qcow2: list of bitmaps new test 242
>
> Eric Blake (1):
>       nbd/server: Kill pointless shadowed variable

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
