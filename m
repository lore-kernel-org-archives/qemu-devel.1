Received: from eggs.gnu.org ([2001:4830:134:3::10]:57405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frmom-0001ow-S7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frmbn-0001Z6-6i
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:00:49 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frmbm-0001YY-V2
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:00:47 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so26646488oib.10
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 09:00:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
References: <20180819202300.10590-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 17:00:25 +0100
Message-ID: <CAFEAcA_=N4U_ohgw9_xQeCfdTViy2PZF1UD7vh_2U96UbdEYpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL 00/15] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, Thomas Huth <thuth@redhat.com>

On 19 August 2018 at 21:22, Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
> The following changes since commit 0abaa41d936becd914a16ee1fe2a981d96d19428:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2018-08-17 09:46:00 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to 21ab34c9543fe1b6d31b3edbd01a397e7e090d00:
>
>   config: split PVRDMA from RDMA (2018-08-18 18:01:34 +0300)
>
> ----------------------------------------------------------------
> Various pvrdma fixes
> Split pvrdma from rdma in config
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
