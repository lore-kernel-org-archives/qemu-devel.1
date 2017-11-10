Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eDBjr-0008O6-Lu
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eDBjl-0003Hl-VP
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:01:03 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:51961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eDBjl-0003GU-Nl
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:00:57 -0500
Received: by mail-wm0-x243.google.com with SMTP id b9so3709142wmh.0
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 08:00:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171108081232.28322-1-david@gibson.dropbear.id.au>
References: <20171108081232.28322-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2017 16:00:35 +0000
Message-ID: <CAFEAcA84T-AUDvFYuio+FtxU+hXcG-B9hdhTCUKc6exjk=kSaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] ppc-for-2.11 queue 20171108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On 8 November 2017 at 08:12, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit b0fbe46ad82982b289a44ee2495b59b0bad8a842:
>
>   Update version for v2.11.0-rc0 release (2017-11-07 16:05:28 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171108
>
> for you to fetch changes up to c91c187f715aded9e1ac28412bba41fd3cbaf010:
>
>   e500: ppce500_init_mpic() return device instead of IRQ array (2017-11-08 13:21:37 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-11-08
>
> Here's the current set of accumulated ppc patches for qemu-2.11.
> Since we're now in hard freeze these are all bugfixes (although some
> fix a bug by way of a cleanup).
>

Applied, thanks.

-- PMM
