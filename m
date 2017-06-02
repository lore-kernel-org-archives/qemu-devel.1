Received: from eggs.gnu.org ([2001:4830:134:3::10]:34824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGmJ3-0000J8-9o
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dGmJ2-000486-Bj
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:07:57 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dGmJ2-00047n-4L
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 09:07:56 -0400
Received: by mail-wr0-x234.google.com with SMTP id v111so131974wrc.3
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 06:07:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496405055-29906-1-git-send-email-peter.maydell@linaro.org>
References: <1496405055-29906-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2017 14:07:34 +0100
Message-ID: <CAFEAcA_2wDi3njNgvbQr5jyoK+BiJO4v4GT-z3vMYfpwz3wvXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/25] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 2 June 2017 at 13:04, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Dropped the tmp421 patch and the following patch that
> depended on it; no other changes.
>
> thanks
> -- PMM
>
> The following changes since commit 43771d5d92312504305c19abe29ec5bfabd55f01:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-05-31' into staging (2017-06-01 16:39:16 +0100)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20170602
>
> for you to fetch changes up to c7637c04be257968e6df30de961a6a23a0ac3dd8:
>
>   hw/arm/virt: fdt: generate distance-map when needed (2017-06-02 11:51:49 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * virt: numa: provide ACPI distance info when needed
>  * aspeed: fix i2c controller bugs
>  * M profile: support MPU
>  * gicv3: fix mishandling of BPR1, VBPR1
>  * load_uboot_image: don't assume a full header read
>  * libvixl: Correct build failures on NetBSD
>

Applied, thanks.

-- PMM
