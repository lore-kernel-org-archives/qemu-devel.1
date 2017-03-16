Received: from eggs.gnu.org ([2001:4830:134:3::10]:37614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coU4g-0000do-Pl
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coU4d-0003vF-Ip
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:00:10 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:35438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1coU4d-0003tk-BF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:00:07 -0400
Received: by mail-lf0-x22c.google.com with SMTP id j90so19171429lfk.2
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:00:07 -0700 (PDT)
Received: from localhost.localdomain (89-77-183-36.dynamic.chello.pl.
	[89.77.183.36])
	by smtp.gmail.com with ESMTPSA id l23sm882684lfk.27.2017.03.16.05.00.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Mar 2017 05:00:04 -0700 (PDT)
From: iwona260909@gmail.com
Date: Thu, 16 Mar 2017 12:59:30 +0100
Message-Id: <20170316115931.11615-1-iwona260909@gmail.com>
Subject: [Qemu-devel] Dead code removal: removing code for unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org


This time I looked for it in the mailing list archives, so I hope it wasn't done. It is removing code for DEPTH != 32, one of Bite Sized Tasks.
