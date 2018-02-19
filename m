Received: from eggs.gnu.org ([2001:4830:134:3::10]:45563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enoY8-0000Sk-GS
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enoY7-0003jE-Hj
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:44:20 -0500
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:42841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1enoY7-0003j1-Br
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:44:19 -0500
Received: by mail-ot0-x235.google.com with SMTP id a7so8985221otk.9
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 08:44:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180219114332.70443-1-marcel@redhat.com>
References: <20180219114332.70443-1-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 16:43:58 +0000
Message-ID: <CAFEAcA-jiwjgXmGiaTfFD1iFHgcr1p2AVLX4mF7DVn=eDqUVNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL v2 00/10] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com

On 19 February 2018 at 11:43, Marcel Apfelbaum <marcel@redhat.com> wrote:
> Hi Peter,
>
> Changes from V1:
>  * split the rdma patch into several patches.
>  * fixed license issues.
>  * moved Linux headers to standard-headers and fixed the used types.
>  * R-B tags on all code files (patch 4/10 doesn't have an R-B tag,
>    but is an automatic import of Linux kernel headers).
>
> The following changes since commit e5ecc287a7bd24a1364e23e263cb60cfc8d21eb5:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20180216' into staging (2018-02-16 18:39:05 +0000)
>
> are available in the git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to a3defabbb58b7c1c060e7698def237a31a4cc161:
>
>   MAINTAINERS: add entry for hw/rdma (2018-02-19 13:03:24 +0200)
>
> ----------------------------------------------------------------
> PVRDMA implementation
>

Applied to master. Thanks for doing the various improvements over v1.

-- PMM
