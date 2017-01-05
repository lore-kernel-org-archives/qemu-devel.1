Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP7P7-0007zQ-5n
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP7P6-0001eI-4v
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:44:25 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:36283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cP7P5-0001cS-Tc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:44:24 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 88so371568804uaq.3
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 04:44:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 12:44:01 +0000
Message-ID: <CAFEAcA-n7TW1ndYmEQGfCTX3JXXcjAvs+X6dQDJhZV9zbUB1iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/13] 9p patches 20170104
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 4 January 2017 at 08:21, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit dbe2b65566e76d3c3a0c3358285c0336ac61e757:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2016-12-28 17:11:11 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/for-upstream
>
> for you to fetch changes up to a37c07022b44e4fc29238deca7588406d081e6c2:
>
>   tests: virtio-9p: ".." cannot be used to walk out of the shared directory (2017-01-03 17:28:44 +0100)
>
> ----------------------------------------------------------------
> - transport specific callbacks (for Xen)
> - fix crash (2.8 regression)
> - 9p functional tests
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
