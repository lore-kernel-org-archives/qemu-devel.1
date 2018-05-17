Received: from eggs.gnu.org ([2001:4830:134:3::10]:56857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJHrw-00049Y-UH
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJHrv-0006nb-RM
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:18:52 -0400
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:40724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJHrv-0006nE-Lr
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:18:51 -0400
Received: by mail-ot0-x229.google.com with SMTP id n1-v6so4770014otf.7
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 05:18:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180516174234.311-1-jcody@redhat.com>
References: <20180516174234.311-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 13:18:30 +0100
Message-ID: <CAFEAcA99=W0XFy+JGv-s8sJyab8HX7gL41H0J45Q5oqVfhuEWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 16 May 2018 at 18:42, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit c416eecea5f3aea863ab8fda5a36a24157b8f704:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2018-05-15 17:02:00 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to c82be42cc803b36fd7aed5dceec68312c7056fd5:
>
>   nfs: Remove processed options from QDict (2018-05-16 13:37:47 -0400)
>
> ----------------------------------------------------------------
> Block patches
> ----------------------------------------------------------------
>
> Kevin Wolf (2):
>   nfs: Fix error path in nfs_options_qdict_to_qapi()
>   nfs: Remove processed options from QDict
>
> Stefan Hajnoczi (2):
>   qemu-iotests: reduce chance of races in 185
>   blockjob: do not cancel timer in resume

Applied, thanks.

-- PMM
