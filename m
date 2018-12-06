Received: from eggs.gnu.org ([2001:4830:134:3::10]:47474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUsgD-0000t6-IZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUsg9-0007nb-C4
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:22:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gUsg9-0007n8-5p
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:22:53 -0500
Date: Thu, 6 Dec 2018 17:52:44 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <nycvar.YSQ.7.76.1812061734090.2113@xnncv>
Message-ID: <nycvar.YSQ.7.76.1812061751290.2113@xnncv>
References: <20181206084816.30485-1-ppandit@redhat.com>
	<20181206105830.43eb1d05@redhat.com>
	<nycvar.YSQ.7.76.1812061637070.2113@xnncv>
	<CAFEAcA90U=8s=f-pcFS+8VF3GZby__GnwXy_van=FxiE7fK7gQ@mail.gmail.com>
	<CAFEAcA9N9sqi4fSp1epPdCV7PkqXpZK4kyoHErvfx3hwcN3kag@mail.gmail.com>
	<nycvar.YSQ.7.76.1812061734090.2113@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, public@hansmi.ch, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

+-- On Thu, 6 Dec 2018, P J P wrote --+
| | to clarify that this is a serious bug but also that it's
| | not one that will be affecting anybody's production systems.
| 
| Okay, preparing patch v2...

Sent revised patch
  [PATCH v1] i2c: pm_smbus: check smb_index before block transfer write

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
