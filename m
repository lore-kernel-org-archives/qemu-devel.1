Received: from eggs.gnu.org ([2001:4830:134:3::10]:33046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKZZ-00028a-Gj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOKZY-00048j-HQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:12:45 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:44491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOKZY-00048J-BV
	for qemu-devel@nongnu.org; Thu, 31 May 2018 06:12:44 -0400
Received: by mail-ot0-x22e.google.com with SMTP id g7-v6so24652038otj.11
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 03:12:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180530155647.14090-1-kwolf@redhat.com>
References: <20180530155647.14090-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 11:12:23 +0100
Message-ID: <CAFEAcA_us1qBcuiyjuHGs0+OaOVXBhNoDoNFpjyn-vbj4m1pww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Block layer patches
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

On 30 May 2018 at 16:56, Kevin Wolf <kwolf@redhat.com> wrote:
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/xilinx-next-2018-05-29-v1.for-upstream' into staging (2018-05-29 13:01:11 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 3fb588a0f2c006122c34e1960a15c87ae2b927eb:
>
>   block/create: Mark blockdev-create stable (2018-05-30 13:31:18 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - Add blockdev-create job
> - qcow2: Silence Coverity false positive
>

Applied, thanks.

-- PMM
