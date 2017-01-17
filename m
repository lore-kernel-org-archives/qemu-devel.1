Received: from eggs.gnu.org ([2001:4830:134:3::10]:50358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1cTZ0g-0004sp-H5
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anonym@riseup.net>) id 1cTZ0b-0002Kq-Nu
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:01:34 -0500
Received: from mx1.riseup.net ([198.252.153.129]:35960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anonym@riseup.net>) id 1cTZ0b-0002Jr-Eg
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 14:01:29 -0500
Received: from piha.riseup.net (unknown [10.0.1.163])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.riseup.net",
	Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
	by mx1.riseup.net (Postfix) with ESMTPS id A75061A23E7
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 19:01:27 +0000 (UTC)
From: anonym@riseup.net
Date: Tue, 17 Jan 2017 20:00:55 +0100
Message-Id: <20170117190056.1195-1-anonym@riseup.net>
Subject: [Qemu-devel] [PATCH] xhci: bump the link TRB cycle detection limit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi!

[Please keep me Cc:ed as I am not subscribed to this list!]

It seems the fix of CVE-2016-8576 (commit 05f43d4) introduced a regression in QEMU 2.8.

Cheers!
