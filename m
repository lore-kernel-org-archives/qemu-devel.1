Received: from eggs.gnu.org ([2001:4830:134:3::10]:53856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePVV2-0000Yp-AJ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ePVV1-0005Ml-EQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:32:40 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:46866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ePVV1-0005MU-8M
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:32:39 -0500
Received: by mail-ot0-x229.google.com with SMTP id j2so5227628ota.13
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 07:32:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
References: <1513188761-20784-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2017 15:32:17 +0000
Message-ID: <CAFEAcA8o4V4doXo1iCiROk98S03bqsi8P6jdX6uooRxUxRpwUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/43] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 13 December 2017 at 18:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> First arm pullreq for the 2.12 cycle, with all the
> things that queued up during the release phase.
> 2.11 isn't quite released yet, but might as well put
> the pullreq on the mailing list :-)
>
> thanks
> -- PMM
>
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
>
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171213
>
> for you to fetch changes up to d3c348b6e3af3598bfcb755d59f8f4de80a2228a:
>
>   xilinx_spips: Use memset instead of a for loop to zero registers (2017-12-13 17:59:26 +0000)
>

Applied, thanks.

-- PMM
