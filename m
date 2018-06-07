Received: from eggs.gnu.org ([2001:4830:134:3::10]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fQuwf-0001cy-T9
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davidsondfgl@gmail.com>) id 1fQuwf-0007LQ-79
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:27:17 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:37131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <davidsondfgl@gmail.com>)
	id 1fQuwe-0007KE-VN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:27:17 -0400
Received: by mail-lf0-x233.google.com with SMTP id g21-v6so12721612lfb.4
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 06:27:16 -0700 (PDT)
MIME-Version: 1.0
From: Davidson Francis <davidsondfgl@gmail.com>
Date: Thu, 7 Jun 2018 10:27:04 -0300
Message-ID: <CALAE4RoMmLDrSkvBUPhp-pCddbb-j1unXee3vPcUzbT1_q_G-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] OpenRISC: SMP support for more than 2 cores
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

Dear all,

Currently Qemu supports only 2 cores when SMP enabled for or1k architecure, so
I would like to know if there is a quick way to increase the number of cores by
changing a few lines of code or to accomplish this, will requires significant
changes in the source code?

I'm asking because I'll start working with the SMP feature and
it would be great to use Qemu with more than two cores.

Kind regards,
Davidson Francis.
