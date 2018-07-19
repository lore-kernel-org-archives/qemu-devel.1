Received: from eggs.gnu.org ([2001:4830:134:3::10]:35262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBHI-0001lS-CF
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgBHH-0003t5-IG
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:55:40 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:37151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgBHH-0003so-CU
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 11:55:39 -0400
Received: by mail-oi0-x236.google.com with SMTP id k81-v6so15859729oib.4
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 08:55:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180719142843.30230-1-stefanha@redhat.com>
References: <20180719142843.30230-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 16:55:18 +0100
Message-ID: <CAFEAcA_jyx_3Rdh1-cFJUd60gdot3=O+Z0L=NZ1ZttDhJO+mjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-v3.0 0/1] Block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

On 19 July 2018 at 15:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> The following changes since commit ea6abffa8a08d832feb759d359d5b935e3087cf7:
>
>   Update version for v3.0.0-rc1 release (2018-07-17 18:15:19 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 6fccbb475bc6effc313ee9481726a1748b6dae57:
>
>   throttle-groups: fix hang when group member leaves (2018-07-19 13:08:26 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> This fix prevents hangs when a drive leaves a throttling group.
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (1):
>   throttle-groups: fix hang when group member leaves
>
>  block/throttle-groups.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- PMM
