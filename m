Received: from eggs.gnu.org ([2001:4830:134:3::10]:56873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYqVF-0000Ba-73
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYqVE-0000Ew-BA
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:47:29 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:41440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYqVE-0000En-4l
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 04:47:28 -0500
Received: by mail-oi0-x22d.google.com with SMTP id n81so6353782oig.8
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 01:47:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 09:47:06 +0000
Message-ID: <CAFEAcA9vtVJi=HYEp5aiFuLsHUTqioNW=veC9o7zKfcLSJMjgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] 9p patches for 2.12 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 January 2018 at 14:28, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 8671016261cd5dfba1042aef0a632a77b0d387a2:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-01-08 09:15:42 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to ffcfb446db1776198a3fe02b75bfecfa1d0b7ab3:
>
>   MAINTAINERS: Drop Aneesh as 9pfs maintainer (2018-01-08 11:18:23 +0100)
>
> ----------------------------------------------------------------
> - Aneesh no longer listed in MAINTAINERS,
> - deprecation of the handle backend,
> - improved error reporting, especially when the local backend fails to
>   open the VirtFS root,
> - virtio-9p-test to behave more like a real virtio guest driver: set
>   DRIVER_OK when ready to use the device and process the used ring
>   for completed requests,
> - cosmetic fixes (mostly coding style related).
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
