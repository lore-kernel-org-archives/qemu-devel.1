Received: from eggs.gnu.org ([2001:4830:134:3::10]:46770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emSn3-0003bS-5B
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emSmz-0000kS-4N
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:18:09 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1emSmy-0000kG-Sc
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:18:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 15 Feb 2018 18:17:53 -0500
Message-Id: <1518736676-5994-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 0/3] target/sparc: translator loop conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Tested by booting a NetBSD guest.

Thanks,

		Emilio
