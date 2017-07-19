Received: from eggs.gnu.org ([2001:4830:134:3::10]:58649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXoKT-0002RA-0b
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dXoKS-0007O1-8V
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:43:49 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dXoKS-0007NN-1j
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:43:48 -0400
Received: by mail-wm0-x233.google.com with SMTP id l81so3144616wmg.1
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 05:43:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170718154127.6459-1-quintela@redhat.com>
References: <20170718154127.6459-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Jul 2017 13:43:26 +0100
Message-ID: <CAFEAcA9WECc5b1BCcLcBJ2_sAb5k7XtkkC9SCKbiibWKd4X15A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/16] Migration
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

On 18 July 2017 at 16:41, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This pull request contain the RDMA migration fixes frmo Dave and
> migration properties changes by Peter.
>
> Please apply, Juan.
>
>
> The following changes since commit e9277a19a1a50ab5662c16795531bac332f142f9:
>
>   Merge remote-tracking branch 'remotes/mdroth/tags/qga-pull-2017-07-17-v2-tag' into staging (2017-07-18 14:14:32 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170718
>
> for you to fetch changes up to 6b19a7d91c8de9904c67b87203a46e55db4181ab:
>
>   migration: check global caps for validity (2017-07-18 17:36:26 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170718
>

Applied, thanks.

-- PMM
