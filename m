Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31Qr-0006hN-1Y
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d31Qp-0002j8-TO
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:27:09 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:33680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d31Qp-0002iW-L6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 10:27:07 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i137so11762385wmf.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:27:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493120560-117434-1-git-send-email-agraf@suse.de>
References: <1493120560-117434-1-git-send-email-agraf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 15:26:46 +0100
Message-ID: <CAFEAcA901a-SM3NBR5p6d5gj2zTPch3iLbOvphpgXjKDv4jqEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] s390 patch queue 2017-04-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Graf <agraf@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 April 2017 at 12:42, Alexander Graf <agraf@suse.de> wrote:
> Hi Peter,
>
> This is my current patch queue for s390.  Please pull.
>
> Alex
>
>
> The following changes since commit f4b5b021c847669b1c78050aea26fe9abceef6dd:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2017-04-25 09:21:54 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/agraf/qemu.git tags/signed-s390-for-upstream
>
> for you to fetch changes up to 2cf9953beebd194a432ebd567399807d9b1f6a4d:
>
>   s390x/misc_helper.c: wrap s390_virtio_hypercall in BQL (2017-04-25 13:39:43 +0200)
>
> ----------------------------------------------------------------
> Patch queue for s390 - 2017-04-25
>
> Two simple fixes this time around:
>
>   - fix BQL for s390 virtio target
>   - Fix SIGP emulation
>
Applied, thanks.

-- PMM
