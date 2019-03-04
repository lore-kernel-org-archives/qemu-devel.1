Received: from eggs.gnu.org ([209.51.188.92]:48509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0obJ-0005l6-RZ
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:29:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0obG-00051n-81
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:29:52 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:44906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0obE-00050B-Ef
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 09:29:50 -0500
Received: by mail-oi1-x22d.google.com with SMTP id a81so3947317oii.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 06:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20190304120210.31500-1-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 14:29:34 +0000
Message-ID: <CAFEAcA9kGkU+9PES48hkS-uwEv-zFBZxUbOLK4D8oaQk=dBdSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] s390x updates
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

On Mon, 4 Mar 2019 at 12:02, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 20b084c4b1401b7f8fbc385649d48c67b6f43d44:
>
>   Merge remote-tracking branch 'remotes/cminyard/tags/i2c-for-release-20190228' into staging (2019-03-01 11:20:49 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190304
>
> for you to fetch changes up to df192fbc517a0954dda644282e52ba943e22ec18:
>
>   s390x: Add floating-point extension facility to "qemu" cpu model (2019-03-04 11:49:31 +0100)
>
> ----------------------------------------------------------------
> s390x updates:
> - tcg: support the floating-point extension facility
> - vfio-ap: support hot(un)plug of vfio-ap device
> - fixes + cleanups
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
