Received: from eggs.gnu.org ([209.51.188.92]:42886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwp4o-0002Ng-C0
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwp4m-000698-GA
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:11:50 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:36103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwp4k-00065l-Jt
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:11:48 -0500
Received: by mail-ot1-x32c.google.com with SMTP id v62so36132424otb.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20190220180112.28250-1-jsnow@redhat.com>
In-Reply-To: <20190220180112.28250-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 14:11:32 +0000
Message-ID: <CAFEAcA-LV5cz3mXBMY3StBaqF2cFXi6GM+jZTDz9wO6nks8ZkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/3] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 20 Feb 2019 at 18:01, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 2e68b8620637a4ee8c79b5724144b726af1e261b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20190219' into staging (2019-02-18 16:20:13 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to 0a6c86d024c52b1e66d4f7ec01a3bb8ea2600145:
>
>   blockdev: acquire aio_context for bitmap add/remove (2019-02-19 17:49:43 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
