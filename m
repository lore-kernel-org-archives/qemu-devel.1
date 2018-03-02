Received: from eggs.gnu.org ([2001:4830:134:3::10]:37491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erolv-0002Nq-8y
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erolu-0004UJ-HX
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:47:07 -0500
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:40421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erolu-0004Tz-Bw
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 12:47:06 -0500
Received: by mail-ot0-x231.google.com with SMTP id l12so9433903otj.7
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 09:47:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKP7QWG+QXYUaAYsSg0KAP1xLeT=i44OKex8G0DcxSqDqg@mail.gmail.com>
References: <cover.1520010339.git.alistair.francis@xilinx.com>
	<94eef4a24e618d73f9f23a88dd270123d48954d4.1520010339.git.alistair.francis@xilinx.com>
	<CAFEAcA-P9R-4epwwx-ccPrkJxJDRZ9G-FErnLDEdD8PsDH3uSw@mail.gmail.com>
	<CAKmqyKP7QWG+QXYUaAYsSg0KAP1xLeT=i44OKex8G0DcxSqDqg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 17:46:45 +0000
Message-ID: <CAFEAcA-Pia9UFRAtCaqwWxcQyaRSNhvvXsxsLf=isUiTL_ApOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target/arm: Add a cluster size
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 17:35, Alistair Francis <alistair.francis@xilinx.com> wrote:
> Ok will fix. I'll send a V2 out straight away, as today is my last day
> and it'd be great if I could get this done.

Sure -- if there are any further nits in v2 I'll just fix them
up when I put it into target-arm.next.

-- PMM
