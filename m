Received: from eggs.gnu.org ([2001:4830:134:3::10]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGYI6-0002mR-A1
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 17:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGYI1-00082W-O1
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 17:42:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eGYI1-00082F-H4
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 17:42:13 -0500
Date: Sun, 19 Nov 2017 20:42:07 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171119224207.GA7484@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] qemu.org vs qemu-project.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi,

I've noticed that README, MAINTAINERS .gitmodules, and other
files in qemu.git are pointing to qemu-project.org, while the
QEMU web site and other files in qemu.git are pointing to
qemu.org.

I assume that the situation mentioned in commit
8593898109 ("Use qemu-project.org domain name") has improved.
Should we update the existing files to point to qemu.org, now?

-- 
Eduardo
