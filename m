Received: from eggs.gnu.org ([2001:4830:134:3::10]:50808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0RxD-0006sb-T9
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0Rx9-0000q2-EY
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:14:27 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:42042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0Rx9-0000pR-9V
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 09:14:23 -0400
Received: by mail-oi0-x22a.google.com with SMTP id l190-v6so7747406oig.9
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Mar 2018 14:14:01 +0100
Message-ID: <CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 March 2018 at 08:00, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 7b1db0908d88f0c9cfac24e214ff72a860692e23:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180323' into staging (2018-03-25 13:51:33 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 7587855cd23755a7a6bd01b026611465f5584ecd:
>
>   net/vde: print error on vde_open() failure (2018-03-26 14:52:43 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Greg Kurz (1):
>       virtio_net: flush uncompleted TX on reset
>
> Julia Suvorova via Qemu-devel (1):
>       net/vde: print error on vde_open() failure

Applied, thanks.

-- PMM
