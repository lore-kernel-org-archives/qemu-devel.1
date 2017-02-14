Received: from eggs.gnu.org ([2001:4830:134:3::10]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdabb-00073f-C4
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdabY-000510-BZ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:45:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdabY-0004zP-6I
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:45:04 -0500
Date: Tue, 14 Feb 2017 16:14:55 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA-cnpn321oTvxPXAx55ngztojr=Q6KKTEcgKTvfDV8f8Q@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702141551490.25875@wniryva>
References: <20170214062242.26124-1-ppandit@redhat.com>
	<CAFEAcA-cnpn321oTvxPXAx55ngztojr=Q6KKTEcgKTvfDV8f8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

+-- On Tue, 14 Feb 2017, Peter Maydell wrote --+
| What has happened to the other patches that were in this patchset in v3 ?

v3 1/4
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02776.html

v3 3/4
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02775.html

These two are acked.


v3 2/4
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02846.html
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02844.html

v3 4/4
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02380.html
  -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg01568.html

These two were acked with few changes, which are incorporated in the second 
link above. Acks pending.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
