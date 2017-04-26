Received: from eggs.gnu.org ([2001:4830:134:3::10]:53441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d3PEQ-0001X2-GU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1d3PEP-00082y-OW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:51:54 -0400
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:33966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1d3PEP-00082g-J7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 11:51:53 -0400
Received: by mail-oi0-x229.google.com with SMTP id x184so5871762oia.1
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 08:51:53 -0700 (PDT)
MIME-Version: 1.0
From: Pradeep Kiruvale <pradeepkiruvale@gmail.com>
Date: Wed, 26 Apr 2017 17:51:52 +0200
Message-ID: <CAJ2SuL=qbGqwt0JCLOLZ41fLTLwKDb0KjDANLTBTb7uLK+5m-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] VM-Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi All,

Is it possible to enable/disable to migration features on the fly for a
qemu VM?
I mean through qmp interface kind of a interface?

I am asking this because keeping the dirty memory list, this could consume
some
compute and memory. So, the plan is to enable when the VM needs to be
migrated.

Please clarify.

Regards,
Pradeep
