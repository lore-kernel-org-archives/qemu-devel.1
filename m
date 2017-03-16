Received: from eggs.gnu.org ([2001:4830:134:3::10]:46900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coRar-0003vv-Ny
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <iwona260909@gmail.com>) id 1coRam-0008NC-SX
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:13 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:33328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <iwona260909@gmail.com>)
	id 1coRam-0008Ku-KH
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:21:08 -0400
Received: by mail-lf0-x22d.google.com with SMTP id a6so17445251lfa.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 02:21:08 -0700 (PDT)
Received: from localhost.localdomain (89-77-183-36.dynamic.chello.pl.
	[89.77.183.36])
	by smtp.gmail.com with ESMTPSA id 9sm806381ljn.1.2017.03.16.02.21.04
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Mar 2017 02:21:05 -0700 (PDT)
From: iwona260909@gmail.com
Date: Thu, 16 Mar 2017 10:20:29 +0100
Message-Id: <20170316092030.1685-1-iwona260909@gmail.com>
Subject: [Qemu-devel] [PATCH] Dead Code Removal: removing support for DEPTH
 != 32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org

Removing support for DEPTH != 32 - task from BiteSizedTasks/Dead code removal
