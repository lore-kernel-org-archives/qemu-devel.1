Received: from eggs.gnu.org ([2001:4830:134:3::10]:40469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fstwd-0006X6-B9
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fstwc-00045z-E8
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:02:55 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:40853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fstwc-00045Z-6t
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 14:02:54 -0400
Received: by mail-oi0-x241.google.com with SMTP id l202-v6so3906710oig.7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 11:02:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180822034319.686504-1-jcody@redhat.com>
References: <20180822034319.686504-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 19:02:33 +0100
Message-ID: <CAFEAcA8Jxdk35tS0qR=wHXTaJPvcdR-cVdwAdnkTwV95XL8r5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2018 at 04:43, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit ee135aa0428fe5af2af7be04ff16d2b596a9330a:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-3.1-20180821' into staging (2018-08-21 13:27:11 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 26bf474ba92c76e61bea51726e22da6dfd185296:
>
>   block: iotest to catch abort on forced blockjob cancel (2018-08-21 15:20:37 -0400)
>
> ----------------------------------------------------------------
> Block job patches
> ----------------------------------------------------------------
>
> Jeff Cody (2):
>   block: for jobs, do not clear user_paused until after the resume
>   block: iotest to catch abort on forced blockjob cancel

Applied, thanks.

-- PMM
