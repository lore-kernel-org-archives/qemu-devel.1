Received: from eggs.gnu.org ([2001:4830:134:3::10]:55877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3oCG-0002Gu-JN
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 15:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3oCF-0002uu-PE
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 15:35:52 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:43836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3oCF-0002uh-JR
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 15:35:51 -0400
Received: by mail-oi0-x22d.google.com with SMTP id u84-v6so20335122oie.10
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 12:35:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180404161023.19211-1-jcody@redhat.com>
References: <20180404161023.19211-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 20:35:30 +0100
Message-ID: <CAFEAcA8ZiLkt2O5GTHTrYM+s1wzQ-VOR2Axs5xdvKG2rTyT+3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.12 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 4 April 2018 at 17:10, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit fd69ad866b62ca8ed4337ffee83b6d82a4e99282:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-04-04 14:00:07 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to bfb15b4becf2c9cf484bc3bf893a37c8f3c15cb3:
>
>   block/rbd: remove processed options from qdict (2018-04-04 12:05:13 -0400)
>
> ----------------------------------------------------------------
> Regression fix for 2.12
> ----------------------------------------------------------------
>
> Jeff Cody (1):
>   block/rbd: remove processed options from qdict
>
>  block/rbd.c | 7 +++++++
>  1 file changed, 7 insertions(+)


Applied, thanks.

-- PMM
