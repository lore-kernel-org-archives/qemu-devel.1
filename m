Received: from eggs.gnu.org ([2001:4830:134:3::10]:56448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdato-0006Xr-Ea
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdatk-0006cC-AD
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:03:56 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdatk-0006bi-4d
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:03:52 -0500
Received: by mail-wr0-x22b.google.com with SMTP id i10so167574437wrb.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 03:03:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1702141629580.25875@wniryva>
References: <20170214062242.26124-1-ppandit@redhat.com>
	<CAFEAcA-cnpn321oTvxPXAx55ngztojr=Q6KKTEcgKTvfDV8f8Q@mail.gmail.com>
	<alpine.LFD.2.20.1702141551490.25875@wniryva>
	<CAFEAcA-4AUMocZJgxEkR5khYvjKzfwMZTZQavyEBE-K32L2oUQ@mail.gmail.com>
	<alpine.LFD.2.20.1702141629580.25875@wniryva>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 11:03:30 +0000
Message-ID: <CAFEAcA_gBtVecZv8FW2Z2TN21Q2MCT=DcLpEjeSV+U3r_Hi5CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4] sd: sdhci: mask transfer mode register
 value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

On 14 February 2017 at 11:02, P J P <ppandit@redhat.com> wrote:
>   Hello Peter,
>
> +-- On Tue, 14 Feb 2017, Peter Maydell wrote --+
> | Please keep sending them as a single series, though. Otherwise I
> | won't be able to easily apply them in the right order and track
> | their current status.
>
>   Okay, got it. Ie. to re-send entire series even for change in one of the
> patches?

Yes, exactly. (We document this in
http://wiki.qemu-project.org/Contribute/SubmitAPatch#Participating_in_Code_Review
but of course that page is huge...)

thanks
-- PMM
