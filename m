Received: from eggs.gnu.org ([2001:4830:134:3::10]:48328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLqBy-0008U9-If
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:22:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fLqBx-0004LS-Mh
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:22:06 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:35216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fLqBx-0004Kn-IB
	for qemu-devel@nongnu.org; Thu, 24 May 2018 09:22:05 -0400
Received: by mail-ot0-x230.google.com with SMTP id h8-v6so1891637otb.2
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 06:22:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 May 2018 14:21:44 +0100
Message-ID: <CAFEAcA98ab_8W1qtYW=nqQ0ePfaEWF7GeqN+_MB8e2YwwQg5TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/46] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23 May 2018 at 14:11, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit 4f50c1673a89b07f376ce5c42d22d79a79cd466d:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-05-22 09:43:58 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to bdebdc712b06ba82e103d617c335830682cde242:
>
>   qemu-iotests: Test job-* with block jobs (2018-05-23 14:30:52 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Generic background jobs
> - qemu-iotests fixes for NFS and the 'migration' group
> - sheepdog: Minor code simplification
>

Applied, thanks.

-- PMM
