Received: from eggs.gnu.org ([2001:4830:134:3::10]:34476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz12Y-000462-T3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz12T-0002cE-A1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz12T-0002a5-4J
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 09:45:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2240D883C8
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 13:45:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 15:45:35 +0200
Message-Id: <20171002134538.23332-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] hmp-commands-info: Texinfo fixes
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

Markus Armbruster (3):
  hmp-commands-info: Fix "info rocker-FOO" misspellings
  hmp-commands-info: Move Texinfo stanzas to conventional place
  hmp-commands-info: Change "@findex FOO" to "@findex info FOO"

 hmp-commands-info.hx | 138 +++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

-- 
2.13.6
