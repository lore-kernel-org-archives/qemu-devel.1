Received: from eggs.gnu.org ([2001:4830:134:3::10]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCfU-0008Pj-1N
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHCfT-0008TB-A7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:49:08 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:41075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHCfT-0008Sf-6P
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 12:49:07 -0500
Received: by mail-oi0-x22e.google.com with SMTP id h81so9098159oib.8
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 09:49:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171121170350.31290-1-jcody@redhat.com>
References: <20171121170350.31290-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 17:48:46 +0000
Message-ID: <CAFEAcA-tERRGJUgtR9cHwfF=+6qr2mD3A0mP_DocCoV9u2FMAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Late blockjob / coroutine patches for
 -rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 21 November 2017 at 17:03, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit 7c3d1917fd7a3de906170fa3d6d3d4c5918b1e49:
>
>   build: disarm the TCG unit test trap (2017-11-21 15:42:47 +0000)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to d975301dc8ae56fb3154348878e47a6211843c0b:
>
>   qemu-iotest: add test for blockjob coroutine race condition (2017-11-21 11:58:12 -0500)
>
> ----------------------------------------------------------------
> Late fix for blockjob / coroutine segfaults w/iothreads
> ----------------------------------------------------------------
>

Applied, thanks.

-- PMM
