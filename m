Received: from eggs.gnu.org ([2001:4830:134:3::10]:38685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coU6A-0001e2-S7
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coU66-0004n3-1x
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:01:42 -0400
Received: from mail-lf0-x22b.google.com ([2a00:1450:4010:c07::22b]:33943)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1coU65-0004mp-R1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:01:37 -0400
Received: by mail-lf0-x22b.google.com with SMTP id z15so19176134lfd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:01:37 -0700 (PDT)
Received: from localhost.localdomain (89-77-183-36.dynamic.chello.pl.
	[89.77.183.36])
	by smtp.gmail.com with ESMTPSA id q98sm888854lfi.11.2017.03.16.05.01.35
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Mar 2017 05:01:35 -0700 (PDT)
From: iwona260909@gmail.com
Date: Thu, 16 Mar 2017 13:01:09 +0100
Message-Id: <20170316120110.11677-1-iwona260909@gmail.com>
Subject: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org


Removing code for unsupproted DEPTH. This time I looked for it in mailing list archive and haven't found, hope it wasn't done.
