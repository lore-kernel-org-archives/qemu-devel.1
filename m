Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPpTC-0006YR-Vh
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:24:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fPpTC-0004yf-6f
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:24:22 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:40090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fPpTB-0004yT-V2
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 09:24:22 -0400
Received: by mail-ot0-x22d.google.com with SMTP id n1-v6so37572248otf.7
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 06:24:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604042156.13812-1-quintela@redhat.com>
References: <20180604042156.13812-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Jun 2018 14:24:00 +0100
Message-ID: <CAFEAcA9+HaW=m46WZQaBPWTC-Wo9_9CjN_3993gmuGcC35ngiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 4 June 2018 at 05:21, Juan Quintela <quintela@redhat.com> wrote:
> The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce014=
7a:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-=
010618-1' into staging (2018-06-01 17:32:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180604
>
> for you to fetch changes up to c5e76115ccb4979cec795a8ae38becd07c2fde9f:
>
>   migration: not wait RDMA_CM_EVENT_DISCONNECTED event after rdma_disconn=
ect (2018-06-04 05:46:15 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20180604
>
> - RDMA fixes from (lidong)
> - Fix docempress-error-check (Xiao)
> - make -S and block work better (dave)
> - don't migrate "bad" ramblocks (C=C3=A9dric)
>
> Please apply, Juan.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
