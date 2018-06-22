Received: from eggs.gnu.org ([2001:4830:134:3::10]:38117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWOcW-0004kQ-Sm
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWOcV-0000HW-Vo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:09:08 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:34621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWOcV-0000HI-QZ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 12:09:07 -0400
Received: by mail-ot0-x233.google.com with SMTP id r18-v6so8089079otk.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 09:09:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 17:08:46 +0100
Message-ID: <CAFEAcA9aMKOorTbYcrPj9RmfBP9wLY7TvHK_Pdewq8BTivcwnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/28] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 22 June 2018 at 13:56, Peter Maydell <peter.maydell@linaro.org> wrote:
> Arm queue. I still have a lot of stuff in my to-review queue, so
> won't be long til the next one.
>
> I've thrown in a couple of minor non-arm patches (a xen code
> cleanup and a vl.c codestyle issue).
>
> thanks
> -- PMM
>
> The following changes since commit de44c044420d1139480fa50c2d5be19223391218:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-tcg-testing-revivial-210618-2' into staging (2018-06-22 10:57:47 +0100)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180622
>
> for you to fetch changes up to 6dad8260e82b69bd278685ee25209f5824360455:
>
>   xen: Don't use memory_region_init_ram_nomigrate() in pci_assign_dev_load_option_rom() (2018-06-22 13:28:42 +0100)
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
