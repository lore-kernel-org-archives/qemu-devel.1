Received: from eggs.gnu.org ([2001:4830:134:3::10]:41718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPSyR-0006mA-W6
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gPSlP-0004Wo-Jd
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:42:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gPSlP-0004WS-Eq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:41:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 129A8C0BFBBA
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:41:54 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 21 Nov 2018 08:41:50 -0500
Message-Id: <20181121134151.23993-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/1] Acceptance tests: add test for
 set-numa-node error handler fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>

This cover letter does nothing but provides hopefully useful
references to reviewers.  More information on the patch itself.

Git Info:
  - URI: https://github.com/clebergnu/qemu/tree/sent/set-numa-node
  - Remote: https://github.com/clebergnu/qemu
  - Branch: sent/set-numa-node

Travis CI Info:
  - Build: https://travis-ci.org/clebergnu/qemu/builds/457721153
  - Execution results for tests updated on this series:
    * https://travis-ci.org/clebergnu/qemu/jobs/457721176#L2051
    * https://travis-ci.org/clebergnu/qemu/jobs/457721176#L2052

Cleber Rosa (1):
  Acceptance tests: add test for set-numa-node error handler fix

 tests/acceptance/set_numa_node.py | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 tests/acceptance/set_numa_node.py

--=20
2.19.1
