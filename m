Received: from eggs.gnu.org ([2001:4830:134:3::10]:47715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdacV-0007w0-S0
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:46:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdacU-0005pa-GE
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:46:03 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdacU-0005p7-8C
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:46:02 -0500
Received: by mail-wm0-x22a.google.com with SMTP id c85so14354937wmi.1
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 02:46:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1702141551490.25875@wniryva>
References: <20170214062242.26124-1-ppandit@redhat.com>
	<CAFEAcA-cnpn321oTvxPXAx55ngztojr=Q6KKTEcgKTvfDV8f8Q@mail.gmail.com>
	<alpine.LFD.2.20.1702141551490.25875@wniryva>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 10:45:40 +0000
Message-ID: <CAFEAcA-4AUMocZJgxEkR5khYvjKzfwMZTZQavyEBE-K32L2oUQ@mail.gmail.com>
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

On 14 February 2017 at 10:44, P J P <ppandit@redhat.com> wrote:
> +-- On Tue, 14 Feb 2017, Peter Maydell wrote --+
> | What has happened to the other patches that were in this patchset in v3 ?
>
> v3 1/4
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02776.html
>
> v3 3/4
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02775.html
>
> These two are acked.
>
>
> v3 2/4
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02846.html
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02844.html
>
> v3 4/4
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02380.html
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01568.html
>
> These two were acked with few changes, which are incorporated in the second
> link above. Acks pending.

Please keep sending them as a single series, though. Otherwise I
won't be able to easily apply them in the right order and track
their current status.

thanks
-- PMM
