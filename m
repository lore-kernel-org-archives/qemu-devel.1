Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZeix-0008NV-KC
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZeiw-00028a-QC
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:24:59 -0500
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:42072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZeiw-00026m-H4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 10:24:58 -0500
Received: by mail-oi0-x22e.google.com with SMTP id o64so1845158oia.9
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 07:24:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 15:24:36 +0000
Message-ID: <CAFEAcA_mtzfPB3dc7sfucQrD3vX++FwzF_kQSSDn3_4N1eBRZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 11 January 2018 at 13:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> ARM queue, various patches accumulated over the Christmas break.
>
> -- PMM
>
> The following changes since commit 612061b277915fadd80631eb7a6926f48a110c44:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-10' into staging (2018-01-11 11:52:40 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180111
>
> for you to fetch changes up to 0cf09852015e47a5fbb974ff7ac320366afd21ee:
>
>   hw/intc/arm_gic: reserved register addresses are RAZ/WI (2018-01-11 13:25:40 +0000)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
