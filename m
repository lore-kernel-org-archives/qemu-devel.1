Received: from eggs.gnu.org ([2001:4830:134:3::10]:37712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdbEe-0002Hz-EU
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1cdbEZ-0001mz-Hp
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:25:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1cdbEZ-0001mX-Bw
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 06:25:23 -0500
Date: Tue, 14 Feb 2017 16:55:16 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA_gBtVecZv8FW2Z2TN21Q2MCT=DcLpEjeSV+U3r_Hi5CQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1702141653500.32051@wniryva>
References: <20170214062242.26124-1-ppandit@redhat.com>
	<CAFEAcA-cnpn321oTvxPXAx55ngztojr=Q6KKTEcgKTvfDV8f8Q@mail.gmail.com>
	<alpine.LFD.2.20.1702141551490.25875@wniryva>
	<CAFEAcA-4AUMocZJgxEkR5khYvjKzfwMZTZQavyEBE-K32L2oUQ@mail.gmail.com>
	<alpine.LFD.2.20.1702141629580.25875@wniryva>
	<CAFEAcA_gBtVecZv8FW2Z2TN21Q2MCT=DcLpEjeSV+U3r_Hi5CQ@mail.gmail.com>
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

  Hello Petr,

+-- On Tue, 14 Feb 2017, Peter Maydell wrote --+
| Yes, exactly. (We document this in 
| http://wiki.qemu-project.org/Contribute/SubmitAPatch#Participating_in_Code_Review 
| but of course that page is huge...)

  Right, okay. I'll resend the patch set later today.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
