Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d868m-0008FC-03
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d868l-0000Yo-9D
	for qemu-devel@nongnu.org; Tue, 09 May 2017 10:29:27 -0400
From: Thomas Huth <thuth@redhat.com>
Message-ID: <27a960b7-1d4d-a430-46f3-5c12e2e29893@redhat.com>
Date: Tue, 9 May 2017 16:29:16 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Strange location of the "qemu-ga Invocation" chapter
 in the qemu-doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>

 Hi all,

I noticed that the "qemu-ga Invocation" chapter in the QEMU doc is in a
strange location - it's a sub-chapter of the "Disk images" chapter.
Since the guest agent is not directly related to the handling of disk
images, that sounds somewhat wrong to me - or do I miss something?
Does anybody have a suggestion for a better location?

 Thomas
