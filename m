Received: from eggs.gnu.org ([2001:4830:134:3::10]:39665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gahoP-0004vD-8o
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 08:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gahoO-0001w0-7f
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 08:59:29 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gahoM-0001uJ-Gn
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 08:59:28 -0500
Received: by mail-ot1-x32a.google.com with SMTP id i20so7670378otl.0
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 05:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Dec 2018 13:59:13 +0000
Message-ID: <CAFEAcA-s2koSnDTC_O0_nH5Kkg4xrSALcsAR8aQXwJ-P61-eCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL 00/31] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, Prasad J Pandit <pjp@fedoraproject.org>

On Sat, 22 Dec 2018 at 09:50, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit 891ff9f4a371da2dbd5244590eb35e8d803e18d8:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.0-20181221' into staging (2018-12-21 15:49:59 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to f1e2e38ee0136b7710a2caa347049818afd57a1b:
>
>   pvrdma: check return value from pvrdma_idx_ring_has_ routines (2018-12-22 11:09:57 +0200)
>
> ----------------------------------------------------------------
> RDMA queue
>  * Add support for RDMA MAD
>  * Various fixes for the pvrdma backend
>
> ----------------------------------------------------------------
Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
