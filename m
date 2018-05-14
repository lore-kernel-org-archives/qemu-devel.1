Received: from eggs.gnu.org ([2001:4830:134:3::10]:48483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIHfR-00067x-LL
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIHfQ-0006l2-Qh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:53:49 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIHfQ-0006k3-LJ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 13:53:48 -0400
Received: by mail-ot0-x244.google.com with SMTP id m11-v6so15311098otf.3
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 10:53:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180512092824.13848-1-stefanha@redhat.com>
References: <20180512092824.13848-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 May 2018 18:53:27 +0100
Message-ID: <CAFEAcA83StQKpnuDyF2xCh+OrTZ7xdtrsQB+R==4x3y7qq-40Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 12 May 2018 at 10:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 31be8a2a97ecba7d31a82932286489cac318e9e9:
>
>   block/file-posix: add x-check-page-cache=on|off option (2018-05-11 16:43:05 +0100)
>
> ----------------------------------------------------------------
> Block pull request
>
>  * Support -drive cache.direct=off live migration for POSIX files
>

Applied, thanks.

-- PMM
