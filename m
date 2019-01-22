Received: from eggs.gnu.org ([209.51.188.92]:34415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glsfI-0006Ur-HC
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glsfF-0000rm-KT
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:15 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:32990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glsfF-0000q1-6k
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:48:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id i20so23130353otl.0
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 01:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 09:48:01 +0000
Message-ID: <CAFEAcA91sS7GSu=GcFmEe+=jKDw1BzZh24B8zq6g8nB+z0aZ=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL 00/10] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, kamalheib1@gmail.com, Li Qiang <liq3ea@163.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Sat, 19 Jan 2019 at 10:03, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit a8d2b0685681e2f291faaa501efbbd76875f8ec8:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190118' into staging (2019-01-18 16:56:15 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to 0f645ba16c6b76ccf2076d38460aa998198893bc:
>
>   contrib/rdmacm-mux: fix clang compilation (2019-01-19 11:01:57 +0200)
>
> ----------------------------------------------------------------
> RDMA queue
>  * Clang compilation fix
>  * Coverity fix
>  * Various fixes for the pvrdma device
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
