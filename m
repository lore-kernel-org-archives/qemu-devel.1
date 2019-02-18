Received: from eggs.gnu.org ([209.51.188.92]:32911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gvjcL-0004ss-Md
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gvjcJ-0007Hi-Na
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:57 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:44041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gvjcG-00078d-2C
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:09:55 -0500
Received: by mail-ot1-x32b.google.com with SMTP id g1so28353638otj.11
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 06:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20190218111153.22681-1-cohuck@redhat.com>
In-Reply-To: <20190218111153.22681-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Feb 2019 14:09:30 +0000
Message-ID: <CAFEAcA97EXY_nxt5L07vFv56Fd+zrovVko7WEa5-ZfSosSVENQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] s390x update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 18 Feb 2019 at 11:11, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 1e36232994c8ad01774501d2e299deba3a2469af:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20190215' into staging (2019-02-15 11:12:14 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190218
>
> for you to fetch changes up to 0922e8c093a564219fcb7f43b18ceb12714dd931:
>
>   s390x: upgrade status of KVM cores to "supported" (2019-02-18 12:00:44 +0100)
>
> ----------------------------------------------------------------
> s390x updates:
> - tcg: implement STCK and friends for CONFIG_USER_ONLY
> - add zpci to qemu cpu model, as pci is now always built
> - add mepoch to default z14 cpu model
> - add cpu model for z14 GA2
> - various improvements
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
