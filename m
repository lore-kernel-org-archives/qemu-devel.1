Received: from eggs.gnu.org ([2001:4830:134:3::10]:52196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYa1u-0006Aq-QA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYa1p-0008AF-Ai
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:44:22 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:34737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYa1p-00089i-58
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:44:17 -0400
Received: by mail-ot0-x22b.google.com with SMTP id i17-v6so6866486otl.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:44:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627144838.26772-1-stefanha@redhat.com>
References: <20180627144838.26772-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:43:55 +0100
Message-ID: <CAFEAcA97ZTO=wb976mxdsk31=q1pP+7jcH9Jer335qqvNzzvZQ@mail.gmail.com>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On 27 June 2018 at 15:48, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31b1f1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180626' into staging (2018-06-26 18:23:49 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to ed6e2161715c527330f936d44af4c547f25f687e:
>
>   linux-aio: properly bubble up errors from initialization (2018-06-27 13:06:34 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
>  * Gracefully handle Linux AIO init failure
>

Applied, thanks.

-- PMM
