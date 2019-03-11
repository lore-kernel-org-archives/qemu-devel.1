Received: from eggs.gnu.org ([209.51.188.92]:36891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3OXR-0008El-0m
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3OXQ-0002Za-3b
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:16:32 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:40614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3OXP-0002YY-R7
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:16:32 -0400
Received: by mail-ot1-x329.google.com with SMTP id v20so4654779otk.7
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190311090322.21603-1-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 17:16:19 +0000
Message-ID: <CAFEAcA8yoQgOTnM2R3p0rEv185Z9EZ-iG_cSXUxtGOyzPCp-5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] final s390x patches for 4.0 soft
 freeze
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

On Mon, 11 Mar 2019 at 09:03, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit e2a18635a400b0e68679614132e9ef6316105590:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-03-08' into staging (2019-03-09 20:55:44 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190311
>
> for you to fetch changes up to 2c7590c8ea90a7fbe1efcac90cdfdb8017c1b365:
>
>   s390x/tcg: Implement VECTOR UNPACK * (2019-03-11 09:31:01 +0100)
>
> ----------------------------------------------------------------
> s390x update:
> - clean up LowCore definition
> - first part of vector instruction support for tcg
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
