Received: from eggs.gnu.org ([2001:4830:134:3::10]:39318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cfie9-0005br-RD
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 02:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cfie6-0000BO-PY
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 02:44:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cfie6-0000BB-Js
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 02:44:30 -0500
Date: Mon, 20 Feb 2017 13:14:21 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA9B4s0_7yBCG3Jraym_NABWZhk6JQ10sb95waQgN-YCuA@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702201313310.21397@wniryva>
References: <20170214185225.7994-1-ppandit@redhat.com>
	<20170214185225.7994-3-ppandit@redhat.com>
	<CAKmqyKPWncbASv=VD1YAzKokEHxdOVse+G41XNmv5LUwy-kfUQ@mail.gmail.com>
	<alpine.LFD.2.20.1702151024310.11222@wniryva>
	<CAFEAcA9B4s0_7yBCG3Jraym_NABWZhk6JQ10sb95waQgN-YCuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v4 2/4] sd: sdhci: check transfer mode
 register in multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

+-- On Fri, 17 Feb 2017, Peter Maydell wrote --+
| Alistair's point is that when you resend a patchset where some patches have 
| got reviews/acks and those patches haven't changed significantly, you should 
| include the Reviewed-by: or Acked-by: tags in the commit messages on the 
| resent patches, so that people know they don't need to reexamine those 
| patches.

  Ah okay, noted; Will do.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
