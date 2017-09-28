Received: from eggs.gnu.org ([2001:4830:134:3::10]:52384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dxdZE-000608-KA
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dxdZ9-0008JD-3z
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:29:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dxdZ8-0008IZ-Tw
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 14:29:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2970C144F05
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 18:29:41 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6f84eb7d-6c81-f543-155c-659fd0eb5a5c@redhat.com>
Date: Thu, 28 Sep 2017 20:29:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] List-Id change
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: Jeffrey Cody <jcody@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Hi,

the List-Id field of recent messages reflected by qemu-devel is no longer

  <qemu-devel.nongnu.org>
              ^^^^^^

like it used to be, but

  <qemu-devel.gnu.org>
              ^^^

This broke my qemu-devel filter (albeit easy enough to fix).

Has this been an intentional change in the list software config?

Thanks!
Laszlo
