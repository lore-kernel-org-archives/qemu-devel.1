Received: from eggs.gnu.org ([2001:4830:134:3::10]:33784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ermsd-0005Dg-PE
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:45:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ermsc-0006hH-UO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:45:55 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:45673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ermsc-0006hC-O4
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:45:54 -0500
Received: by mail-oi0-x229.google.com with SMTP id j79so7312355oib.12
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 07:45:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302110640.28004-1-peter.maydell@linaro.org>
References: <20180302110640.28004-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 15:45:33 +0000
Message-ID: <CAFEAcA_21LbTntiYKh=-6tH_JonHJAMW-xGuoh+DL4gwiv-_ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/39] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 11:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> Second pull request of the week; mostly RTH's support for some
> new-in-v8.1/v8.3 instructions, and my v8M board model.
>
> thanks
> -- PMM
>
> The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)
>
> are available in the Git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20180302
>
> for you to fetch changes up to e66a67bf28e1b4fce2e3d72a2610dbd48d9d3078:
>
>   target/arm: Enable ARM_FEATURE_V8_FCMA (2018-03-02 11:03:45 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * implement FCMA and RDM v8.1 and v8.3 instructions
>  * enable Cortex-M33 v8M core, and provide new mps2-an505 board model
>    that uses it
>  * decodetree: Propagate return value from translate subroutines
>  * xlnx-zynqmp: Implement the RTC device
>
Applied, thanks.

-- PMM
