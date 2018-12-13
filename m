Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXQK6-0004cs-6l
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gXQK1-00022X-1z
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gXQK0-0001xI-PI
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:42:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13D873082211
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 12:42:32 +0000 (UTC)
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Thu, 13 Dec 2018 13:42:21 +0100
Message-Id: <20181213124224.31585-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Update deprecation notes for QMP 'cpu-add'
 & HMP 'cpu_add'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, thuth@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>


Kashyap Chamarthy (3):
  qemu-deprecated.texi: Rename the HMP section
  Update that HMP 'cpu_add' is deprecated in 4.0
  Mention that QMP 'cpu-add' will be deprecated

 qemu-deprecated.texi | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.17.2
